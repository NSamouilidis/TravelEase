import requests
import json
from datetime import datetime, timedelta
from config import WEATHER_API_KEY

def get_weather_data(city, country):
    """
    Get weather data for a city using OpenWeatherMap API
    """
    # This is a mock implementation. In production, you would use a real API key
    # and make an actual API call.
    
    if not WEATHER_API_KEY or WEATHER_API_KEY == 'your_weather_api_key':
        # Return mock data if no API key is provided
        return generate_mock_weather_data(city, country)
    
    try:
        # Make API call to OpenWeatherMap
        base_url = "https://api.openweathermap.org/data/2.5/forecast"
        params = {
            "q": f"{city},{country}",
            "appid": WEATHER_API_KEY,
            "units": "metric"  # Use metric units (Celsius)
        }
        
        response = requests.get(base_url, params=params)
        
        if response.status_code == 200:
            data = response.json()
            
            # Process the data to get the next 5 days forecast
            forecast = process_weather_data(data)
            return forecast
        else:
            # If API call fails, return mock data
            return generate_mock_weather_data(city, country)
    
    except Exception as e:
        print(f"Error getting weather data: {e}")
        # In case of any exception, return mock data
        return generate_mock_weather_data(city, country)

def process_weather_data(data):
    """
    Process the weather data from OpenWeatherMap API
    """
    forecast = []
    
    # Group the forecast data by day
    day_forecasts = {}
    
    for item in data.get('list', []):
        # Get date from timestamp
        timestamp = item.get('dt')
        date = datetime.fromtimestamp(timestamp).strftime('%Y-%m-%d')
        
        if date not in day_forecasts:
            day_forecasts[date] = []
        
        day_forecasts[date].append({
            'time': datetime.fromtimestamp(timestamp).strftime('%H:%M'),
            'temp': item.get('main', {}).get('temp'),
            'feels_like': item.get('main', {}).get('feels_like'),
            'temp_min': item.get('main', {}).get('temp_min'),
            'temp_max': item.get('main', {}).get('temp_max'),
            'humidity': item.get('main', {}).get('humidity'),
            'weather': item.get('weather', [{}])[0].get('main'),
            'description': item.get('weather', [{}])[0].get('description'),
            'icon': item.get('weather', [{}])[0].get('icon'),
            'wind_speed': item.get('wind', {}).get('speed'),
            'clouds': item.get('clouds', {}).get('all')
        })
    
    # Calculate average values for each day
    for date, items in day_forecasts.items():
        if not items:
            continue
        
        # Get the most common weather condition
        weather_counts = {}
        for item in items:
            weather = item.get('weather')
            if weather:
                weather_counts[weather] = weather_counts.get(weather, 0) + 1
        
        most_common_weather = max(weather_counts.items(), key=lambda x: x[1])[0] if weather_counts else None
        
        # Calculate average values
        temp_sum = sum(item.get('temp', 0) for item in items)
        temp_min = min(item.get('temp_min', float('inf')) for item in items)
        temp_max = max(item.get('temp_max', float('-inf')) for item in items)
        humidity_sum = sum(item.get('humidity', 0) for item in items)
        wind_speed_sum = sum(item.get('wind_speed', 0) for item in items)
        
        count = len(items)
        
        # Format date to be more readable
        formatted_date = datetime.strptime(date, '%Y-%m-%d').strftime('%A, %b %d')
        
        forecast.append({
            'date': date,
            'formatted_date': formatted_date,
            'avg_temp': round(temp_sum / count, 1),
            'temp_min': round(temp_min, 1),
            'temp_max': round(temp_max, 1),
            'avg_humidity': round(humidity_sum / count),
            'avg_wind_speed': round(wind_speed_sum / count, 1),
            'weather': most_common_weather,
            'icon': items[0].get('icon')  # Just use the icon from the first item
        })
    
    # Sort forecast by date
    forecast.sort(key=lambda x: x['date'])
    
    return forecast[:5]  # Return only the next 5 days

def generate_mock_weather_data(city, country):
    """
    Generate mock weather data for demo purposes
    """
    today = datetime.now()
    forecast = []
    
    weather_types = [
        {'weather': 'Clear', 'icon': '01d'},
        {'weather': 'Clouds', 'icon': '03d'},
        {'weather': 'Rain', 'icon': '10d'},
        {'weather': 'Thunderstorm', 'icon': '11d'},
        {'weather': 'Snow', 'icon': '13d'}
    ]
    
    for i in range(5):
        day = today + timedelta(days=i)
        
        # Use city name to generate consistent "random" weather
        # This ensures the same city always gets the same weather pattern
        city_hash = sum(ord(c) for c in city) % len(weather_types)
        weather_index = (city_hash + i) % len(weather_types)
        
        # Base temperature on alphabetical position of first letter of city name
        base_temp = 15 + (ord(city[0].lower()) - ord('a')) % 15
        
        # Add daily variation
        daily_variation = (i * 2 - 4) % 5
        
        forecast.append({
            'date': day.strftime('%Y-%m-%d'),
            'formatted_date': day.strftime('%A, %b %d'),
            'avg_temp': base_temp + daily_variation,
            'temp_min': base_temp + daily_variation - 3,
            'temp_max': base_temp + daily_variation + 3,
            'avg_humidity': 50 + (i * 5) % 30,
            'avg_wind_speed': 5 + (i * 1.5) % 10,
            'weather': weather_types[weather_index]['weather'],
            'icon': weather_types[weather_index]['icon']
        })
    
    return forecast