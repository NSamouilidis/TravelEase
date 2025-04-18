#!/usr/bin/env python
"""
Script to run the Django development server for TravelEase.
Connects to your existing MySQL database.
"""

import os
import subprocess
import sys
import mysql.connector

def check_database():
    """Check if the database exists and is accessible."""
    db_config = {
        'host': 'localhost',
        'user': 'root',
        'password': '',
        'database': 'travelease',
        'use_pure': True
    }
    
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        
        # Check required tables
        required_tables = ['users', 'destinations', 'bookings']
        missing_tables = []
        
        for table in required_tables:
            cursor.execute(f"SHOW TABLES LIKE '{table}'")
            if not cursor.fetchone():
                missing_tables.append(table)
        
        cursor.close()
        conn.close()
        
        if missing_tables:
            print(f"Warning: The following tables are missing: {', '.join(missing_tables)}")
            print("The application may not function correctly.")
            return False
            
        return True
    except mysql.connector.Error as err:
        print(f"Error connecting to MySQL: {err}")
        return False

def check_requirements():
    """Check if all requirements are installed."""
    required_packages = ['django', 'mysql.connector', 'bcrypt', 'corsheaders']
    missing_packages = []
    
    for package in required_packages:
        try:
            __import__(package)
        except ImportError:
            missing_packages.append(package)
    
    if missing_packages:
        print("Missing required packages:")
        for package in missing_packages:
            print(f"  - {package}")
        print("\nPlease install them with:")
        print("pip install -r requirements.txt")
        return False
    
    return True

def run_server():
    """Run the Django development server."""
    print("\n=== TravelEase Server Startup ===\n")
    
    if not check_requirements():
        return 1
    
    print("Checking database connection...")
    if not check_database():
        user_input = input("Continue anyway? (y/n): ")
        if user_input.lower() != 'y':
            return 1

    print("\nStarting TravelEase Django server...")
    
    # Run the Django development server
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'travelease.settings')
    
    try:
        # Use Django's management commands directly
        from django.core.management import execute_from_command_line
        execute_from_command_line(['manage.py', 'runserver', '0.0.0.0:3000'])
    except KeyboardInterrupt:
        print("\nServer stopped.")
    except Exception as e:
        print(f"Error running server: {e}")
        return 1
    
    return 0

if __name__ == "__main__":
    sys.exit(run_server())