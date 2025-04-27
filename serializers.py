from django.utils import timezone
from rest_framework import serializers
from .models import CustomUser, Destination, Booking

class CustomUserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)
    
    class Meta:
        model = CustomUser
        fields = ['id', 'username', 'email', 'password', 'created_at']
        read_only_fields = ['id', 'created_at']
    
    def create(self, validated_data):
        user = CustomUser(
            username=validated_data['username'],
            email=validated_data['email'],
            created_at=timezone.now()
        )
        user.set_password(validated_data['password'])
        user.save()
        return user

class DestinationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Destination
        fields = ['id', 'name', 'image_url', 'price', 'description', 'created_at']
        read_only_fields = ['id', 'created_at']

class BookingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Booking
        fields = ['id', 'user', 'destination', 'transport', 'start_date', 'end_date', 'num_people', 'notes', 'created_at']
        read_only_fields = ['id', 'created_at']