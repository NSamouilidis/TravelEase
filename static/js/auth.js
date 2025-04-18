/**
 * Authentication functionality for TravelEase
 * Handles login, registration, and session management
 */

// Check if user is logged in
function checkAuthStatus() {
    const userData = localStorage.getItem('user');
    const loggedOutNav = document.getElementById('loggedOutNav');
    const loggedInNav = document.getElementById('loggedInNav');
    const usernameDisplay = document.getElementById('usernameDisplay');
    
    if (userData) {
        const user = JSON.parse(userData);
        
        if (loggedOutNav) loggedOutNav.style.display = 'none';
        if (loggedInNav) loggedInNav.style.display = 'flex';
        if (usernameDisplay) usernameDisplay.textContent = user.username;
        
        return user;
    } else {
        if (loggedOutNav) loggedOutNav.style.display = 'flex';
        if (loggedInNav) loggedInNav.style.display = 'none';
        return null;
    }
}

// Initialize auth-related functionality
function initAuth() {
    // Check authentication status
    const user = checkAuthStatus();
    
    // Setup logout functionality
    const logoutBtn = document.getElementById('logoutBtn');
    if (logoutBtn) {
        logoutBtn.addEventListener('click', () => {
            localStorage.removeItem('user');
            window.location.href = '/';
        });
    }
    
    // Mobile menu toggle
    const hamburger = document.querySelector('.hamburger');
    const navLinks = document.querySelector('.nav-links');
    
    if (hamburger && navLinks) {
        hamburger.addEventListener('click', () => {
            navLinks.classList.toggle('active');
        });
    }
    
    return user;
}

// Handle API errors
function handleApiError(error) {
    console.error('API Error:', error);
    
    if (error.response) {
        // Server responded with error
        return error.response.data.error || 'An error occurred';
    } else if (error.request) {
        // No response received
        return 'Network error. Please check your connection.';
    } else {
        // Request setup error
        return 'An unexpected error occurred.';
    }
}

// Run authentication initialization
document.addEventListener('DOMContentLoaded', initAuth);