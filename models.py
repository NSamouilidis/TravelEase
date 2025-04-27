

from django.db import models

class User(models.Model):
    """Stub model for users table"""
    class Meta:
        managed = False
        db_table = 'users'

class Destination(models.Model):
    """Stub model for destinations table"""
    class Meta:
        managed = False
        db_table = 'destinations'

class Booking(models.Model):
    """Stub model for bookings table"""
    class Meta:
        managed = False
        db_table = 'bookings'

class Itinerary(models.Model):
    """Stub model for itineraries table"""
    class Meta:
        managed = False
        db_table = 'itineraries'