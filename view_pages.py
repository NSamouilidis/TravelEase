from django.shortcuts import render

def index(request):
    return render(request, 'index.html')

def login_page(request):
    return render(request, 'login.html')

def signup_page(request):
    return render(request, 'signup.html')

def profile_page(request):
    return render(request, 'profile.html')

def map_page(request):
    return render(request, 'map.html')

def places_page(request):
    return render(request, 'places.html')

def place_detail_page(request):
    return render(request, 'place_detail.html')

def book_page(request):
    return render(request, 'book.html')

def booking_success_page(request):
    return render(request, 'booking_success.html')

def itineraries_page(request):
    return render(request, 'itineraries.html')

def itinerary_detail_page(request):
    return render(request, 'itinerary_detail.html')
def faq_page(request):
    return render(request, 'faq.html')

def contact_page(request):
    return render(request, 'contact.html')

def privacy_policy_page(request):
    return render(request, 'privacy-policy.html')

def terms_of_service_page(request):
    return render(request, 'terms-of-service.html')