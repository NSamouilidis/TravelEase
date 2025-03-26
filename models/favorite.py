from utils.db_connector import fetch_one, fetch_all, insert, update, delete

class Favorite:
    def __init__(self, db_connection):
        self.db_connection = db_connection
    
    def add(self, user_id, destination_id):
        """
        Add a destination to user's favorites
        """
        # Check if already in favorites
        check_query = "SELECT id FROM favorites WHERE user_id = %s AND destination_id = %s"
        existing = fetch_one(self.db_connection, check_query, (user_id, destination_id))
        
        if existing:
            return existing['id']  # Already a favorite
        
        # Add to favorites
        query = """
        INSERT INTO favorites (user_id, destination_id, created_at)
        VALUES (%s, %s, NOW())
        """
        return insert(self.db_connection, query, (user_id, destination_id))
    
    def remove(self, favorite_id, user_id):
        """
        Remove a destination from user's favorites
        """
        query = "DELETE FROM favorites WHERE id = %s AND user_id = %s"
        rows_affected = delete(self.db_connection, query, (favorite_id, user_id))
        
        return rows_affected > 0
    
    def get_by_user_id(self, user_id):
        """
        Get all favorites for a user with destination details
        """
        query = """
        SELECT f.id, f.created_at, d.*, c.name as country_name, c.code as country_code
        FROM favorites f
        JOIN destinations d ON f.destination_id = d.id
        JOIN countries c ON d.country_id = c.id
        WHERE f.user_id = %s
        ORDER BY f.created_at DESC
        """
        favorites = fetch_all(self.db_connection, query, (user_id,))
        
        # Get attractions for each destination
        for fav in favorites:
            attractions_query = """
            SELECT * FROM attractions 
            WHERE destination_id = %s
            LIMIT 3
            """
            attractions = fetch_all(self.db_connection, attractions_query, (fav['id'],))
            fav['attractions'] = attractions
        
        return favorites
    
    def check_is_favorite(self, user_id, destination_id):
        """
        Check if a destination is in user's favorites
        """
        query = "SELECT id FROM favorites WHERE user_id = %s AND destination_id = %s"
        result = fetch_one(self.db_connection, query, (user_id, destination_id))
        
        return result is not None