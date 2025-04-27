const DEFAULT_USER_IMAGE = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';

function updateProfileImages() {
    const profileAvatars = document.querySelectorAll('.profile-avatar img');
    profileAvatars.forEach(img => {
        img.src = DEFAULT_USER_IMAGE;
        img.onerror = function() { this.src = DEFAULT_USER_IMAGE; };
    });
    
    const reviewAvatars = document.querySelectorAll('.testimonial-author .avatar img, .reviewer-info .avatar img');
    reviewAvatars.forEach(img => {
        img.src = DEFAULT_USER_IMAGE;
        img.onerror = function() { this.src = DEFAULT_USER_IMAGE; };
    });
    
    const userAvatars = document.querySelectorAll('.user-avatar img, .avatar img');
    userAvatars.forEach(img => {
        img.src = DEFAULT_USER_IMAGE;
        img.onerror = function() { this.src = DEFAULT_USER_IMAGE; };
    });
    
    console.log('All user profile images updated to use default image');
}

document.addEventListener('DOMContentLoaded', updateProfileImages);