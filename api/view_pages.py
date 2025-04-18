"""
Views for serving HTML pages for the TravelEase frontend.
"""

from django.shortcuts import render

def index(request):
    """Render the index.html page"""
    return render(request, 'index.html')

def login_page(request):
    """Render the login.html page"""
    return render(request, 'login.html')

def signup_page(request):
    """Render the signup.html page"""
    return render(request, 'signup.html')

def profile_page(request):
    """Render the profile.html page"""
    return render(request, 'profile.html')

def map_page(request):
    """Render the map.html page"""
    return render(request, 'map.html')

def places_page(request):
    """Render the places.html page"""
    return render(request, 'places.html')

def place_detail_page(request):
    """Render the place_detail.html page"""
    return render(request, 'place_detail.html')

def book_page(request):
    """Render the book.html page"""
    return render(request, 'book.html')

def booking_success_page(request):
    """Render the booking_success.html page"""
    return render(request, 'booking_success.html')

def itineraries_page(request):
    """Render the itineraries.html page"""
    return render(request, 'itineraries.html')

def hotel_page(request):
    """Render the hotel.html page"""
    return render(request, 'hotel.html')

def hotel_detail_page(request):
    """Render the hotel_detail.html page"""
    return render(request, 'hotel_detail.html')