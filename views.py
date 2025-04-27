import json
import bcrypt
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
from django.db import connection
from datetime import datetime

def execute_query(query, params=None, fetchone=False, fetchall=False):
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

@csrf_exempt
@require_http_methods(["POST"])
def register(request):
    try:
        data = json.loads(request.body)
        username = data.get('username')
        email = data.get('email')
        password = data.get('password')

        if not all([username, email, password]):
            return JsonResponse({'error': 'All fields are required'}, status=400)

        check_query = "SELECT id FROM users WHERE username = %s OR email = %s"
        existing_user = execute_query(check_query, [username, email], fetchone=True)
        
        if existing_user:
            return JsonResponse({'error': 'Username or email already exists'}, status=400)

        salt = bcrypt.gensalt()
        hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt).decode('utf-8')
        
        insert_query = "INSERT INTO users (username, email, password) VALUES (%s, %s, %s)"
        user_id = execute_query(insert_query, [username, email, hashed_password])

        return JsonResponse({
            'message': 'User registered successfully!',
            'userId': user_id
        }, status=201)

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

@csrf_exempt
@require_http_methods(["POST"])
def login(request):
    try:
        data = json.loads(request.body)
        username = data.get('username')
        password = data.get('password')

        if not all([username, password]):
            return JsonResponse({'error': 'Username and password are required'}, status=400)

        query = "SELECT * FROM users WHERE username = %s"
        user = execute_query(query, [username], fetchone=True)
        
        if not user:
            return JsonResponse({'error': 'User not found'}, status=401)
        
        stored_password = user['password'].encode('utf-8')
        if not bcrypt.checkpw(password.encode('utf-8'), stored_password):
            return JsonResponse({'error': 'Incorrect password'}, status=401)
        
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

@require_http_methods(["GET"])
def get_destinations(request):
    try:
        query = "SELECT * FROM destinations"
        destinations = execute_query(query, fetchall=True)
        return JsonResponse(destinations, safe=False)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

@require_http_methods(["GET"])
def get_featured_destinations(request):
    try:
        query = "SELECT * FROM destinations ORDER BY RAND() LIMIT 6"
        destinations = execute_query(query, fetchall=True)
        
        for dest in destinations:
            if 'price' in dest and dest['price'] is not None:
                dest['price'] = float(dest['price'])
            if 'created_at' in dest and isinstance(dest['created_at'], datetime):
                dest['created_at'] = dest['created_at'].isoformat()
        
        return JsonResponse(destinations, safe=False)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

@require_http_methods(["GET"])
def get_destination_by_name(request, name):
    try:
        query = "SELECT * FROM destinations WHERE name = %s"
        destination = execute_query(query, [name], fetchone=True)
        
        if not destination:
            return JsonResponse({'error': 'Destination not found'}, status=404)
        
        if 'price' in destination and destination['price'] is not None:
            destination['price'] = float(destination['price'])
        if 'created_at' in destination and isinstance(destination['created_at'], datetime):
            destination['created_at'] = destination['created_at'].isoformat()
            
        return JsonResponse(destination)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

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
        
        if not all([user_id, destination, transport, start_date, end_date, num_people]):
            return JsonResponse({'error': 'Required fields missing'}, status=400)
        
        user_query = "SELECT id FROM users WHERE id = %s"
        user = execute_query(user_query, [user_id], fetchone=True)
        
        if not user:
            return JsonResponse({'error': 'User not found'}, status=404)
        
        booking_query = """
            INSERT INTO bookings (user_id, destination, transport, start_date, end_date, num_people, notes) 
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        booking_id = execute_query(booking_query, [
            user_id, destination, transport, start_date, end_date, num_people, notes
        ])
        
        print(f"Booking created successfully! ID: {booking_id}, User: {user_id}, Destination: {destination}")
        
        return JsonResponse({
            'message': 'Booking created successfully!',
            'bookingId': booking_id
        }, status=201)
        
    except Exception as e:
        print(f"Error creating booking: {e}")
        return JsonResponse({'error': str(e)}, status=500)

@require_http_methods(["GET"])
def get_user_bookings(request, user_id):
    try:
        query = """
            SELECT b.*, d.image_url as destination_image
            FROM bookings b
            LEFT JOIN destinations d ON b.destination = d.name
            WHERE b.user_id = %s
            ORDER BY b.created_at DESC
        """
        
        bookings = execute_query(query, [user_id], fetchall=True)
        
        for booking in bookings:
            if 'start_date' in booking and booking['start_date'] is not None:
                booking['start_date'] = booking['start_date'].isoformat()
            if 'end_date' in booking and booking['end_date'] is not None:
                booking['end_date'] = booking['end_date'].isoformat()
            if 'created_at' in booking and booking['created_at'] is not None:
                booking['created_at'] = booking['created_at'].isoformat()
            
            if not booking.get('destination_image'):
                booking['destination_image'] = 'https://cdn.pixabay.com/photo/2015/07/13/14/40/paris-843229_1280.jpg'
        
        return JsonResponse(bookings, safe=False)
        
    except Exception as e:
        print(f"Error retrieving bookings: {e}")
        return JsonResponse({'error': str(e)}, status=500)

@require_http_methods(["GET"])
def get_booking_details(request, booking_id):
    try:
        query = """
            SELECT b.*, d.image_url as destination_image, d.price as destination_price
            FROM bookings b
            LEFT JOIN destinations d ON b.destination = d.name
            WHERE b.id = %s
        """
        
        booking = execute_query(query, [booking_id], fetchone=True)
        
        if not booking:
            return JsonResponse({'error': 'Booking not found'}, status=404)
        
        if 'start_date' in booking and booking['start_date'] is not None:
            booking['start_date'] = booking['start_date'].isoformat()
        if 'end_date' in booking and booking['end_date'] is not None:
            booking['end_date'] = booking['end_date'].isoformat()
        if 'created_at' in booking and booking['created_at'] is not None:
            booking['created_at'] = booking['created_at'].isoformat()
        
        if not booking.get('destination_image'):
            booking['destination_image'] = 'https://cdn.pixabay.com/photo/2015/07/13/14/40/paris-843229_1280.jpg'
        
        return JsonResponse(booking)
        
    except Exception as e:
        print(f"Error retrieving booking details: {e}")
        return JsonResponse({'error': str(e)}, status=500)
    

@require_http_methods(["GET"])
def get_itineraries(request):
    """Get all itineraries"""
    try:
        query = "SELECT * FROM itineraries"
        itineraries = execute_query(query, fetchall=True)
        
        for itinerary in itineraries:
            if 'date' in itinerary and itinerary['date'] is not None:
                itinerary['date'] = itinerary['date'].isoformat() if hasattr(itinerary['date'], 'isoformat') else itinerary['date']
            if 'created_at' in itinerary and itinerary['created_at'] is not None:
                itinerary['created_at'] = itinerary['created_at'].isoformat() if hasattr(itinerary['created_at'], 'isoformat') else itinerary['created_at']
            
            if 'destinations' in itinerary and itinerary['destinations'] is not None:
                try:
                    itinerary['destinations'] = json.loads(itinerary['destinations'])
                except:
                    pass
            if 'highlights' in itinerary and itinerary['highlights'] is not None:
                try:
                    itinerary['highlights'] = json.loads(itinerary['highlights'])
                except:
                    pass
            
            if 'price' in itinerary and itinerary['price'] is not None:
                itinerary['price'] = float(itinerary['price'])
        
        return JsonResponse(itineraries, safe=False)
    except Exception as e:
        print(f"Error getting itineraries: {e}")
        return JsonResponse({'error': str(e)}, status=500)

@require_http_methods(["GET"])
def get_featured_itineraries(request):
    """Get featured itineraries"""
    try:
        query = "SELECT * FROM itineraries WHERE featured = TRUE"
        itineraries = execute_query(query, fetchall=True)
        
        for itinerary in itineraries:
            if 'date' in itinerary and itinerary['date'] is not None:
                itinerary['date'] = itinerary['date'].isoformat() if hasattr(itinerary['date'], 'isoformat') else itinerary['date']
            if 'created_at' in itinerary and itinerary['created_at'] is not None:
                itinerary['created_at'] = itinerary['created_at'].isoformat() if hasattr(itinerary['created_at'], 'isoformat') else itinerary['created_at']
            
            if 'destinations' in itinerary and itinerary['destinations'] is not None:
                try:
                    itinerary['destinations'] = json.loads(itinerary['destinations'])
                except:
                    pass
            if 'highlights' in itinerary and itinerary['highlights'] is not None:
                try:
                    itinerary['highlights'] = json.loads(itinerary['highlights'])
                except:
                    pass
            
            if 'price' in itinerary and itinerary['price'] is not None:
                itinerary['price'] = float(itinerary['price'])
        
        return JsonResponse(itineraries, safe=False)
    except Exception as e:
        print(f"Error getting featured itineraries: {e}")
        return JsonResponse({'error': str(e)}, status=500)

@require_http_methods(["GET"])
def get_itinerary_by_id(request, itinerary_id):
    """Get a single itinerary by ID"""
    try:
        query = "SELECT * FROM itineraries WHERE id = %s"
        itinerary = execute_query(query, [itinerary_id], fetchone=True)
        
        if not itinerary:
            return JsonResponse({'error': 'Itinerary not found'}, status=404)
        
        if 'date' in itinerary and itinerary['date'] is not None:
            itinerary['date'] = itinerary['date'].isoformat() if hasattr(itinerary['date'], 'isoformat') else itinerary['date']
        if 'created_at' in itinerary and itinerary['created_at'] is not None:
            itinerary['created_at'] = itinerary['created_at'].isoformat() if hasattr(itinerary['created_at'], 'isoformat') else itinerary['created_at']
        
        if 'destinations' in itinerary and itinerary['destinations'] is not None:
            try:
                itinerary['destinations'] = json.loads(itinerary['destinations'])
            except:
                pass
        if 'highlights' in itinerary and itinerary['highlights'] is not None:
            try:
                itinerary['highlights'] = json.loads(itinerary['highlights'])
            except:
                pass
        
        if 'price' in itinerary and itinerary['price'] is not None:
            itinerary['price'] = float(itinerary['price'])
        
        return JsonResponse(itinerary)
    except Exception as e:
        print(f"Error getting itinerary: {e}")
        return JsonResponse({'error': str(e)}, status=500)