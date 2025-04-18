"""
Minimal models for Django - these are just stubs since we're using raw SQL.
The actual models should match your existing database schema.
"""

from django.db import models

# Empty models that correspond to your existing database tables
# These are needed for Django infrastructure but aren't used directly

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