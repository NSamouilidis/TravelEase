import mysql.connector
import sys

def check_database_structure():
   
    
    # Database connection settings
    db_config = {
        'host': 'localhost',
        'user': 'root',
        'password': '',
        'database': 'travelease',
        'use_pure': True
    }
    
    
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        print("✅ Successfully connected to the MySQL database")
        
        
        expected_tables = ['users', 'destinations', 'bookings']
        cursor.execute("SHOW TABLES")
        table_results = cursor.fetchall()
        
        
        if table_results:
            table_key = list(table_results[0].keys())[0]  # Get the first key of the result dictionary
            existing_tables = [table[table_key] for table in table_results]
        else:
            existing_tables = []
        
        missing_tables = [table for table in expected_tables if table not in existing_tables]
        
        if missing_tables:
            print(f"⚠️ Warning: The following required tables are missing: {', '.join(missing_tables)}")
            print("Please make sure to run the SQL script to create these tables.")
        else:
            print("✅ All required tables exist in the database")
            
            
            expected_columns = {
                'users': ['id', 'username', 'email', 'password', 'created_at'],
                'destinations': ['id', 'name', 'image_url', 'price', 'description', 'created_at'],
                'bookings': ['id', 'user_id', 'destination', 'transport', 'start_date', 'end_date', 'num_people', 'notes', 'created_at']
            }
            
            
            for table in expected_tables:
                cursor.execute(f"DESCRIBE {table}")
                columns = cursor.fetchall()
                column_names = [col['Field'] for col in columns]
                print(f"Table '{table}' has columns: {', '.join(column_names)}")
                
                
                missing_columns = [col for col in expected_columns[table] if col not in column_names]
                if missing_columns:
                    print(f"⚠️ Warning: Table '{table}' is missing columns: {', '.join(missing_columns)}")
            
            
            for table in existing_tables:
                cursor.execute(f"SELECT COUNT(*) as count FROM {table}")
                count = cursor.fetchone()['count']
                print(f"Table '{table}' has {count} records")
        
        
        cursor.close()
        conn.close()
        print("\n✅ Database verification complete.")
        return True
        
    except mysql.connector.Error as err:
        print(f"❌ Error connecting to MySQL: {err}")
        if err.errno == mysql.connector.errorcode.ER_BAD_DB_ERROR:
            print("\nDatabase 'travelease' does not exist.")
            print("Please create it with: CREATE DATABASE travelease;")
            print("Then run the SQL script to create the required tables.")
        elif err.errno == mysql.connector.errorcode.ER_ACCESS_DENIED_ERROR:
            print("\nAccess denied. Please check your MySQL username and password.")
        else:
            print("\nAn unexpected error occurred. Please check your MySQL server.")
        return False

if __name__ == "__main__":
    print("\n=== TravelEase Database Verification ===\n")
    success = check_database_structure()
    if not success:
        sys.exit(1)