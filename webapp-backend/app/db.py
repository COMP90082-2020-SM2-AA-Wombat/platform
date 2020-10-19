
import mysql.connector
import settings 
from collections import defaultdict

class Db():
    def __init__(self):
        
        self.config = {
            'user': settings.DB_USERNAME,
            'password': settings.DB_PASSWORD,
            # "host": "db",
            'host': settings.DB_HOST,
            'port': settings.DB_PORT,
            'database': settings.DATABASE_NAME,
            'auth_plugin':'mysql_native_password'
        }
        self.connection = mysql.connector.connect(**self.config, autocommit=True)
        cursor = self.connection.cursor(buffered=True)
        cursor.execute("SHOW TABLES")

        self.tableWithFields = defaultdict(lambda : [])
        for (table,) in cursor.fetchall():
            attrCursor = self.connection.cursor(buffered=True)
            attrCursor.execute(f'SHOW COLUMNS FROM {settings.DATABASE_NAME}.{table};')

            for columnDetails in attrCursor.fetchall():
                print(columnDetails)
                self.tableWithFields[table].append({
                    "field":columnDetails[0],
                    "type":columnDetails[1].decode('UTF-8')
                })
            attrCursor.close()






