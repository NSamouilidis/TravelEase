from django.contrib import admin
from .models import User, Destination, Booking

# Register models for admin interface
admin.site.register(User)
admin.site.register(Destination)
admin.site.register(Booking)