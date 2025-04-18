import json
import random
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
from django.db import connection
import bcrypt
from datetime import datetime

# Helper function to execute SQL queries and convert results to dictionaries
def execute_query(query, params=None, fetchone=False, fetchall=False):
    """Execute SQL query and return results as dictionaries"""
    try:
        with connection.cursor() as cursor:
            cursor.execute(query, params or ())
            if fetchall:
                columns = [col[0] for col in cursor.description]
                return [dict(zip(columns, row)) for row in cursor.fetchall()]
            elif fetchone:
                columns = [col[0] for col in cursor.description]
                row = cursor.fetchone()
                return dict(zip(columns, row)) if row else None
            return cursor.lastrowid
    except Exception as e:
        print(f"SQL Error: {e}")
        print(f"Query: {query}")
        print(f"Params: {params}")
        raise e

# User Registration
@csrf_exempt
@require_http_methods(["POST"])
def register(request):
    try:
        data = json.loads(request.body)
        username = data.get('username')
        email = data.get('email')
        password = data.get('password')

        # Input validation
        if not all([username, email, password]):
            return JsonResponse({'error': 'All fields are required'}, status=400)

        # Check if user already exists
        check_query = "SELECT id FROM users WHERE username = %s OR email = %s"
        existing_user = execute_query(check_query, [username, email], fetchone=True)
        
        if existing_user:
            return JsonResponse({'error': 'Username or email already exists'}, status=400)

        # Hash password
        salt = bcrypt.gensalt()
        hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt).decode('utf-8')
        
        # Insert user into database
        insert_query = "INSERT INTO users (username, email, password) VALUES (%s, %s, %s)"
        user_id = execute_query(insert_query, [username, email, hashed_password])

        return JsonResponse({
            'message': 'User registered successfully!',
            'userId': user_id
        }, status=201)

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

# User Login
@csrf_exempt
@require_http_methods(["POST"])
def login(request):
    try:
        data = json.loads(request.body)
        username = data.get('username')
        password = data.get('password')

        # Input validation
        if not all([username, password]):
            return JsonResponse({'error': 'Username and password are required'}, status=400)

        # Find user in database
        query = "SELECT * FROM users WHERE username = %s"
        user = execute_query(query, [username], fetchone=True)
        
        if not user:
            return JsonResponse({'error': 'User not found'}, status=401)
        
        # Check password
        stored_password = user['password'].encode('utf-8')
        if not bcrypt.checkpw(password.encode('utf-8'), stored_password):
            return JsonResponse({'error': 'Incorrect password'}, status=401)
        
        # Return user data (excluding password)
        user_data = {
            'id': user['id'],
            'username': user['username'],
            'email': user['email'],
            'created_at': user['created_at'].isoformat() if isinstance(user['created_at'], datetime) else user['created_at']
        }
        
        return JsonResponse({
            'message': 'Login successful!',
            'user': user_data
        })
    
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

# Get all destinations
@require_http_methods(["GET"])
def get_destinations(request):
    try:
        query = "SELECT * FROM destinations"
        destinations = execute_query(query, fetchall=True)
        return JsonResponse(destinations, safe=False)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

# Get featured destinations
@require_http_methods(["GET"])
def get_featured_destinations(request):
    try:
        # Get random selection of destinations
        query = "SELECT * FROM destinations ORDER BY RAND() LIMIT 6"
        destinations = execute_query(query, fetchall=True)
        
        # Format prices as float
        for dest in destinations:
            if 'price' in dest and dest['price'] is not None:
                dest['price'] = float(dest['price'])
            if 'created_at' in dest and isinstance(dest['created_at'], datetime):
                dest['created_at'] = dest['created_at'].isoformat()
        
        return JsonResponse(destinations, safe=False)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

# Get a single destination by name
@require_http_methods(["GET"])
def get_destination_by_name(request, name):
    try:
        query = "SELECT * FROM destinations WHERE name = %s"
        destination = execute_query(query, [name], fetchone=True)
        
        if not destination:
            return JsonResponse({'error': 'Destination not found'}, status=404)
        
        # Format price as float
        if 'price' in destination and destination['price'] is not None:
            destination['price'] = float(destination['price'])
        if 'created_at' in destination and isinstance(destination['created_at'], datetime):
            destination['created_at'] = destination['created_at'].isoformat()
            
        return JsonResponse(destination)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

# Add booking
@csrf_exempt
@require_http_methods(["POST"])
def add_booking(request):
    try:
        data = json.loads(request.body)
        user_id = data.get('user_id')
        destination = data.get('destination')
        transport = data.get('transport')
        start_date = data.get('start_date')
        end_date = data.get('end_date')
        num_people = data.get('num_people')
        notes = data.get('notes', '')
        
        # Input validation
        if not all([user_id, destination, transport, start_date, end_date, num_people]):
            return JsonResponse({'error': 'Required fields missing'}, status=400)
        
        # Check if user exists
        user_query = "SELECT id FROM users WHERE id = %s"
        user = execute_query(user_query, [user_id], fetchone=True)
        
        if not user:
            return JsonResponse({'error': 'User not found'}, status=404)
        
        # Create booking
        booking_query = """
            INSERT INTO bookings (user_id, destination, transport, start_date, end_date, num_people, notes) 
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        booking_id = execute_query(booking_query, [
            user_id, destination, transport, start_date, end_date, num_people, notes
        ])
        
        return JsonResponse({
            'message': 'Booking created successfully!',
            'bookingId': booking_id
        }, status=201)
        
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

# Get user bookings
@require_http_methods(["GET"])
def get_user_bookings(request, user_id):
    try:
        query = "SELECT * FROM bookings WHERE user_id = %s"
        bookings = execute_query(query, [user_id], fetchall=True)
        
        # Format dates
        for booking in bookings:
            if 'start_date' in booking and booking['start_date'] is not None:
                booking['start_date'] = booking['start_date'].isoformat()
            if 'end_date' in booking and booking['end_date'] is not None:
                booking['end_date'] = booking['end_date'].isoformat()
            if 'created_at' in booking and isinstance(booking['created_at'], datetime):
                booking['created_at'] = booking['created_at'].isoformat()
        
        return JsonResponse(bookings, safe=False)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)