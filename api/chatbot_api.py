"""
Chatbot API for TravelEase
Provides direct database access for chatbot recommendations
"""

from django.http import JsonResponse
from django.views.decorators.http import require_http_methods
from django.db import connection
from django.views.decorators.csrf import csrf_exempt
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
def get_budget_recommendations(request):
    """
    Get destination recommendations based on budget
    ?budget=1000 (in USD)
    """
    try:
        # Get budget from query parameter
        budget = request.GET.get('budget', '0')
        
        # Validate budget
        try:
            budget = float(budget)
            if budget <= 0:
                return JsonResponse({'error': 'Budget must be greater than 0'}, status=400)
        except ValueError:
            return JsonResponse({'error': 'Invalid budget value'}, status=400)
            
        # Query destinations within budget
        query = """
            SELECT * FROM destinations 
            WHERE price <= %s 
            ORDER BY price DESC
        """
        
        destinations = execute_query(query, [budget], fetchall=True)
        
        # Format response data
        for dest in destinations:
            if 'price' in dest and dest['price'] is not None:
                dest['price'] = float(dest['price'])
            if 'created_at' in dest and dest['created_at'] is not None:
                dest['created_at'] = dest['created_at'].isoformat()
        
        return JsonResponse({
            'count': len(destinations),
            'destinations': destinations
        })
        
    except Exception as e:
        print(f"Error getting budget recommendations: {e}")
        return JsonResponse({'error': str(e)}, status=500)

@require_http_methods(["GET"])
def get_chatbot_stats(request):
    """
    Get statistics for chatbot to use in recommendations
    """
    try:
        # Get general stats about destinations
        stats = {
            'min_price': 0,
            'max_price': 0,
            'avg_price': 0,
            'total_destinations': 0
        }
        
        # Query for stats
        query = """
            SELECT 
                MIN(price) as min_price,
                MAX(price) as max_price,
                AVG(price) as avg_price,
                COUNT(*) as total
            FROM destinations
        """
        
        result = execute_query(query, fetchone=True)
        
        if result:
            stats['min_price'] = float(result['min_price']) if result['min_price'] else 0
            stats['max_price'] = float(result['max_price']) if result['max_price'] else 0
            stats['avg_price'] = float(result['avg_price']) if result['avg_price'] else 0
            stats['total_destinations'] = result['total']
        
        return JsonResponse(stats)
        
    except Exception as e:
        print(f"Error getting chatbot stats: {e}")
        return JsonResponse({'error': str(e)}, status=500)