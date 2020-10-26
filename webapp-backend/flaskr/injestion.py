from flask import Flask, request, jsonify, Response, abort, make_response, Blueprint, g, flash
from json import dumps
from flaskr.db import get_db
import sys
import math
import MySQLdb
import  mysql.connector
import pandas as pd
from flaskr.auth import auth_decorator

bp = Blueprint("injestion", __name__)

@bp.route("/")
def index():
    return "Welcome to injestion"

@bp.route("/table-fields", methods=["GET"])
@auth_decorator()
def getAllTableAndFields():
    from collections import defaultdict
    connection = get_db()
    cursor = connection.cursor(buffered=True)
    db_cursor = connection.cursor(buffered=True)
    db_cursor.execute("SELECT DATABASE();")
    db_name = db_cursor.fetchone()[0]
    cursor.execute("SHOW TABLES")

    tableWithFields = defaultdict(lambda : [])
    for (table,) in cursor.fetchall():
        attrCursor = connection.cursor(buffered=True)
        attrCursor.execute(f'SHOW COLUMNS FROM {db_name}.{table};')

        for columnDetails in attrCursor.fetchall():
            tableWithFields[table].append({
                "field":columnDetails[0],
                "type":columnDetails[1].decode('UTF-8')
            })
        attrCursor.close()

    return make_response(tableWithFields, 200)

@bp.route("/fields", methods=["POST"])
@auth_decorator()
def insert_field():
    updateOrReplace = request.args.get('updateOrReplace') == "true"
    body = request.get_json()
    if necessaryFieldsMissing(body):
        return create_error_400("Missing field: 'table', 'fields' or 'values'")
    cursor = get_db().cursor(buffered=True)
    try:
        insertTableFields(body, cursor, updateOrReplace)
    except mysql.connector.Error as err:
        print(err)
        print("Error Code:", err.errno)
        print("SQLSTATE", err.sqlstate)
        print("Message", err.msg)
        get_db().rollback()
        return create_error_400(err.msg)
     except:
        get_db().rollback()
        return create_error_400("Failed to add data")
    return make_response({"message": "Successfully added field data"}, 200)

@bp.route("/bulk-fields", methods=["POST"])
@auth_decorator()
def bulk_fields():
    updateOrReplace = request.args.get('updateOrReplace') == "true"
    body = request.get_json()
    get_db().start_transaction()
    addBulkFields(body, updateOrReplace)
    return make_response({"message": "Successfully added bulk data"}, 200)

def addBulkFields(body, updateOrReplace):
    cursor = get_db().cursor(buffered=True)

    for item in body:
        if necessaryFieldsMissing(item):
            get_db().rollback()
            return create_error_400("Missing field: 'table', 'fields' or 'values'")
        try:
            insertTableFields(item, cursor, updateOrReplace)
        except mysql.connector.Error as err:
            print(err)
            print("Error Code:", err.errno)
            print("SQLSTATE", err.sqlstate)
            print("Message", err.msg)
            get_db().rollback()
            return create_error_400(err.msg)
        except:
            get_db().rollback()
            return create_error_400("Failed to add data")
        
    get_db().commit()
    return 

@bp.route("/bulk-tables", methods=["POST"])
@auth_decorator()
def bulk():
    updateOrReplace = request.args.get('updateOrReplace') == "true"
    body = request.get_json()
    
    if not isinstance(body, list):
        return create_error_400("Invalid Payload")
    get_db().start_transaction()
    cursor = get_db().cursor(buffered=True)
    set_of_tables = set()
    list_of_tables = []
    for tableItem in body:
        if not isinstance(tableItem, dict):
            get_db().rollback()
            return create_error_400("Invalid Payload")
        if ("table" not in tableItem) or ("insertions" not in tableItem):
            get_db().rollback()
            return create_error_400("Invalid Payload")
        if not isinstance(tableItem["insertions"], list):
            get_db().rollback()
            return create_error_400("Invalid Payload")
        for insertion in tableItem["insertions"]:
            if necessaryFieldsMissingNotIncludingTable(insertion):
                get_db().rollback()
                return create_error_400("Missing field: 'fields' or 'values'")
        set_of_tables.add(tableItem["table"])
        list_of_tables.append(tableItem["table"])

    if not (len(list_of_tables) == len(set_of_tables)):
        get_db().rollback()
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
                get_db().rollback()
                return create_error_400(err.msg)
            except:
                get_db().rollback()
                return create_error_400("Failed to add data")
    get_db().commit()
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

def create_error_400(errorMessage):
    abort(make_response(jsonify(message=errorMessage), 400))




























































    

# @bp.route("/")
# def index():
#     """Show all the posts, most recent first."""
#     db = get_db()
#     posts = db.execute(
#         "SELECT p.id, title, body, created, author_id, username"
#         " FROM post p JOIN user u ON p.author_id = u.id"
#         " ORDER BY created DESC"
#     ).fetchall()
#     return render_template("blog/index.html", posts=posts)


# def get_post(id, check_author=True):
#     """Get a post and its author by id.

#     Checks that the id exists and optionally that the current user is
#     the author.

#     :param id: id of post to get
#     :param check_author: require the current user to be the author
#     :return: the post with author information
#     :raise 404: if a post with the given id doesn't exist
#     :raise 403: if the current user isn't the author
#     """
#     post = (
#         get_db()
#         .execute(
#             "SELECT p.id, title, body, created, author_id, username"
#             " FROM post p JOIN user u ON p.author_id = u.id"
#             " WHERE p.id = ?",
#             (id,),
#         )
#         .fetchone()
#     )

#     if post is None:
#         abort(404, "Post id {0} doesn't exist.".format(id))

#     if check_author and post["author_id"] != g.user["id"]:
#         abort(403)

#     return post


# @bp.route("/create", methods=("GET", "POST"))
# @login_required
# def create():
#     """Create a new post for the current user."""
#     if request.method == "POST":
#         title = request.form["title"]
#         body = request.form["body"]
#         error = None

#         if not title:
#             error = "Title is required."

#         if error is not None:
#             flash(error)
#         else:
#             db = get_db()
#             db.execute(
#                 "INSERT INTO post (title, body, author_id) VALUES (?, ?, ?)",
#                 (title, body, g.user["id"]),
#             )
#             db.commit()
#             return redirect(url_for("blog.index"))

#     return render_template("blog/create.html")
