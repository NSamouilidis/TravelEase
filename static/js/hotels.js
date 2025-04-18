/**
 * Hotels functionality for TravelEase
 */

document.addEventListener('DOMContentLoaded', () => {
    // Initialize authentication
    const user = typeof initAuth === 'function' ? initAuth() : null;
    
    // Load featured hotels
    loadFeaturedHotels();
    
    // Load all hotels
    loadAllHotels();
    
    // Setup location filter dropdown
    populateLocationDropdown();
    
    // Setup search functionality
    const searchInput = document.getElementById('searchInput');
    const searchButton = document.getElementById('searchButton');
    
    if (searchInput && searchButton) {
        // Search when enter key is pressed
        searchInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                searchHotels(searchInput.value);
            }
        });
        
        // Search when button is clicked
        searchButton.addEventListener('click', () => {
            searchHotels(searchInput.value);
        });
    }
    
    // Setup filter button
    const filterButton = document.getElementById('filterButton');
    if (filterButton) {
        filterButton.addEventListener('click', applyFilters);
    }
    
    // Setup star rating filter buttons
    const starFilters = document.querySelectorAll('.star-filter');
    starFilters.forEach(filter => {
        filter.addEventListener('click', () => {
            // Toggle active class
            starFilters.forEach(f => f.classList.remove('active'));
            filter.classList.add('active');
        });
    });
});

// Store all hotels after loading
let allHotels = [];
let allLocations = new Set();

/**
 * Load featured hotels from the API
 */
async function loadFeaturedHotels() {
    const featuredContainer = document.getElementById('featuredHotels');
    
    if (!featuredContainer) return;
    
    try {
        const response = await fetch('/api/hotels/featured');
        
        if (!response.ok) {
            throw new Error(`Failed to load hotels: ${response.status} ${response.statusText}`);
        }
        
        const hotels = await response.json();
        
        // Clear loading spinner
        featuredContainer.innerHTML = '';
        
        if (hotels.length === 0) {
            featuredContainer.innerHTML = '<p class="no-results">No featured hotels found.</p>';
            return;
        }
        
        // Add hotels to the page
        hotels.forEach(hotel => {
            const card = createHotelCard(hotel);
            featuredContainer.appendChild(card);
        });
        
        console.log('Featured hotels loaded successfully:', hotels.length);
        
    } catch (error) {
        console.error('Error loading featured hotels:', error);
        featuredContainer.innerHTML = `
            <div class="error-message">
                <p>Failed to load featured hotels. Please try again later.</p>
                <p>Error details: ${error.message}</p>
            </div>
        `;
    }
}

/**
 * Load all hotels from the API
 */
async function loadAllHotels() {
    const hotelsContainer = document.getElementById('hotelsGrid');
    
    if (!hotelsContainer) return;
    
    try {
        const response = await fetch('/api/hotels');
        
        if (!response.ok) {
            throw new Error(`Failed to load hotels: ${response.status} ${response.statusText}`);
        }
        
        const hotels = await response.json();
        allHotels = hotels; // Store for filtering
        
        // Extract all unique locations for filter dropdown
        hotels.forEach(hotel => {
            if (hotel.location) {
                // Extract city from location (before the comma)
                const city = hotel.location.split(',')[0].trim();
                allLocations.add(city);
            }
        });
        
        // Display hotels
        displayHotels(hotels);
        
        console.log('Hotels loaded successfully:', hotels.length);
        
    } catch (error) {
        console.error('Error loading hotels:', error);
        hotelsContainer.innerHTML = `
            <div class="error-message">
                <p>Failed to load hotels. Please try again later.</p>
                <p>Error details: ${error.message}</p>
            </div>
        `;
    }
}

/**
 * Display hotels in the grid
 */
function displayHotels(hotels) {
    const hotelsContainer = document.getElementById('hotelsGrid');
    
    if (!hotelsContainer) return;
    
    // Clear container
    hotelsContainer.innerHTML = '';
    
    if (hotels.length === 0) {
        hotelsContainer.innerHTML = '<p class="no-results">No hotels found matching your criteria.</p>';
        return;
    }
    
    // Add hotels to the page
    hotels.forEach(hotel => {
        const card = createHotelCard(hotel);
        hotelsContainer.appendChild(card);
    });
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
                <a href="#" class="btn btn-primary btn-sm">View Details</a>
            </div>
        </div>
    `;
    
    return card;
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
 * Populate location dropdown with unique locations
 */
function populateLocationDropdown() {
    const locationFilter = document.getElementById('locationFilter');
    
    if (!locationFilter) return;
    
    // Wait for locations to be loaded
    setTimeout(() => {
        // Sort locations alphabetically
        const sortedLocations = [...allLocations].sort();
        
        // Add options to dropdown
        sortedLocations.forEach(location => {
            const option = document.createElement('option');
            option.value = location;
            option.textContent = location;
            locationFilter.appendChild(option);
        });
    }, 1000);
}

/**
 * Search hotels by name or location
 */
async function searchHotels(query) {
    if (!query || query.trim() === '') {
        displayHotels(allHotels);
        return;
    }
    
    const hotelsContainer = document.getElementById('hotelsGrid');
    
    if (!hotelsContainer) return;
    
    try {
        // Show loading spinner
        hotelsContainer.innerHTML = `
            <div class="loading-spinner">
                <i class="fas fa-spinner fa-spin"></i>
            </div>
        `;
        
        const response = await fetch(`/api/hotels/search?q=${encodeURIComponent(query)}`);
        
        if (!response.ok) {
            throw new Error(`Search failed: ${response.status} ${response.statusText}`);
        }
        
        const hotels = await response.json();
        
        // Display search results
        displayHotels(hotels);
        
    } catch (error) {
        console.error('Error searching hotels:', error);
        hotelsContainer.innerHTML = `
            <div class="error-message">
                <p>Failed to search hotels. Please try again later.</p>
                <p>Error details: ${error.message}</p>
            </div>
        `;
    }
}

/**
 * Apply filters to hotels
 */
async function applyFilters() {
    const hotelsContainer = document.getElementById('hotelsGrid');
    
    if (!hotelsContainer) return;
    
    // Get filter values
    const location = document.getElementById('locationFilter').value;
    const maxPrice = document.getElementById('priceFilter').value;
    const activeStarFilter = document.querySelector('.star-filter.active');
    const minRating = activeStarFilter ? activeStarFilter.dataset.rating : 0;
    
    // Construct query parameters
    const params = new URLSearchParams();
    if (location) params.append('location', location);
    if (maxPrice) params.append('max_price', maxPrice);
    if (minRating && minRating !== '0') params.append('min_rating', minRating);
    
    // If no filters selected, just show all hotels
    if ([...params].length === 0) {
        displayHotels(allHotels);
        return;
    }
    
    try {
        // Show loading spinner
        hotelsContainer.innerHTML = `
            <div class="loading-spinner">
                <i class="fas fa-spinner fa-spin"></i>
            </div>
        `;
        
        const response = await fetch(`/api/hotels?${params.toString()}`);
        
        if (!response.ok) {
            throw new Error(`Filtering failed: ${response.status} ${response.statusText}`);
        }
        
        const hotels = await response.json();
        
        // Display filtered hotels
        displayHotels(hotels);
        
    } catch (error) {
        console.error('Error filtering hotels:', error);
        hotelsContainer.innerHTML = `
            <div class="error-message">
                <p>Failed to filter hotels. Please try again later.</p>
                <p>Error details: ${error.message}</p>
            </div>
        `;
    }
}