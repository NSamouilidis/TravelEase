document.addEventListener('DOMContentLoaded', () => {
    const signupForm = document.getElementById('signupForm');
    const signupError = document.getElementById('signupError');
    
    if (localStorage.getItem('user')) {
        window.location.href = '/';
        return;
    }
    
    if (signupForm) {
        signupForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            
            signupError.style.display = 'none';
            
            const username = document.getElementById('username').value;
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const terms = document.querySelector('input[name="terms"]').checked;
            
            if (!username || !email || !password || !confirmPassword) {
                signupError.textContent = 'Please fill in all fields.';
                signupError.style.display = 'block';
                return;
            }
            
            if (password !== confirmPassword) {
                signupError.textContent = 'Passwords do not match.';
                signupError.style.display = 'block';
                return;
            }
            
            if (!terms) {
                signupError.textContent = 'You must agree to the Terms of Service and Privacy Policy.';
                signupError.style.display = 'block';
                return;
            }
            
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                signupError.textContent = 'Please enter a valid email address.';
                signupError.style.display = 'block';
                return;
            }
            
            try {
                const response = await fetch('/register', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ username, email, password }),
                });
                
                const data = await response.json();
                
                if (!response.ok) {
                    signupError.textContent = data.error || 'Registration failed. Please try again.';
                    signupError.style.display = 'block';
                    return;
                }
                
                const loginResponse = await fetch('/login', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ username, password }),
                });
                
                const loginData = await loginResponse.json();
                
                if (!loginResponse.ok) {
                    window.location.href = '/login.html';
                    return;
                }
                
                localStorage.setItem('user', JSON.stringify(loginData.user));
                
                window.location.href = '/';
                
            } catch (error) {
                console.error('Registration error:', error);
                signupError.textContent = 'An unexpected error occurred. Please try again.';
                signupError.style.display = 'block';
            }
        });
    }
    
    const socialButtons = document.querySelectorAll('.social-btn');
    if (socialButtons) {
        socialButtons.forEach(btn => {
            btn.addEventListener('click', () => {
                alert('Social login is not implemented in this demo.');
            });
        });
    }
});