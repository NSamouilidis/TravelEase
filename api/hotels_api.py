"""
Hotels API for TravelEase
Provides endpoints for hotel data
"""

from django.http import JsonResponse
from django.views.decorators.http import require_http_methods
from django.views.decorators.csrf import csrf_exempt
from django.db import connection
import json

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

@require_http_methods(["GET"])
def get_hotels(request):
    """
    Get all hotels
    Optional query parameters:
    - location: Filter by location
    - min_price: Minimum price per night
    - max_price: Maximum price per night
    - min_rating: Minimum rating (1-5)
    """
    try:
        # Base query
        query = "SELECT * FROM hotels"
        conditions = []
        params = []
        
        # Add location filter if provided
        location = request.GET.get('location')
        if location:
            conditions.append("location LIKE %s")
            params.append(f"%{location}%")
        
        # Add price filters if provided
        min_price = request.GET.get('min_price')
        if min_price:
            try:
                min_price = float(min_price)
                conditions.append("price_per_night >= %s")
                params.append(min_price)
            except ValueError:
                pass
        
        max_price = request.GET.get('max_price')
        if max_price:
            try:
                max_price = float(max_price)
                conditions.append("price_per_night <= %s")
                params.append(max_price)
            except ValueError:
                pass
        
        # Add rating filter if provided
        min_rating = request.GET.get('min_rating')
        if min_rating:
            try:
                min_rating = float(min_rating)
                conditions.append("rating >= %s")
                params.append(min_rating)
            except ValueError:
                pass
        
        # Add conditions to query
        if conditions:
            query += " WHERE " + " AND ".join(conditions)
        
        # Add ordering
        query += " ORDER BY price_per_night ASC"
        
        # Execute query
        hotels = execute_query(query, params, fetchall=True)
        
        # Format response data
        for hotel in hotels:
            if 'price_per_night' in hotel and hotel['price_per_night'] is not None:
                hotel['price_per_night'] = float(hotel['price_per_night'])
            if 'rating' in hotel and hotel['rating'] is not None:
                hotel['rating'] = float(hotel['rating'])
            if 'created_at' in hotel and hotel['created_at'] is not None:
                hotel['created_at'] = hotel['created_at'].isoformat()
        
        return JsonResponse(hotels, safe=False)
        
    except Exception as e:
        print(f"Error getting hotels: {e}")
        return JsonResponse({'error': str(e)}, status=500)

@require_http_methods(["GET"])
def get_hotel_by_id(request, hotel_id):
    """
    Get a single hotel by ID
    """
    try:
        query = "SELECT * FROM hotels WHERE id = %s"
        hotel = execute_query(query, [hotel_id], fetchone=True)
        
        if not hotel:
            return JsonResponse({'error': 'Hotel not found'}, status=404)
        
        # Format response data
        if 'price_per_night' in hotel and hotel['price_per_night'] is not None:
            hotel['price_per_night'] = float(hotel['price_per_night'])
        if 'rating' in hotel and hotel['rating'] is not None:
            hotel['rating'] = float(hotel['rating'])
        if 'created_at' in hotel and hotel['created_at'] is not None:
            hotel['created_at'] = hotel['created_at'].isoformat()
        
        # Parse amenities into a list
        if 'amenities' in hotel and hotel['amenities']:
            hotel['amenities'] = hotel['amenities'].split(',')
        
        return JsonResponse(hotel)
        
    except Exception as e:
        print(f"Error getting hotel: {e}")
        return JsonResponse({'error': str(e)}, status=500)

@require_http_methods(["GET"])
def get_featured_hotels(request):
    """
    Get featured/recommended hotels (random selection of highly rated hotels)
    """
    try:
        # Get a random selection of top-rated hotels
        query = """
            SELECT * FROM hotels 
            WHERE rating >= 4.5
            ORDER BY RAND()
            LIMIT 6
        """
        
        hotels = execute_query(query, fetchall=True)
        
        # Format response data
        for hotel in hotels:
            if 'price_per_night' in hotel and hotel['price_per_night'] is not None:
                hotel['price_per_night'] = float(hotel['price_per_night'])
            if 'rating' in hotel and hotel['rating'] is not None:
                hotel['rating'] = float(hotel['rating'])
            if 'created_at' in hotel and hotel['created_at'] is not None:
                hotel['created_at'] = hotel['created_at'].isoformat()
        
        return JsonResponse(hotels, safe=False)
        
    except Exception as e:
        print(f"Error getting featured hotels: {e}")
        return JsonResponse({'error': str(e)}, status=500)

@require_http_methods(["GET"])
def search_hotels(request):
    """
    Search hotels by name or location
    """
    try:
        query_term = request.GET.get('q', '')
        
        if not query_term:
            return JsonResponse({'error': 'Search query is required'}, status=400)
        
        # Search by name or location
        query = """
            SELECT * FROM hotels 
            WHERE name LIKE %s OR location LIKE %s
            ORDER BY rating DESC
        """
        
        params = [f"%{query_term}%", f"%{query_term}%"]
        
        hotels = execute_query(query, params, fetchall=True)
        
        # Format response data
        for hotel in hotels:
            if 'price_per_night' in hotel and hotel['price_per_night'] is not None:
                hotel['price_per_night'] = float(hotel['price_per_night'])
            if 'rating' in hotel and hotel['rating'] is not None:
                hotel['rating'] = float(hotel['rating'])
            if 'created_at' in hotel and hotel['created_at'] is not None:
                hotel['created_at'] = hotel['created_at'].isoformat()
        
        return JsonResponse(hotels, safe=False)
        
    except Exception as e:
        print(f"Error searching hotels: {e}")
        return JsonResponse({'error': str(e)}, status=500)