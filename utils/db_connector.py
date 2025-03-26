import mysql.connector
from mysql.connector import Error
from config import DATABASE_CONFIG

def get_db_connection():
    """
    Create and return a connection to the MySQL database
    """
    try:
        connection = mysql.connector.connect(
            host=DATABASE_CONFIG['host'],
            user=DATABASE_CONFIG['user'],
            password=DATABASE_CONFIG['password'],
            database=DATABASE_CONFIG['database'],
            port=DATABASE_CONFIG['port']
        )
        return connection
    except Error as e:
        print(f"Error connecting to MySQL database: {e}")
        return None

def execute_query(connection, query, params=None):
    """
    Execute a query with optional parameters
    """
    cursor = connection.cursor(dictionary=True)
    try:
        if params:
            cursor.execute(query, params)
        else:
            cursor.execute(query)
        connection.commit()
        return cursor
    except Error as e:
        print(f"Error executing query: {e}")
        return None
    finally:
        cursor.close()

def fetch_all(connection, query, params=None):
    """
    Execute a SELECT query and fetch all results
    """
    cursor = execute_query(connection, query, params)
    if cursor:
        results = cursor.fetchall()
        return results
    return []

def fetch_one(connection, query, params=None):
    """
    Execute a SELECT query and fetch one result
    """
    cursor = execute_query(connection, query, params)
    if cursor:
        result = cursor.fetchone()
        return result
    return None

def insert(connection, query, params=None):
    """
    Execute an INSERT query and return the last inserted ID
    """
    cursor = connection.cursor()
    try:
        if params:
            cursor.execute(query, params)
        else:
            cursor.execute(query)
        connection.commit()
        return cursor.lastrowid
    except Error as e:
        print(f"Error inserting data: {e}")
        connection.rollback()
        return None
    finally:
        cursor.close()

def update(connection, query, params=None):
    """
    Execute an UPDATE query and return the number of rows affected
    """
    cursor = connection.cursor()
    try:
        if params:
            cursor.execute(query, params)
        else:
            cursor.execute(query)
        connection.commit()
        return cursor.rowcount
    except Error as e:
        print(f"Error updating data: {e}")
        connection.rollback()
        return 0
    finally:
        cursor.close()

def delete(connection, query, params=None):
    """
    Execute a DELETE query and return the number of rows affected
    """
    cursor = connection.cursor()
    try:
        if params:
            cursor.execute(query, params)
        else:
            cursor.execute(query)
        connection.commit()
        return cursor.rowcount
    except Error as e:
        print(f"Error deleting data: {e}")
        connection.rollback()
        return 0
    finally:
        cursor.close()