/**
 * Hotel detail page functionality for TravelEase
 */

document.addEventListener('DOMContentLoaded', () => {
    // Initialize authentication
    const user = typeof initAuth === 'function' ? initAuth() : null;
    
    // Get hotel ID from URL
    const urlParams = new URLSearchParams(window.location.search);
    const hotelId = urlParams.get('id');
    
    if (!hotelId) {
        // Redirect to hotels page if no hotel ID specified
        window.location.href = '/hotels.html';
        return;
    }
    
    // Load hotel details
    loadHotelDetails(hotelId);
    
    // Load similar hotels
    loadSimilarHotels(hotelId);
    
    // Set minimum dates for date inputs
    const today = new Date();
    const checkInDate = document.getElementById('checkInDate');
    const checkOutDate = document.getElementById('checkOutDate');
    const guests = document.getElementById('guests');
    
    if (checkInDate && checkOutDate) {
        const todayFormatted = today.toISOString().split('T')[0];
        const tomorrowFormatted = new Date(today.setDate(today.getDate() + 1)).toISOString().split('T')[0];
        
        checkInDate.min = todayFormatted;
        checkInDate.value = todayFormatted;
        
        checkOutDate.min = tomorrowFormatted;
        checkOutDate.value = tomorrowFormatted;
        
        // Update total price when dates or guests change
        checkInDate.addEventListener('change', updateTotalPrice);
        checkOutDate.addEventListener('change', updateTotalPrice);
        
        // Ensure checkout date is after checkin date
        checkInDate.addEventListener('change', () => {
            const nextDay = new Date(checkInDate.value);
            nextDay.setDate(nextDay.getDate() + 1);
            const nextDayFormatted = nextDay.toISOString().split('T')[0];
            
            checkOutDate.min = nextDayFormatted;
            
            if (checkOutDate.value < nextDayFormatted) {
                checkOutDate.value = nextDayFormatted;
            }
            
            updateTotalPrice();
        });
    }
    
    if (guests) {
        guests.addEventListener('change', updateTotalPrice);
    }
    
    const roomType = document.getElementById('roomType');
    if (roomType) {
        roomType.addEventListener('change', updateTotalPrice);
    }
    
    // Handle booking form submission
    const bookingForm = document.getElementById('bookingForm');
    const bookNowBtn = document.getElementById('bookNowBtn');
    
    if (bookingForm) {
        bookingForm.addEventListener('submit', (e) => {
            e.preventDefault();
            
            if (!user) {
                // Redirect to login page if not logged in
                window.location.href = `/login.html?redirect=${encodeURIComponent(window.location.href)}`;
                return;
            }
            
            // Simulate booking
            bookNowBtn.disabled = true;
            bookNowBtn.textContent = 'Processing...';
            
            setTimeout(() => {
                alert('Booking successful! Check your email for confirmation details.');
                
                // Reset button
                bookNowBtn.disabled = false;
                bookNowBtn.textContent = 'Book Now';
            }, 1500);
        });
    }
});

// Hotel data for the current hotel
let currentHotel = null;

/**
 * Load hotel details from the API
 */
async function loadHotelDetails(hotelId) {
    try {
        const response = await fetch(`/api/hotels/${hotelId}`);
        
        if (!response.ok) {
            throw new Error('Failed to load hotel details');
        }
        
        const hotel = await response.json();
        currentHotel = hotel;
        
        // Update page title
        document.title = `${hotel.name} - TravelEase`;
        
        // Update hotel details
        document.getElementById('hotelName').textContent = hotel.name;
        document.getElementById('hotelLocation').innerHTML = `
            <i class="fas fa-map-marker-alt"></i>
            <span>${hotel.location}</span>
        `;
        
        // Update rating
        const ratingStars = createRatingStars(hotel.rating);
        document.getElementById('hotelRating').innerHTML = `
            <div class="stars">${ratingStars}</div>
            <span class="rating-number">${hotel.rating.toFixed(1)}</span>
            <span class="rating-count">(${Math.floor(Math.random() * 200) + 50} reviews)</span>
        `;
        
        // Update description
        document.getElementById('hotelDescription').innerHTML = `<p>${hotel.description}</p>`;
        
        // Update price
        const price = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD'
        }).format(hotel.price_per_night);
        
        document.getElementById('hotelPrice').textContent = price;
        document.getElementById('hotelId').value = hotel.id;
        
        // Initialize total price calculation
        updateTotalPrice();
        
        // Update amenities
        updateAmenities(hotel.amenities);
        
        // Update gallery
        updateGallery(hotel);
        
        // Initialize map
        initMap(hotel);
        
    } catch (error) {
        console.error('Error loading hotel details:', error);
        
        document.getElementById('hotelName').textContent = 'Error loading hotel';
        document.getElementById('hotelDescription').innerHTML = `
            <div class="error-message">
                <p>Failed to load hotel details. Please try again later.</p>
                <p><a href="/hotels.html" class="btn btn-primary">Back to Hotels</a></p>
            </div>
        `;
    }
}

/**
 * Update amenities list
 */
function updateAmenities(amenitiesString) {
    const amenitiesContainer = document.getElementById('hotelAmenities');
    
    if (!amenitiesContainer || !amenitiesString) return;
    
    const amenities = amenitiesString.split(',');
    let amenitiesHTML = '';
    
    amenities.forEach(amenity => {
        const trimmedAmenity = amenity.trim();
        const icon = getAmenityIcon(trimmedAmenity);
        
        amenitiesHTML += `
            <div class="amenity-item">
                <i class="${icon}"></i>
                <span>${trimmedAmenity}</span>
            </div>
        `;
    });
    
    amenitiesContainer.innerHTML = amenitiesHTML;
}

/**
 * Get appropriate icon for amenity
 */
function getAmenityIcon(amenity) {
    const amenityIcons = {
        'Free WiFi': 'fas fa-wifi',
        'WiFi': 'fas fa-wifi',
        'Swimming Pool': 'fas fa-swimming-pool',
        'Pool': 'fas fa-swimming-pool',
        'Spa': 'fas fa-spa',
        'Fitness Center': 'fas fa-dumbbell',
        'Gym': 'fas fa-dumbbell',
        'Restaurant': 'fas fa-utensils',
        'Room Service': 'fas fa-concierge-bell',
        'Business Center': 'fas fa-briefcase',
        'Concierge': 'fas fa-concierge-bell',
        'Airport Shuttle': 'fas fa-shuttle-van',
        'Breakfast': 'fas fa-coffee',
        'Bar': 'fas fa-glass-martini-alt',
        'Parking': 'fas fa-parking',
        'Valet Parking': 'fas fa-car',
        'Beach': 'fas fa-umbrella-beach',
        'Private Beach': 'fas fa-umbrella-beach',
        'Garden': 'fas fa-leaf',
        'Terrace': 'fas fa-umbrella',
        'Air Conditioning': 'fas fa-snowflake',
        'Family Rooms': 'fas fa-users',
        'Non-smoking Rooms': 'fas fa-smoking-ban',
        'Pet Friendly': 'fas fa-paw',
        'Accessible': 'fas fa-wheelchair'
    };
    
    return amenityIcons[amenity] || 'fas fa-check-circle';
}

/**
 * Update the gallery with hotel images
 */
function updateGallery(hotel) {
    const galleryContainer = document.getElementById('hotelGallery');
    if (!galleryContainer) return;
    
    // Create gallery with main image and additional images
    galleryContainer.innerHTML = `
        <div class="gallery-main">
            <img src="${hotel.image_url}" alt="${hotel.name}" onerror="this.src='https://source.unsplash.com/800x600/?hotel,luxury'">
        </div>
        <div class="gallery-item">
            <img src="https://source.unsplash.com/800x600/?hotel,room" alt="${hotel.name} room">
        </div>
        <div class="gallery-item">
            <img src="https://source.unsplash.com/800x600/?hotel,lobby" alt="${hotel.name} lobby">
        </div>
    `;
}

/**
 * Initialize map with hotel location
 */
function initMap(hotel) {
    const mapContainer = document.getElementById('hotelMap');
    if (!mapContainer) return;
    
    // Check if hotel has coordinates
    if (!hotel.latitude || !hotel.longitude) {
        mapContainer.innerHTML = '<div class="error-message">Map location not available</div>';
        return;
    }
    
    // Initialize map
    const map = L.map(mapContainer).setView([hotel.latitude, hotel.longitude], 14);
    
    // Add tile layer
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
        maxZoom: 19
    }).addTo(map);
    
    // Add marker
    const marker = L.marker([hotel.latitude, hotel.longitude]).addTo(map);
    
    // Add popup
    marker.bindPopup(`
        <strong>${hotel.name}</strong><br>
        ${hotel.location}
    `).openPopup();
}

/**
 * Create rating stars HTML
 */
function createRatingStars(rating) {
    let starsHTML = '';
    
    // Full stars
    const fullStars = Math.floor(rating);
    for (let i = 0; i < fullStars; i++) {
        starsHTML += '<i class="fas fa-star"></i>';
    }
    
    // Half star
    if (rating % 1 >= 0.5) {
        starsHTML += '<i class="fas fa-star-half-alt"></i>';
    }
    
    // Empty stars
    const emptyStars = 5 - Math.ceil(rating);
    for (let i = 0; i < emptyStars; i++) {
        starsHTML += '<i class="far fa-star"></i>';
    }
    
    return starsHTML;
}

/**
 * Calculate and update the total price
 */
function updateTotalPrice() {
    if (!currentHotel) return;
    
    const checkInDate = document.getElementById('checkInDate');
    const checkOutDate = document.getElementById('checkOutDate');
    const guests = document.getElementById('guests');
    const roomType = document.getElementById('roomType');
    const totalPriceElement = document.getElementById('totalPrice');
    
    if (!checkInDate || !checkOutDate || !guests || !roomType || !totalPriceElement) return;
    
    // Calculate number of nights
    const startDate = new Date(checkInDate.value);
    const endDate = new Date(checkOutDate.value);
    const nights = Math.round((endDate - startDate) / (1000 * 60 * 60 * 24));
    
    // Get base price
    let basePrice = currentHotel.price_per_night;
    
    // Apply room type multiplier
    const roomMultiplier = {
        'standard': 1,
        'deluxe': 1.3,
        'suite': 1.8
    };
    
    const selectedRoomMultiplier = roomMultiplier[roomType.value] || 1;
    basePrice *= selectedRoomMultiplier;
    
    // Apply guests fee
    const numGuests = parseInt(guests.value);
    let guestsFee = 0;
    
    if (numGuests > 2) {
        guestsFee = (numGuests - 2) * (basePrice * 0.2); // 20% extra per additional guest
    }
    
    // Calculate total
    const total = (basePrice * nights) + guestsFee;
    
    // Update total price display
    totalPriceElement.textContent = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(total);
}

/**
 * Load similar hotels
 */
async function loadSimilarHotels(hotelId) {
    const similarContainer = document.getElementById('similarHotels');
    
    if (!similarContainer) return;
    
    try {
        // First, get current hotel to find location
        const hotelResponse = await fetch(`/api/hotels/${hotelId}`);
        
        if (!hotelResponse.ok) {
            throw new Error('Failed to load hotel details');
        }
        
        const hotel = await hotelResponse.json();
        
        // Get location (city part)
        const city = hotel.location.split(',')[0].trim();
        
        // Load similar hotels from the same location
        const response = await fetch(`/api/hotels?location=${encodeURIComponent(city)}`);
        
        if (!response.ok) {
            throw new Error('Failed to load similar hotels');
        }
        
        let hotels = await response.json();
        
        // Filter out current hotel
        hotels = hotels.filter(h => h.id !== parseInt(hotelId));
        
        // Limit to 3 hotels
        hotels = hotels.slice(0, 3);
        
        // Clear loading spinner
        similarContainer.innerHTML = '';
        
        if (hotels.length === 0) {
            similarContainer.innerHTML = '<p class="no-results">No similar hotels found.</p>';
            return;
        }
        
        // Add hotels to the page
        hotels.forEach(hotel => {
            const card = createHotelCard(hotel);
            similarContainer.appendChild(card);
        });
        
    } catch (error) {
        console.error('Error loading similar hotels:', error);
        similarContainer.innerHTML = `
            <div class="error-message">
                <p>Failed to load similar hotels. Please try again later.</p>
            </div>
        `;
    }
}

/**
 * Create a hotel card element
 */
function createHotelCard(hotel) {
    const card = document.createElement('div');
    card.className = 'hotel-card';
    
    // Handle potentially null or undefined values
    const price = hotel.price_per_night || 0;
    const rating = hotel.rating || 0;
    
    // Format price as currency
    const formattedPrice = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(price);
    
    // Create rating stars
    const ratingStars = createRatingStars(rating);
    
    // Get top 3 amenities if available
    let amenitiesHTML = '';
    if (hotel.amenities) {
        const amenitiesList = hotel.amenities.split(',');
        const topAmenities = amenitiesList.slice(0, 3);
        
        amenitiesHTML = topAmenities.map(amenity => {
            const icon = getAmenityIcon(amenity.trim());
            return `
                <div class="amenity-badge">
                    <i class="${icon}"></i>
                    <span>${amenity.trim()}</span>
                </div>
            `;
        }).join('');
    }
    
    // Truncate description
    const description = hotel.description || '';
    const truncatedDescription = description.length > 100 
        ? description.substring(0, 100) + '...'
        : description;
    
    card.innerHTML = `
        <div class="hotel-img">
            <img src="${hotel.image_url}" alt="${hotel.name}" onerror="this.src='https://source.unsplash.com/800x600/?hotel'">
            <div class="hotel-price">${formattedPrice}<span class="price-per"> / night</span></div>
        </div>
        <div class="hotel-content">
            <h3>${hotel.name}</h3>
            <div class="hotel-location">
                <i class="fas fa-map-marker-alt"></i>
                <span>${hotel.location}</span>
            </div>
            <div class="hotel-rating">
                <span class="stars">${ratingStars}</span>
                <span class="rating-number">${rating.toFixed(1)}</span>
            </div>
            <p>${truncatedDescription}</p>
            <div class="hotel-amenities">
                ${amenitiesHTML}
            </div>
            <div class="hotel-meta">
                <a href="/hotel_detail.html?id=${hotel.id}" class="btn btn-primary btn-sm">View Details</a>
            </div>
        </div>
    `;
    
    return card;
}