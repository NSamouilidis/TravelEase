from utils.db_connector import fetch_one, fetch_all, insert, update, delete

class Destination:
    def __init__(self, db_connection):
        self.db_connection = db_connection
    
    def get_by_id(self, destination_id):
        """
        Get destination by ID
        """
        query = """
        SELECT d.*, c.name as country_name, c.code as country_code
        FROM destinations d
        JOIN countries c ON d.country_id = c.id
        WHERE d.id = %s
        """
        destination = fetch_one(self.db_connection, query, (destination_id,))
        
        if destination:
            # Get attractions for this destination
            attractions_query = """
            SELECT * FROM attractions 
            WHERE destination_id = %s
            """
            attractions = fetch_all(self.db_connection, attractions_query, (destination_id,))
            destination['attractions'] = attractions
            
            # Get transportation options
            transport_query = """
            SELECT t.* FROM transportation t
            JOIN destination_transportation dt ON t.id = dt.transportation_id
            WHERE dt.destination_id = %s
            """
            transportation = fetch_all(self.db_connection, transport_query, (destination_id,))
            destination['transportation'] = transportation
        
        return destination
    
    def search(self, country=None, city=None, budget_min=None, budget_max=None, limit=10, offset=0):
        """
        Search destinations with basic filters
        """
        query = """
        SELECT d.*, c.name as country_name, c.code as country_code
        FROM destinations d
        JOIN countries c ON d.country_id = c.id
        WHERE 1=1
        """
        params = []
        
        # Add filters
        if country:
            query += " AND (c.name LIKE %s OR c.code LIKE %s)"
            params.extend([f"%{country}%", f"%{country}%"])
        
        if city:
            query += " AND d.city LIKE %s"
            params.append(f"%{city}%")
        
        if budget_min is not None:
            query += " AND d.avg_cost_per_day >= %s"
            params.append(float(budget_min))
        
        if budget_max is not None:
            query += " AND d.avg_cost_per_day <= %s"
            params.append(float(budget_max))
        
        # Add ordering
        query += " ORDER BY d.popularity DESC"
        
        # Add pagination
        query += " LIMIT %s OFFSET %s"
        params.extend([int(limit), int(offset)])
        
        destinations = fetch_all(self.db_connection, query, params)
        
        # Get attractions for each destination
        for dest in destinations:
            attractions_query = """
            SELECT * FROM attractions 
            WHERE destination_id = %s
            LIMIT 5
            """
            attractions = fetch_all(self.db_connection, attractions_query, (dest['id'],))
            dest['attractions'] = attractions
        
        return destinations
    
    def advanced_search(self, country=None, city=None, budget_min=None, budget_max=None, 
                        interests=None, weather_condition=None, trip_duration=None, 
                        limit=10, offset=0):
        """
        Advanced search with more filters
        """
        query = """
        SELECT DISTINCT d.*, c.name as country_name, c.code as country_code
        FROM destinations d
        JOIN countries c ON d.country_id = c.id
        """
        
        params = []
        where_clauses = ["1=1"]
        
        # Add interest tags filter if provided
        if interests and len(interests) > 0:
            query += """
            JOIN destination_tags dt ON d.id = dt.destination_id
            JOIN tags t ON dt.tag_id = t.id
            """
            interest_placeholders = ", ".join(["%s"] * len(interests))
            where_clauses.append(f"t.name IN ({interest_placeholders})")
            params.extend(interests)
        
        # Add weather condition filter if provided
        if weather_condition:
            where_clauses.append("d.weather_type LIKE %s")
            params.append(f"%{weather_condition}%")
        
        # Add trip duration filter if provided
        if trip_duration:
            if trip_duration == "short":
                where_clauses.append("d.recommended_days <= 3")
            elif trip_duration == "medium":
                where_clauses.append("d.recommended_days BETWEEN 4 AND 7")
            elif trip_duration == "long":
                where_clauses.append("d.recommended_days > 7")
        
        # Add country filter if provided
        if country:
            where_clauses.append("(c.name LIKE %s OR c.code LIKE %s)")
            params.extend([f"%{country}%", f"%{country}%"])
        
        # Add city filter if provided
        if city:
            where_clauses.append("d.city LIKE %s")
            params.append(f"%{city}%")
        
        # Add budget filters if provided
        if budget_min is not None:
            where_clauses.append("d.avg_cost_per_day >= %s")
            params.append(float(budget_min))
        
        if budget_max is not None:
            where_clauses.append("d.avg_cost_per_day <= %s")
            params.append(float(budget_max))
        
        # Combine all WHERE clauses
        query += " WHERE " + " AND ".join(where_clauses)
        
        # Add ordering
        query += " ORDER BY d.popularity DESC"
        
        # Add pagination
        query += " LIMIT %s OFFSET %s"
        params.extend([int(limit), int(offset)])
        
        destinations = fetch_all(self.db_connection, query, params)
        
        # Get attractions for each destination
        for dest in destinations:
            attractions_query = """
            SELECT * FROM attractions 
            WHERE destination_id = %s
            LIMIT 5
            """
            attractions = fetch_all(self.db_connection, attractions_query, (dest['id'],))
            dest['attractions'] = attractions
            
            # Get transportation options
            transport_query = """
            SELECT t.* FROM transportation t
            JOIN destination_transportation dt ON t.id = dt.transportation_id
            WHERE dt.destination_id = %s
            """
            transportation = fetch_all(self.db_connection, transport_query, (dest['id'],))
            dest['transportation'] = transportation
            
            # Get tags/interests
            tags_query = """
            SELECT t.name FROM tags t
            JOIN destination_tags dt ON t.id = dt.tag_id
            WHERE dt.destination_id = %s
            """
            tags = fetch_all(self.db_connection, tags_query, (dest['id'],))
            dest['tags'] = [tag['name'] for tag in tags]
        
        return destinations
    
    def get_popular_destinations(self, limit=10):
        """
        Get the most popular destinations
        """
        query = """
        SELECT d.*, c.name as country_name, c.code as country_code
        FROM destinations d
        JOIN countries c ON d.country_id = c.id
        ORDER BY d.popularity DESC
        LIMIT %s
        """
        return fetch_all(self.db_connection, query, (limit,))
    
    def get_destinations_by_country(self, country_id, limit=10):
        """
        Get destinations by country
        """
        query = """
        SELECT d.*, c.name as country_name, c.code as country_code
        FROM destinations d
        JOIN countries c ON d.country_id = c.id
        WHERE d.country_id = %s
        ORDER BY d.popularity DESC
        LIMIT %s
        """
        return fetch_all(self.db_connection, query, (country_id, limit))
    
    def get_recommendations(self, user_id, limit=5):
        """
        Get personalized destination recommendations for a user
        based on their previous trips and favorites
        """
        query = """
        SELECT DISTINCT d.*, c.name as country_name, c.code as country_code
        FROM destinations d
        JOIN countries c ON d.country_id = c.id
        LEFT JOIN destination_tags dt1 ON d.id = dt1.destination_id
        WHERE dt1.tag_id IN (
            -- Tags from user's favorite destinations
            SELECT DISTINCT dt2.tag_id
            FROM favorites f
            JOIN destinations fav_d ON f.destination_id = fav_d.id
            JOIN destination_tags dt2 ON fav_d.id = dt2.destination_id
            WHERE f.user_id = %s
            
            UNION
            
            -- Tags from user's past trips
            SELECT DISTINCT dt3.tag_id
            FROM trips t
            JOIN destinations trip_d ON t.destination_id = trip_d.id
            JOIN destination_tags dt3 ON trip_d.id = dt3.destination_id
            WHERE t.user_id = %s
        )
        -- Exclude destinations already visited or favorited
        AND d.id NOT IN (
            SELECT DISTINCT destination_id FROM favorites WHERE user_id = %s
            UNION
            SELECT DISTINCT destination_id FROM trips WHERE user_id = %s
        )
        ORDER BY d.popularity DESC
        LIMIT %s
        """
        return fetch_all(self.db_connection, query, (user_id, user_id, user_id, user_id, limit))