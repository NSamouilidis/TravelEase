import os
import mysql.connector
from mysql.connector import Error
import sys
from config import DATABASE_CONFIG

def initialize_database():
    """
    Initialize the TravelEase database using the SQL file
    """
    try:
        # Create database connection
        connection = mysql.connector.connect(
            host=DATABASE_CONFIG['host'],
            user=DATABASE_CONFIG['user'],
            password=DATABASE_CONFIG['password'],
            port=DATABASE_CONFIG['port']
        )
        
        if connection.is_connected():
            cursor = connection.cursor()
            
            # Read SQL file
            with open('travelease.sql', 'r') as file:
                sql_script = file.read()
            
            # Split SQL script into individual statements
            statements = sql_script.split(';')
            
            # Execute each statement
            for statement in statements:
                if statement.strip():
                    cursor.execute(statement)
                    connection.commit()
            
            print("Database initialized successfully.")
            
    except Error as e:
        print(f"Error initializing database: {e}")
        sys.exit(1)
    
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
            print("MySQL connection closed.")

if __name__ == "__main__":
    initialize_database()