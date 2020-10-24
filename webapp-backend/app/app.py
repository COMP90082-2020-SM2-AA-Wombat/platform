from typing import List, Dict
from flask import Flask, request, jsonify, Response,abort,make_response
import requests
import json
import os
from flask_cors import CORS
import pandas as pd
from db import Db
import sys
import math
import MySQLdb
import  mysql.connector
from middleware import auth_decorator 

app = Flask(__name__)
CORS(app)
db = Db()

@app.route('/')
def index() -> str:
    return "hello world"

@app.route("/csv", methods=["POST"])
@auth_decorator()
def csvInjestion() -> str:
    files = request.files
    db.connection.start_transaction()
    order_of_files = {
        "jsons": [],
        "results": [],
        "facilities": []
    }
    try:
        for key in files:
            if key.endswith(".csv"):
                df_csv = pd.read_csv(files[key], dtype=object)
                if "results" in key:
                    order_of_files["results"].append(df_csv)
                elif "facility_stated" in key:
                    order_of_files["facilities"].append(df_csv)
            elif key.endswith(".json"):
                order_of_files["jsons"].append(files[key])
            else:
                return create_error_400("Invalid file. Files must include either: '.json', or csvs with 'results' or 'facility_stated' in the filenames")
        for json in order_of_files["jsons"]:
            process_meta_data(json)
        for results in order_of_files["results"]:
            process_results_csv(results)
        for facilities in order_of_files["facilities"]:
            process_facility_stated_csv(facilities)
        db.connection.commit()
    except mysql.connector.Error as err:
        print(err)
        print("Error Code:", err.errno)
        print("SQLSTATE", err.sqlstate)
        print("Message", err.msg)
        db.connection.rollback()
        return create_error_400(err.msg)
    return make_response({"message": "Successfully added data"}, 200)

def process_results_csv(results_df):
    columns = list(results_df.columns)
    cursor = db.connection.cursor(buffered=True)
    dataToInsert = []
    for _, result in results_df.iterrows():
        valueList = []
        for column in columns:
            if (isinstance(result[column ], float) and math.isnan(result[column ])):
                valueList.append("NULL")
            else:
                valueList.append(result[column])
        dataToInsert.append(tuple(valueList))
    stmt = "INSERT INTO results (" + ", ".join(columns) + ") VALUES ( " + ("%s," * len(columns))[:-1] + ")"
    cursor.executemany(stmt, dataToInsert)
    cursor.close()
    return

def process_facility_stated_csv(f_df):
    columns = list(f_df.columns)
    cursor = db.connection.cursor(buffered=True)
    dataToInsert = []
    for _, result in f_df.iterrows():
        valueList = []
        for column in columns:
            if (isinstance(result[column ], float) and math.isnan(result[column ])):
                valueList.append("NULL")
            else:
                valueList.append(result[column])
        dataToInsert.append(tuple(valueList))
    
    stmt = "INSERT INTO facility_stated (" + ", ".join(columns) + ") VALUES ( " + ("%s," * len(columns))[:-1] + ")"
    print(stmt)
    cursor.executemany(stmt, dataToInsert)
    cursor.close()
    return

def process_meta_data(meta_json):
    meta_data = json.load(meta_json)
    addBulkFields(meta_data, False)
    return

@app.route("/fields", methods=["POST"])
@auth_decorator()
def insert_field():
    updateOrReplace = request.args.get('updateOrReplace') == "true"
    body = request.get_json()
    if necessaryFieldsMissing(body):
        return create_error_400("Missing field: 'table', 'fields' or 'values'")
    cursor = db.connection.cursor(buffered=True)
    try:
        insertTableFields(body, cursor, updateOrReplace)
    except mysql.connector.Error as err:
        print(err)
        print("Error Code:", err.errno)
        print("SQLSTATE", err.sqlstate)
        print("Message", err.msg)
        db.connection.rollback()
        return create_error_400(err.msg)
    return make_response({"message": "Successfully added field data"}, 200)

@app.route("/bulk-fields", methods=["POST"])
@auth_decorator()
def bulk_fields():
    updateOrReplace = request.args.get('updateOrReplace') == "true"
    body = request.get_json()
    db.connection.start_transaction()
    addBulkFields(body, updateOrReplace)
    return make_response({"message": "Successfully added bulk data"}, 200)

def addBulkFields(body, updateOrReplace):
    cursor = db.connection.cursor(buffered=True)

    for item in body:
        if necessaryFieldsMissing(item):
            db.connection.rollback()
            return create_error_400("Missing field: 'table', 'fields' or 'values'")
        try:
            insertTableFields(item, cursor, updateOrReplace)
        except mysql.connector.Error as err:
            print(err)
            print("Error Code:", err.errno)
            print("SQLSTATE", err.sqlstate)
            print("Message", err.msg)
            db.connection.rollback()
            return create_error_400(err.msg)
        
    db.connection.commit()
    return 

@app.route("/bulk-tables", methods=["POST"])
@auth_decorator()
def bulk():
    updateOrReplace = request.args.get('updateOrReplace') == "true"
    body = request.get_json()
    
    if not isinstance(body, list):
        return create_error_400("Invalid Payload")
    db.connection.start_transaction()
    cursor = db.connection.cursor(buffered=True)
    set_of_tables = set()
    list_of_tables = []
    for tableItem in body:
        if not isinstance(tableItem, dict):
            db.connection.rollback()
            return create_error_400("Invalid Payload")
        if ("table" not in tableItem) or ("insertions" not in tableItem):
            db.connection.rollback()
            return create_error_400("Invalid Payload")
        if not isinstance(tableItem["insertions"], list):
            db.connection.rollback()
            return create_error_400("Invalid Payload")
        for insertion in tableItem["insertions"]:
            if necessaryFieldsMissingNotIncludingTable(insertion):
                db.connection.rollback()
                return create_error_400("Missing field: 'fields' or 'values'")
        set_of_tables.add(tableItem["table"])
        list_of_tables.append(tableItem["table"])

    if not (len(list_of_tables) == len(set_of_tables)):
        db.connection.rollback()
        return create_error_400("You put duplicate table insertions")
    for tableItem in body:
        for insertion in tableItem["insertions"]:
            try:    
                insertTableFields({
                    "table": tableItem["table"],
                    "fields": insertion["fields"],
                    "values": insertion["values"]
                }, cursor, updateOrReplace)
            except mysql.connector.Error as err:
                print(err)
                print("Error Code:", err.errno)
                print("SQLSTATE", err.sqlstate)
                print("Message", err.msg)
                db.connection.rollback()
                return create_error_400(err.msg)
    db.connection.commit()
    return make_response({"message": "Successfully added bulk data"}, 200)


def insertTableFields(body, cursor, updateOrReplace):
    vals = ["'" + val + "'" for  val in body["values"]]
    stmt = f'{"REPLACE" if updateOrReplace else "INSERT"} INTO {body["table"]} ({", ".join(body["fields"])}) VALUES ({", ".join(vals)});'
    cursor.execute(stmt)
    return

def necessaryFieldsMissing(body):
    if not isinstance(body, dict):
        return True
    return (not ("fields" in body and isinstance(body["fields"], list)) or not ("values" in body and isinstance(body["values"], list)) or not ("table" in body) or not(len(body["fields"]) == len(body["values"])) )

def necessaryFieldsMissingNotIncludingTable(body):
    if not isinstance(body, dict):
        return True
    return (not ("fields" in body and isinstance(body["fields"], list)) or not ("values" in body and isinstance(body["values"], list))  or not(len(body["fields"]) == len(body["values"])) )

@app.route("/table-fields", methods=["GET"])
@auth_decorator()
def getAllTableAndFields():
    return make_response(db.tableWithFields, 200)


@app.route("/login", methods=["POST"])
def login():
    user_details = request.get_json()
    url = "http://jupyterhub:8000/hub/api/authorizations/token"
    headers = {'content-type': 'application/json'}
    res = requests.post(url, json=user_details, headers=headers)
    if (not res.ok):
        abort(make_response(jsonify(message="Access Forbidden"), 401))
    return make_response(res.json(),200)

def create_error_400(errorMessage):
    abort(make_response(jsonify(message=errorMessage), 400))


if __name__ == '__main__':
    port = int(os.environ.get("PORT", 5000))
    app.run(debug=True,host='0.0.0.0',port=port)

# FLASK_APP=app.py FLASK_ENV=development flask rune
