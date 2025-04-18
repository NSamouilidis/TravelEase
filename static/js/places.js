/**
 * Places/Destinations page functionality for TravelEase
 */

document.addEventListener('DOMContentLoaded', () => {
    // Initialize authentication
    const user = typeof initAuth === 'function' ? initAuth() : null;
    
    // Initialize page
    loadAllDestinations();
    
    // Setup filter buttons
    const filterButtons = document.querySelectorAll('.filter-btn');
    if (filterButtons) {
        filterButtons.forEach(button => {
            button.addEventListener('click', () => {
                // Remove active class from all buttons
                filterButtons.forEach(btn => btn.classList.remove('active'));
                
                // Add active class to clicked button
                button.classList.add('active');
                
                // Apply filter
                const filter = button.dataset.filter;
                filterDestinations(filter);
            });
        });
    }
    
    // Check for search query in URL
    const urlParams = new URLSearchParams(window.location.search);
    const searchQuery = urlParams.get('search');
    
    if (searchQuery) {
        const searchInput = document.getElementById('searchInput');
        if (searchInput) {
            searchInput.value = searchQuery;
            // Filter destinations by search query
            searchDestinations(searchQuery);
        }
    }
    
    // Setup search functionality
    const searchInput = document.getElementById('searchInput');
    const searchButton = document.getElementById('searchButton');
    
    if (searchInput && searchButton) {
        // Search when enter key is pressed
        searchInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                searchDestinations(searchInput.value);
            }
        });
        
        // Search when button is clicked
        searchButton.addEventListener('click', () => {
            searchDestinations(searchInput.value);
        });
    }
});

// Store all destinations after loading
let allDestinations = [];

/**
 * Load all destinations from the API
 */
async function loadAllDestinations() {
    const destinationsContainer = document.getElementById('destinationsGrid');
    
    if (!destinationsContainer) return;
    
    try {
        // Show loading spinner
        destinationsContainer.innerHTML = `
            <div class="loading-spinner">
                <i class="fas fa-spinner fa-spin"></i>
            </div>
        `;
        
        const response = await fetch('/api/destinations');
        
        if (!response.ok) {
            throw new Error(`Failed to load destinations: ${response.status} ${response.statusText}`);
        }
        
        const destinations = await response.json();
        allDestinations = destinations; // Store for filtering
        
        // Display destinations
        displayDestinations(destinations);
        
        console.log('Destinations loaded successfully:', destinations.length);
        
    } catch (error) {
        console.error('Error loading destinations:', error);
        destinationsContainer.innerHTML = `
            <div class="error-message">
                <p>Failed to load destinations. Please try again later.</p>
                <p>Error details: ${error.message}</p>
            </div>
        `;
    }
}

/**
 * Display destinations in the grid
 */
function displayDestinations(destinations) {
    const destinationsContainer = document.getElementById('destinationsGrid');
    
    if (!destinationsContainer) return;
    
    // Clear container
    destinationsContainer.innerHTML = '';
    
    if (destinations.length === 0) {
        destinationsContainer.innerHTML = '<p class="no-results">No destinations found matching your criteria.</p>';
        return;
    }
    
    // Add destinations to the page
    destinations.forEach(destination => {
        const card = createDestinationCard(destination);
        destinationsContainer.appendChild(card);
    });
}

/**
 * Create a destination card element
 */
function createDestinationCard(destination) {
    const card = document.createElement('div');
    card.className = 'destination-card';
    
    // Handle potentially null or undefined price
    let price = 0;
    if (destination.price !== null && destination.price !== undefined) {
        price = destination.price;
    }
    
    // Format price as currency
    const formattedPrice = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(price);
    
    // Safely handle description - use empty string if null or undefined
    const description = destination.description || '';
    
    // Truncate description
    const truncatedDescription = description.length > 100 
        ? description.substring(0, 100) + '...'
        : description;
    
    card.innerHTML = `
        <div class="destination-img">
            <img src="${destination.image_url}" alt="${destination.name}" onerror="this.src='https://source.unsplash.com/800x600/?travel'">
            <div class="destination-price">${formattedPrice}</div>
        </div>
        <div class="destination-content">
            <h3>${destination.name}</h3>
            <p>${truncatedDescription}</p>
            <div class="destination-meta">
                <div class="rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                </div>
                <a href="/place_detail.html?name=${encodeURIComponent(destination.name)}" class="btn btn-primary btn-sm">View Details</a>
            </div>
        </div>
    `;
    
    return card;
}

/**
 * Filter destinations by price range
 */
function filterDestinations(filter) {
    if (!allDestinations || allDestinations.length === 0) return;
    
    let filteredDestinations = [];
    
    switch (filter) {
        case 'all':
            filteredDestinations = allDestinations;
            break;
        case 'budget':
            filteredDestinations = allDestinations.filter(d => d.price < 800);
            break;
        case 'mid-range':
            filteredDestinations = allDestinations.filter(d => d.price >= 800 && d.price < 1100);
            break;
        case 'luxury':
            filteredDestinations = allDestinations.filter(d => d.price >= 1100);
            break;
        case 'europe':
            filteredDestinations = allDestinations.filter(d => 
                d.name && (
                    d.name.toLowerCase().includes('paris') || 
                    d.name.toLowerCase().includes('rome') || 
                    d.name.toLowerCase().includes('europe')
                )
            );
            break;
        case 'asia':
            filteredDestinations = allDestinations.filter(d => 
                d.name && (
                    d.name.toLowerCase().includes('bali') || 
                    d.name.toLowerCase().includes('kyoto') || 
                    d.name.toLowerCase().includes('bangkok') || 
                    d.name.toLowerCase().includes('asia')
                )
            );
            break;
        default:
            filteredDestinations = allDestinations;
    }
    
    displayDestinations(filteredDestinations);
}

/**
 * Search destinations by name or description
 */
function searchDestinations(query) {
    if (!query || query.trim() === '') {
        displayDestinations(allDestinations);
        return;
    }
    
    query = query.toLowerCase().trim();
    
    const filteredDestinations = allDestinations.filter(destination => {
        const nameMatch = destination.name && destination.name.toLowerCase().includes(query);
        const descMatch = destination.description && destination.description.toLowerCase().includes(query);
        return nameMatch || descMatch;
    });
    
    displayDestinations(filteredDestinations);
    
    // Update page title with search query
    const headerTitle = document.querySelector('.places-header h1');
    if (headerTitle) {
        headerTitle.textContent = `Search results for "${query}"`;
    }
}