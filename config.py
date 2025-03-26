import os

# Database Configuration
DATABASE_CONFIG = {
    'host': os.environ.get('DB_HOST', 'localhost'),
    'user': os.environ.get('DB_USER', 'root'),
    'password': os.environ.get('DB_PASSWORD', ''),
    'database': os.environ.get('DB_NAME', 'travelease'),
    'port': int(os.environ.get('DB_PORT', 3306))
}

# API Keys
WEATHER_API_KEY = os.environ.get('WEATHER_API_KEY', 'your_weather_api_key')