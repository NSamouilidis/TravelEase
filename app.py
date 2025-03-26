from flask import Flask, request, jsonify, session
from flask_cors import CORS
import os
from datetime import datetime, timedelta
import json
import mysql.connector
from config import DATABASE_CONFIG
from models.user import User
from models.destination import Destination
from models.favorite import Favorite
from models.trip import Trip
from models.weather import get_weather_data
from utils.db_connector import get_db_connection

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes
app.secret_key = os.environ.get('SECRET_KEY', 'travelease_secret_key')
app.config['SESSION_TYPE'] = 'filesystem'
app.config['PERMANENT_SESSION_LIFETIME'] = timedelta(days=7)

# Initialize database connection
db_connection = get_db_connection()

# User Routes
@app.route('/api/users/register', methods=['POST'])
def register_user():
    data = request.json
    try:
        user = User(db_connection)
        result = user.create(
            data['username'], 
            data['email'], 
            data['password'], 
            data.get('first_name', ''), 
            data.get('last_name', '')
        )
        if result:
            return jsonify({"message": "User registered successfully", "user_id": result}), 201
        return jsonify({"error": "Could not register user"}), 400
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/users/login', methods=['POST'])
def login_user():
    data = request.json
    try:
        user = User(db_connection)
        result = user.login(data['email'], data['password'])
        if result:
            session['user_id'] = result['id']
            session['username'] = result['username']
            session.permanent = True
            return jsonify({"message": "Login successful", "user": result}), 200
        return jsonify({"error": "Invalid credentials"}), 401
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/users/logout', methods=['POST'])
def logout_user():
    session.clear()
    return jsonify({"message": "Logged out successfully"}), 200

@app.route('/api/users/profile', methods=['GET'])
def get_user_profile():
    if 'user_id' not in session:
        return jsonify({"error": "Not logged in"}), 401
    
    try:
        user = User(db_connection)
        profile = user.get_by_id(session['user_id'])
        if profile:
            return jsonify({"profile": profile}), 200
        return jsonify({"error": "User not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/users/profile', methods=['PUT'])
def update_user_profile():
    if 'user_id' not in session:
        return jsonify({"error": "Not logged in"}), 401
    
    data = request.json
    try:
        user = User(db_connection)
        result = user.update(
            session['user_id'],
            data.get('username'),
            data.get('email'),
            data.get('first_name'),
            data.get('last_name')
        )
        if result:
            return jsonify({"message": "Profile updated successfully"}), 200
        return jsonify({"error": "Could not update profile"}), 400
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Destination Routes
@app.route('/api/destinations', methods=['GET'])
def get_destinations():
    params = request.args
    try:
        destination = Destination(db_connection)
        results = destination.search(
            country=params.get('country'),
            city=params.get('city'),
            budget_min=params.get('budget_min'),
            budget_max=params.get('budget_max'),
            limit=params.get('limit', 10),
            offset=params.get('offset', 0)
        )
        return jsonify({"destinations": results}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/destinations/<int:destination_id>', methods=['GET'])
def get_destination(destination_id):
    try:
        destination = Destination(db_connection)
        result = destination.get_by_id(destination_id)
        if result:
            # Get weather data for the destination
            weather_data = get_weather_data(result['city'], result['country'])
            result['weather'] = weather_data
            return jsonify({"destination": result}), 200
        return jsonify({"error": "Destination not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Favorite Routes
@app.route('/api/favorites', methods=['GET'])
def get_favorites():
    if 'user_id' not in session:
        return jsonify({"error": "Not logged in"}), 401
    
    try:
        favorite = Favorite(db_connection)
        results = favorite.get_by_user_id(session['user_id'])
        return jsonify({"favorites": results}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/favorites', methods=['POST'])
def add_favorite():
    if 'user_id' not in session:
        return jsonify({"error": "Not logged in"}), 401
    
    data = request.json
    try:
        favorite = Favorite(db_connection)
        result = favorite.add(session['user_id'], data['destination_id'])
        if result:
            return jsonify({"message": "Favorite added successfully", "favorite_id": result}), 201
        return jsonify({"error": "Could not add favorite"}), 400
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/favorites/<int:favorite_id>', methods=['DELETE'])
def remove_favorite(favorite_id):
    if 'user_id' not in session:
        return jsonify({"error": "Not logged in"}), 401
    
    try:
        favorite = Favorite(db_connection)
        result = favorite.remove(favorite_id, session['user_id'])
        if result:
            return jsonify({"message": "Favorite removed successfully"}), 200
        return jsonify({"error": "Could not remove favorite"}), 400
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Trip Routes
@app.route('/api/trips', methods=['GET'])
def get_trips():
    if 'user_id' not in session:
        return jsonify({"error": "Not logged in"}), 401
    
    try:
        trip = Trip(db_connection)
        results = trip.get_by_user_id(session['user_id'])
        return jsonify({"trips": results}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/trips', methods=['POST'])
def create_trip():
    if 'user_id' not in session:
        return jsonify({"error": "Not logged in"}), 401
    
    data = request.json
    try:
        trip = Trip(db_connection)
        result = trip.create(
            session['user_id'],
            data['destination_id'],
            data['start_date'],
            data['end_date'],
            data.get('notes', ''),
            data.get('budget', 0)
        )
        if result:
            return jsonify({"message": "Trip created successfully", "trip_id": result}), 201
        return jsonify({"error": "Could not create trip"}), 400
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/trips/<int:trip_id>', methods=['GET'])
def get_trip(trip_id):
    if 'user_id' not in session:
        return jsonify({"error": "Not logged in"}), 401
    
    try:
        trip = Trip(db_connection)
        result = trip.get_by_id(trip_id, session['user_id'])
        if result:
            return jsonify({"trip": result}), 200
        return jsonify({"error": "Trip not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/trips/<int:trip_id>', methods=['PUT'])
def update_trip(trip_id):
    if 'user_id' not in session:
        return jsonify({"error": "Not logged in"}), 401
    
    data = request.json
    try:
        trip = Trip(db_connection)
        result = trip.update(
            trip_id,
            session['user_id'],
            data.get('start_date'),
            data.get('end_date'),
            data.get('notes'),
            data.get('budget')
        )
        if result:
            return jsonify({"message": "Trip updated successfully"}), 200
        return jsonify({"error": "Could not update trip"}), 400
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/trips/<int:trip_id>', methods=['DELETE'])
def delete_trip(trip_id):
    if 'user_id' not in session:
        return jsonify({"error": "Not logged in"}), 401
    
    try:
        trip = Trip(db_connection)
        result = trip.delete(trip_id, session['user_id'])
        if result:
            return jsonify({"message": "Trip deleted successfully"}), 200
        return jsonify({"error": "Could not delete trip"}), 400
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Weather Route
@app.route('/api/weather', methods=['GET'])
def get_weather():
    city = request.args.get('city')
    country = request.args.get('country')
    
    if not city or not country:
        return jsonify({"error": "City and country are required"}), 400
    
    try:
        weather_data = get_weather_data(city, country)
        return jsonify({"weather": weather_data}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Search Route for advanced filtering
@app.route('/api/search', methods=['POST'])
def advanced_search():
    data = request.json
    try:
        destination = Destination(db_connection)
        results = destination.advanced_search(
            country=data.get('country'),
            city=data.get('city'),
            budget_min=data.get('budget_min'),
            budget_max=data.get('budget_max'),
            interests=data.get('interests', []),
            weather_condition=data.get('weather_condition'),
            trip_duration=data.get('trip_duration'),
            limit=data.get('limit', 10),
            offset=data.get('offset', 0)
        )
        return jsonify({"destinations": results}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)