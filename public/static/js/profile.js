document.addEventListener('DOMContentLoaded', () => {
    const user = initAuth();
    
    if (!user) {
        window.location.href = '/login.html?redirect=/profile.html';
        return;
    }
    
    updateProfileInfo(user);
    
    loadUserBookings(user.id);
});

function updateProfileInfo(user) {
    const profileName = document.getElementById('profileName');
    const profileEmail = document.getElementById('profileEmail');
    
    if (profileName) {
        profileName.textContent = user.username;
    }
    
    if (profileEmail) {
        profileEmail.textContent = user.email;
    }
}

async function loadUserBookings(userId) {
    const bookingsList = document.getElementById('bookingsList');
    
    if (!bookingsList) return;
    
    try {
        bookingsList.innerHTML = `
            <div class="loading-spinner">
                <i class="fas fa-spinner fa-spin"></i>
            </div>
        `;
        
        const response = await fetch(`/api/bookings/${userId}`);
        
        if (!response.ok) {
            throw new Error(`Failed to load bookings: ${response.status} ${response.statusText}`);
        }
        
        const bookings = await response.json();
        console.log('Loaded bookings:', bookings);
        
        displayBookings(bookings, bookingsList);
        
    } catch (error) {
        console.error('Error loading bookings:', error);
        
        bookingsList.innerHTML = `
            <div class="error-message">
                <p>Failed to load your bookings. Please try again later.</p>
                <p>Error details: ${error.message}</p>
            </div>
        `;
    }
}

function displayBookings(bookings, container) {
    container.innerHTML = '';
    
    if (!bookings || bookings.length === 0) {
        container.innerHTML = `
            <div class="no-bookings">
                <p>You don't have any bookings yet.</p>
                <a href="/places.html" class="btn btn-primary">Explore Destinations</a>
            </div>
        `;
        return;
    }
    
    bookings.forEach(booking => {
        const bookingCard = createBookingCard(booking);
        container.appendChild(bookingCard);
    });
}

function createBookingCard(booking) {
    const card = document.createElement('div');
    card.className = 'booking-card';
    
    const startDate = formatDate(booking.start_date);
    const endDate = formatDate(booking.end_date);
    
    const imageUrl = booking.destination_image || 'https://cdn.pixabay.com/photo/2015/07/13/14/40/paris-843229_1280.jpg';
    
    const today = new Date();
    const tripStartDate = new Date(booking.start_date);
    const tripEndDate = new Date(booking.end_date);
    
    let tripStatus = 'confirmed';
    let statusText = 'Confirmed';
    
    if (tripStartDate > today) {
        tripStatus = 'upcoming';
        statusText = 'Upcoming';
    } else if (tripStartDate <= today && tripEndDate >= today) {
        tripStatus = 'active';
        statusText = 'Active';
    } else if (tripEndDate < today) {
        tripStatus = 'completed';
        statusText = 'Completed';
    }
    
    card.innerHTML = `
        <div class="booking-img">
            <img src="${imageUrl}" alt="${booking.destination}" onerror="this.src='https://cdn.pixabay.com/photo/2015/07/13/14/40/paris-843229_1280.jpg'">
        </div>
        <div class="booking-details">
            <h3 class="booking-destination">${booking.destination}</h3>
            <p class="booking-dates">${startDate} - ${endDate}</p>
            <div class="booking-transport"><i class="fas fa-${getTransportIcon(booking.transport)}"></i> ${booking.transport}</div>
            <div class="booking-meta">
                <div class="booking-people">
                    <i class="fas fa-user"></i> ${booking.num_people} ${parseInt(booking.num_people) === 1 ? 'Person' : 'People'}
                </div>
                <div class="booking-status ${tripStatus}">${statusText}</div>
            </div>
        </div>
    `;
    
    return card;
}

function formatDate(dateString) {
    if (!dateString) return 'N/A';
    
    try {
        const options = { year: 'numeric', month: 'short', day: 'numeric' };
        return new Date(dateString).toLocaleDateString('en-US', options);
    } catch (e) {
        console.error('Error formatting date:', e);
        return dateString; 
    }
}

function getTransportIcon(transport) {
    if (!transport) return 'route';
    
    const transportType = transport.toLowerCase();
    
    if (transportType.includes('flight') || transportType.includes('plane')) {
        return 'plane';
    } else if (transportType.includes('bus')) {
        return 'bus';
    } else if (transportType.includes('cruise') || transportType.includes('ship')) {
        return 'ship';
    } else {
        return 'route';
    }
}