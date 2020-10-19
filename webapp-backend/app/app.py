from typing import List, Dict
from flask import Flask, request, jsonify, Response
import json
import os
from flask_cors import CORS
import pandas as pd
from db import Db
import sys
import math
import MySQLdb
import  mysql.connector

app = Flask(__name__)
CORS(app)

db = Db()

@app.route('/')
def index() -> str:
    return "hello world"

@app.route("/csv", methods=["POST"])
def csvInjestion() -> str:
    files = request.files
    db.connection.start_transaction()
    try:
        for key in files:
            if key.endswith(".csv"):
                df_csv = pd.read_csv(files[key], dtype=object)
                if "results" in key:
                    print("hel;lo")
                    process_results_csv(df_csv)
                elif "facility_stated" in key:
                    process_facility_stated_csv(df_csv)
            elif key.endswith(".json"):
                process_meta_data(files[key])
            else:
                print("invalid")
        db.connection.commit()
    except mysql.connector.Error as err:
        print(err)
        print("Error Code:", err.errno)
        print("SQLSTATE", err.sqlstate)
        print("Message", err.msg)
        db.connection.rollback()
        return err.msg
    return "hellsasasdao asdworld"

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
    stmt = "INSERT IGNORE INTO results (" + ", ".join(columns) + ") VALUES ( " + ("%s," * len(columns))[:-1] + ")"
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
    print(dataToInsert)
    cursor.executemany(stmt, dataToInsert)
    cursor.close()
    return

def process_meta_data(meta_json):
    meta_data = json.load(meta_json)
    print(meta_data)
    return addBulkFields(meta_data, False)


@app.route("/fields", methods=["POST"])
def insert_field():
    updateOrReplace = request.args.get('updateOrReplace') == "true"
    body = request.get_json()
    if necessaryFieldsMissing(body):
        return "failed"
    cursor = db.connection.cursor(buffered=True)
    try:
        insertTableFields(body, cursor, updateOrReplace)
    except mysql.connector.Error as err:
        print(err)
        print("Error Code:", err.errno)
        print("SQLSTATE", err.sqlstate)
        print("Message", err.msg)
        db.connection.rollback()
        resp = Response(json.dumps({
            "message":err.msg}), mimetype='application/json')
        resp.status_code = 400
        return resp
    return "hello"

@app.route("/bulk-fields", methods=["POST"])
def bulk_fields():
    updateOrReplace = request.args.get('updateOrReplace') == "true"
    body = request.get_json()
    db.connection.start_transaction()

    return addBulkFields(body, updateOrReplace)

def addBulkFields(body, updateOrReplace):
    print("asd")
    cursor = db.connection.cursor(buffered=True)
    set_of_tables = set()
    list_of_tables = []
    for item in body:
        print(item)
        if necessaryFieldsMissing(item):
            db.connection.rollback()
            resp = Response(json.dumps({
            "message":"Fields missing. Make sure you are using the correct payload"}), mimetype='application/json')
            resp.status_code = 400
            print("asddaddd")
            return resp
        set_of_tables.add(item["table"])
        list_of_tables.append(item["table"])
    if not (len(list_of_tables) == len(set_of_tables)):
        db.connection.rollback()
        return "You put duplicate table insertions"

    print(body)
    for item in body:
        try:
            insertTableFields(item, cursor, updateOrReplace)
        except mysql.connector.Error as err:
            print(err)
            print("Error Code:", err.errno)
            print("SQLSTATE", err.sqlstate)
            print("Message", err.msg)
            db.connection.rollback()
            return err.msg
        
    db.connection.commit()
    return "donzo"

@app.route("/bulk-tables", methods=["POST"])
def bulk():
    updateOrReplace = request.args.get('updateOrReplace') == "true"
    body = request.get_json()
    
    if not isinstance(body, list):
        return "failed"
    db.connection.start_transaction()
    cursor = db.connection.cursor(buffered=True)
    set_of_tables = set()
    list_of_tables = []
    for tableItem in body:
        if not isinstance(tableItem, dict):
            db.connection.rollback()
            return "Incorrect format"
        if ("table" not in tableItem) or ("insertions" not in tableItem):
            db.connection.rollback()
            return "Incorrect format"
        if not isinstance(tableItem["insertions"], list):
            db.connection.rollback()
            return "Incorrect format"
        for insertion in tableItem["insertions"]:
            if necessaryFieldsMissingNotIncludingTable(insertion):
                db.connection.rollback()
                return "Incorrect format" 
        set_of_tables.add(tableItem["table"])
        list_of_tables.append(tableItem["table"])

    if not (len(list_of_tables) == len(set_of_tables)):
        db.connection.rollback()
        return "You put duplicate table insertions"
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
                return err.msg
    db.connection.commit()
    return "donzo"


def insertTableFields(body, cursor, updateOrReplace):
    vals = ["'" + val + "'" for  val in body["values"]]
    stmt = f'{"REPLACE" if updateOrReplace else "INSERT"} INTO {body["table"]} ({", ".join(body["fields"])}) VALUES ({", ".join(vals)});'
    print(stmt)
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
def getAllTableAndFields():
    return db.tableWithFields



if __name__ == '__main__':
    port = int(os.environ.get("PORT", 5000))
    app.run(debug=True,host='0.0.0.0',port=port)

# FLASK_APP=app.py FLASK_ENV=development flask rune