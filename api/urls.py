from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from . import views
from . import view_pages

urlpatterns = [
    # API endpoints
    path('register', views.register, name='register'),
    path('login', views.login, name='login'),
    path('api/destinations', views.get_destinations, name='get_destinations'),
    path('api/destinations/featured', views.get_featured_destinations, name='get_featured_destinations'),
    path('api/destinations/<str:name>', views.get_destination_by_name, name='get_destination_by_name'),
    path('api/bookings', views.add_booking, name='add_booking'),
    path('api/bookings/<int:user_id>', views.get_user_bookings, name='get_user_bookings'),
    
    # Frontend pages
    path('', view_pages.index, name='index'),
    path('login.html', view_pages.login_page, name='login_page'),
    path('signup.html', view_pages.signup_page, name='signup_page'),
    path('profile.html', view_pages.profile_page, name='profile_page'),
    path('map.html', view_pages.map_page, name='map_page'),
    path('places.html', view_pages.places_page, name='places_page'),
    path('place_detail.html', view_pages.place_detail_page, name='place_detail_page'),
    path('book.html', view_pages.book_page, name='book_page'),
    path('booking_success.html', view_pages.booking_success_page, name='booking_success_page'),
    path('itineraries.html', view_pages.itineraries_page, name='itineraries_page'),
    path('hotels.html', view_pages.hotel_page, name='hotel_page'),
    path('hotel_detail.html', view_pages.hotel_detail_page, name='hotel_detail_page'),
]

# Add static files URL pattern for development
if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)