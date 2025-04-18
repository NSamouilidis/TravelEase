"""
URL configuration for travelease project.
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from api import chatbot_api, hotels_api  # Import hotels_api

urlpatterns = [
    path('admin/', admin.site.urls),
    
    # Chatbot API endpoints
    path('api/chatbot/recommendations', chatbot_api.get_budget_recommendations, name='get_budget_recommendations'),
    path('api/chatbot/stats', chatbot_api.get_chatbot_stats, name='get_chatbot_stats'),
    
    # Hotels API endpoints
    path('api/hotels', hotels_api.get_hotels, name='get_hotels'),
    path('api/hotels/featured', hotels_api.get_featured_hotels, name='get_featured_hotels'),
    path('api/hotels/search', hotels_api.search_hotels, name='search_hotels'),
    path('api/hotels/<int:hotel_id>', hotels_api.get_hotel_by_id, name='get_hotel_by_id'),
    
    # Include all other API routes
    path('', include('api.urls')),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)