from utils.db_connector import fetch_one, fetch_all, insert, update, delete
from datetime import datetime

class Trip:
    def __init__(self, db_connection):
        self.db_connection = db_connection
    
    def create(self, user_id, destination_id, start_date, end_date, notes="", budget=0):
        """
        Create a new trip plan
        """
        # Convert string dates to datetime objects if needed
        if isinstance(start_date, str):
            start_date = datetime.strptime(start_date, '%Y-%m-%d').date()
        
        if isinstance(end_date, str):
            end_date = datetime.strptime(end_date, '%Y-%m-%d').date()
        
        # Ensure end date is after start date
        if end_date < start_date:
            raise ValueError("End date must be after start date")
        
        query = """
        INSERT INTO trips (user_id, destination_id, start_date, end_date, notes, budget, created_at)
        VALUES (%s, %s, %s, %s, %s, %s, NOW())
        """
        return insert(self.db_connection, query, (user_id, destination_id, start_date, end_date, notes, budget))
    
    def update(self, trip_id, user_id, start_date=None, end_date=None, notes=None, budget=None):
        """
        Update a trip plan
        """
        # Get current trip data
        current_trip = self.get_by_id(trip_id, user_id)
        if not current_trip:
            return False
        
        # Prepare update fields and params
        update_fields = []
        params = []
        
        if start_date is not None:
            # Convert string date to datetime if needed
            if isinstance(start_date, str):
                start_date = datetime.strptime(start_date, '%Y-%m-%d').date()
            
            update_fields.append("start_date = %s")
            params.append(start_date)
            
            # If end_date is not being updated, check that new start_date is before current end_date
            if end_date is None and start_date > current_trip['end_date']:
                raise ValueError("Start date must be before end date")
        
        if end_date is not None:
            # Convert string date to datetime if needed
            if isinstance(end_date, str):
                end_date = datetime.strptime(end_date, '%Y-%m-%d').date()
            
            update_fields.append("end_date = %s")
            params.append(end_date)
            
            # If start_date is not being updated, check that new end_date is after current start_date
            if start_date is None and end_date < current_trip['start_date']:
                raise ValueError("End date must be after start date")
        
        # If both dates are being updated, check they are valid
        if start_date is not None and end_date is not None and end_date < start_date:
            raise ValueError("End date must be after start date")
        
        if notes is not None:
            update_fields.append("notes = %s")
            params.append(notes)
        
        if budget is not None:
            update_fields.append("budget = %s")
            params.append(budget)
        
        # If no fields to update, return True (no changes needed)
        if not update_fields:
            return True
        
        # Add updated_at timestamp and parameters for WHERE clause
        update_fields.append("updated_at = NOW()")
        params.extend([trip_id, user_id])
        
        # Build the full query
        query = f"""
        UPDATE trips SET {', '.join(update_fields)}
        WHERE id = %s AND user_id = %s
        """
        
        # Execute the update query
        rows_affected = update(self.db_connection, query, params)
        
        return rows_affected > 0
    
    def delete(self, trip_id, user_id):
        """
        Delete a trip plan
        """
        query = "DELETE FROM trips WHERE id = %s AND user_id = %s"
        rows_affected = delete(self.db_connection, query, (trip_id, user_id))
        
        return rows_affected > 0
    
    def get_by_id(self, trip_id, user_id):
        """
        Get trip details by ID for a specific user
        """
        query = """
        SELECT t.*, d.city, d.description, d.image_url, c.name as country_name
        FROM trips t
        JOIN destinations d ON t.destination_id = d.id
        JOIN countries c ON d.country_id = c.id
        WHERE t.id = %s AND t.user_id = %s
        """
        trip = fetch_one(self.db_connection, query, (trip_id, user_id))
        
        if trip:
            # Get attractions for this destination
            attractions_query = """
            SELECT * FROM attractions 
            WHERE destination_id = %s
            """
            attractions = fetch_all(self.db_connection, attractions_query, (trip['destination_id'],))
            trip['attractions'] = attractions
            
            # Get transportation options
            transport_query = """
            SELECT t.* FROM transportation t
            JOIN destination_transportation dt ON t.id = dt.transportation_id
            WHERE dt.destination_id = %s
            """
            transportation = fetch_all(self.db_connection, transport_query, (trip['destination_id'],))
            trip['transportation'] = transportation
        
        return trip
    
    def get_by_user_id(self, user_id, include_past=True):
        """
        Get all trips for a user
        """
        today = datetime.now().date()
        
        condition = "1=1" if include_past else "t.end_date >= %s"
        params = [user_id] if include_past else [user_id, today]
        
        query = f"""
        SELECT t.*, d.city, d.image_url, c.name as country_name
        FROM trips t
        JOIN destinations d ON t.destination_id = d.id
        JOIN countries c ON d.country_id = c.id
        WHERE t.user_id = %s AND {condition}
        ORDER BY t.start_date
        """
        
        return fetch_all(self.db_connection, query, params)
    
    def get_upcoming_trips(self, user_id, limit=3):
        """
        Get upcoming trips for a user
        """
        today = datetime.now().date()
        
        query = """
        SELECT t.*, d.city, d.image_url, c.name as country_name
        FROM trips t
        JOIN destinations d ON t.destination_id = d.id
        JOIN countries c ON d.country_id = c.id
        WHERE t.user_id = %s AND t.start_date >= %s
        ORDER BY t.start_date
        LIMIT %s
        """
        
        return fetch_all(self.db_connection, query, (user_id, today, limit))
    
    def get_past_trips(self, user_id, limit=5):
        """
        Get past trips for a user
        """
        today = datetime.now().date()
        
        query = """
        SELECT t.*, d.city, d.image_url, c.name as country_name
        FROM trips t
        JOIN destinations d ON t.destination_id = d.id
        JOIN countries c ON d.country_id = c.id
        WHERE t.user_id = %s AND t.end_date < %s
        ORDER BY t.end_date DESC
        LIMIT %s
        """
        
        return fetch_all(self.db_connection, query, (user_id, today, limit))