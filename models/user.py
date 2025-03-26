import hashlib
import secrets
from utils.db_connector import fetch_one, fetch_all, insert, update, delete

class User:
    def __init__(self, db_connection):
        self.db_connection = db_connection
    
    def hash_password(self, password, salt=None):
        """
        Hash the password with an optional salt
        """
        if not salt:
            salt = secrets.token_hex(16)  # Generate a random salt if not provided
        
        # Combine password and salt and hash
        hashed = hashlib.sha256((password + salt).encode()).hexdigest()
        return hashed, salt
    
    def create(self, username, email, password, first_name="", last_name=""):
        """
        Create a new user
        """
        # Check if user with email already exists
        query = "SELECT id FROM users WHERE email = %s"
        existing_user = fetch_one(self.db_connection, query, (email,))
        
        if existing_user:
            raise ValueError("User with this email already exists")
        
        # Check if username is already taken
        query = "SELECT id FROM users WHERE username = %s"
        existing_username = fetch_one(self.db_connection, query, (username,))
        
        if existing_username:
            raise ValueError("Username already taken")
        
        # Hash the password
        hashed_password, salt = self.hash_password(password)
        
        # Insert user into database
        query = """
        INSERT INTO users (username, email, password_hash, password_salt, first_name, last_name, created_at)
        VALUES (%s, %s, %s, %s, %s, %s, NOW())
        """
        user_id = insert(self.db_connection, query, (username, email, hashed_password, salt, first_name, last_name))
        
        return user_id
    
    def login(self, email, password):
        """
        Verify user credentials and return user data if valid
        """
        query = "SELECT id, username, email, password_hash, password_salt, first_name, last_name FROM users WHERE email = %s"
        user = fetch_one(self.db_connection, query, (email,))
        
        if not user:
            return None
        
        # Hash the provided password with the stored salt
        hashed_password, _ = self.hash_password(password, user['password_salt'])
        
        # Check if the hashed password matches the stored hash
        if hashed_password == user['password_hash']:
            # Remove sensitive data before returning
            del user['password_hash']
            del user['password_salt']
            return user
        
        return None
    
    def get_by_id(self, user_id):
        """
        Get user by ID
        """
        query = """
        SELECT id, username, email, first_name, last_name, created_at, last_login
        FROM users WHERE id = %s
        """
        return fetch_one(self.db_connection, query, (user_id,))
    
    def update(self, user_id, username=None, email=None, first_name=None, last_name=None):
        """
        Update user profile
        """
        # Check if user exists
        query = "SELECT id FROM users WHERE id = %s"
        user = fetch_one(self.db_connection, query, (user_id,))
        
        if not user:
            return False
        
        # Build update query based on provided fields
        update_fields = []
        params = []
        
        if username is not None:
            # Check if username is already taken by another user
            query = "SELECT id FROM users WHERE username = %s AND id != %s"
            existing_username = fetch_one(self.db_connection, query, (username, user_id))
            
            if existing_username:
                raise ValueError("Username already taken")
            
            update_fields.append("username = %s")
            params.append(username)
        
        if email is not None:
            # Check if email is already used by another user
            query = "SELECT id FROM users WHERE email = %s AND id != %s"
            existing_email = fetch_one(self.db_connection, query, (email, user_id))
            
            if existing_email:
                raise ValueError("Email already in use")
            
            update_fields.append("email = %s")
            params.append(email)
        
        if first_name is not None:
            update_fields.append("first_name = %s")
            params.append(first_name)
        
        if last_name is not None:
            update_fields.append("last_name = %s")
            params.append(last_name)
        
        # If no fields to update, return True (no changes needed)
        if not update_fields:
            return True
        
        # Add updated_at timestamp and user_id parameter
        update_fields.append("updated_at = NOW()")
        params.append(user_id)
        
        # Build the full query
        query = f"UPDATE users SET {', '.join(update_fields)} WHERE id = %s"
        
        # Execute the update query
        rows_affected = update(self.db_connection, query, params)
        
        return rows_affected > 0
    
    def change_password(self, user_id, current_password, new_password):
        """
        Change user password
        """
        # Get user data including password hash and salt
        query = "SELECT password_hash, password_salt FROM users WHERE id = %s"
        user = fetch_one(self.db_connection, query, (user_id,))
        
        if not user:
            return False
        
        # Verify current password
        hashed_current, _ = self.hash_password(current_password, user['password_salt'])
        
        if hashed_current != user['password_hash']:
            return False
        
        # Hash the new password
        hashed_new, salt = self.hash_password(new_password)
        
        # Update password in database
        query = """
        UPDATE users SET password_hash = %s, password_salt = %s, updated_at = NOW()
        WHERE id = %s
        """
        rows_affected = update(self.db_connection, query, (hashed_new, salt, user_id))
        
        return rows_affected > 0
    
    def update_last_login(self, user_id):
        """
        Update the last login timestamp for a user
        """
        query = "UPDATE users SET last_login = NOW() WHERE id = %s"
        rows_affected = update(self.db_connection, query, (user_id,))
        
        return rows_affected > 0
    
    def delete(self, user_id):
        """
        Delete a user account
        """
        query = "DELETE FROM users WHERE id = %s"
        rows_affected = delete(self.db_connection, query, (user_id,))
        
        return rows_affected > 0