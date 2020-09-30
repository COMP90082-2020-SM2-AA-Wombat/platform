from typing import List, Dict
from flask import Flask, request, jsonify
import mysql.connector
import json
import os
from flask_cors import CORS
import pandas as pd

app = Flask(__name__)
CORS(app)


def input_table() -> List[Dict]:
    config = {
        'user': 'root',
        'password': 'password',
        # "host": "db",
        'host': 'localhost',
        'port': '3306',
        'database': 'AA_AUDIT'
    }
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM input_table')
    results = [{name: color} for (name, color) in cursor]
    cursor.close()
    connection.close()

    return results


@app.route('/')
def index() -> str:
    # return "hello"
    return json.dumps({'input_tables': input_table()})

@app.route("/csv", methods=["POST"])
def csvInjestion() -> str:
    print(request.files)

    files = request.files
    for key in files:
        print(key, files[key])
    print(files)
    return "hello world"



if __name__ == '__main__':
    port = int(os.environ.get("PORT", 5000))
    app.run(debug=True,host='0.0.0.0',port=port)

# FLASK_APP=app.py FLASK_ENV=development flask run