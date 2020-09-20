from typing import List, Dict
from flask import Flask
import mysql.connector
import json
import os

app = Flask(__name__)


def input_table() -> List[Dict]:
    config = {
        'user': 'root',
        'password': 'password',
        'host': 'db',
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
    return json.dumps({'input_tables': input_table()})


if __name__ == '__main__':
    port = int(os.environ.get("PORT", 5000))
    app.run(debug=True,host='0.0.0.0',port=port)