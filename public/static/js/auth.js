function checkAuthStatus() {
    const userData = localStorage.getItem('user');
    const loggedOutNav = document.getElementById('loggedOutNav');
    const loggedInNav = document.getElementById('loggedInNav');
    const usernameDisplay = document.getElementById('usernameDisplay');
    
    if (userData) {
        const user = JSON.parse(userData);
        
        if (loggedOutNav) loggedOutNav.style.display = 'none';
        if (loggedInNav) loggedInNav.style.display = 'flex';
        if (usernameDisplay) {
            usernameDisplay.textContent = user.username;
            usernameDisplay.classList.add('nav-item');
        }
        
        return user;
    } else {
        if (loggedOutNav) loggedOutNav.style.display = 'flex';
        if (loggedInNav) loggedInNav.style.display = 'none';
        return null;
    }
}

function initAuth() {
    const user = checkAuthStatus();
    
    const logoutBtn = document.getElementById('logoutBtn');
    if (logoutBtn) {
        logoutBtn.addEventListener('click', () => {
            localStorage.removeItem('user');
            window.location.href = '/';
        });
    }
    
    const hamburger = document.querySelector('.hamburger');
    const navLinks = document.querySelector('.nav-links');
    
    if (hamburger && navLinks) {
        hamburger.addEventListener('click', () => {
            navLinks.classList.toggle('active');
        });
    }
    
    return user;
}

function handleApiError(error) {
    console.error('API Error:', error);
    
    if (error.response) {
        return error.response.data.error || 'An error occurred';
    } else if (error.request) {
        return 'Network error. Please check your connection.';
    } else {
        return 'An unexpected error occurred.';
    }
}

document.addEventListener('DOMContentLoaded', initAuth);