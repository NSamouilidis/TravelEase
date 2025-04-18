/**
 * Login functionality for TravelEase
 */

document.addEventListener('DOMContentLoaded', () => {
    const loginForm = document.getElementById('loginForm');
    const loginError = document.getElementById('loginError');
    
    // Already logged in, redirect to home
    if (localStorage.getItem('user')) {
        window.location.href = '/';
        return;
    }
    
    if (loginForm) {
        loginForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            
            // Hide previous error messages
            loginError.style.display = 'none';
            
            // Get form data
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            
            // Validate input
            if (!username || !password) {
                loginError.textContent = 'Please enter both username and password.';
                loginError.style.display = 'block';
                return;
            }
            
            try {
                // Submit login request
                const response = await fetch('/login', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ username, password }),
                });
                
                const data = await response.json();
                
                if (!response.ok) {
                    // Display error message
                    loginError.textContent = data.error || 'Login failed. Please try again.';
                    loginError.style.display = 'block';
                    return;
                }
                
                // Login successful
                localStorage.setItem('user', JSON.stringify(data.user));
                
                // Redirect to home page or previous page
                const redirect = new URLSearchParams(window.location.search).get('redirect') || '/';
                window.location.href = redirect;
                
            } catch (error) {
                console.error('Login error:', error);
                loginError.textContent = 'An unexpected error occurred. Please try again.';
                loginError.style.display = 'block';
            }
        });
    }
    
    // Social login buttons (just placeholders for now)
    const socialButtons = document.querySelectorAll('.social-btn');
    if (socialButtons) {
        socialButtons.forEach(btn => {
            btn.addEventListener('click', () => {
                alert('Social login is not implemented in this demo.');
            });
        });
    }
});