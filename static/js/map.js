/**
 * Map functionality for TravelEase
 */

document.addEventListener('DOMContentLoaded', () => {
    // Initialize authentication
    const user = initAuth ? initAuth() : null;
    
    // Initialize map
    initMap();
});

// Global variables
let map;
let allMarkers = [];
let destinationsData = [];
let currentFilter = 'all';

// City coordinates for our destinations (since we don't have real coordinates in the database)
const cityCoordinates = {
    'Paris, France': [48.8566, 2.3522],
    'Bali, Indonesia': [-8.4095, 115.1889],
    'Kyoto, Japan': [35.0116, 135.7681],
    'Rome, Italy': [41.9028, 12.4964],
    'Santorini, Greece': [36.3932, 25.4615],
    'New York City, USA': [40.7128, -74.0060],
    'Bangkok, Thailand': [13.7563, 100.5018],
    'Cairo, Egypt': [30.0444, 31.2357],
    'Sydney, Australia': [-33.8688, 151.2093],
    // Default coordinates for unknown locations
    'default': [0, 0]
};

/**
 * Initialize the map
 */
function initMap() {
    // Create map centered at a default location
    map = L.map('destinations-map').setView([20, 0], 2);
    
    // Add tile layer (map style)
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
        maxZoom: 19
    }).addTo(map);
    
    // Load destinations data
    loadDestinations();
    
    // Setup filter buttons
    setupFilterButtons();
}

/**
 * Load destinations from the API
 */
async function loadDestinations() {
    try {
        const response = await fetch('/api/destinations');
        
        if (!response.ok) {
            throw new Error('Failed to load destinations');
        }
        
        destinationsData = await response.json();
        
        // Add markers to the map
        addDestinationMarkers(destinationsData);
        
        // Update destination count
        updateDestinationCount(destinationsData.length);
        
    } catch (error) {
        console.error('Error loading destinations:', error);
        
        // Show error message on the map
        const mapContainer = document.getElementById('destinations-map');
        const errorElement = document.createElement('div');
        errorElement.className = 'error-message';
        errorElement.innerHTML = `
            <p>Failed to load destinations. Please try again later.</p>
            <p>Error details: ${error.message}</p>
        `;
        
        mapContainer.innerHTML = '';
        mapContainer.appendChild(errorElement);
    }
}

/**
 * Add destination markers to the map
 */
function addDestinationMarkers(destinations) {
    // Clear existing markers
    clearMarkers();
    
    // Add new markers
    destinations.forEach(destination => {
        // Get coordinates for this destination
        const coordinates = getDestinationCoordinates(destination.name);
        
        // Skip if no valid coordinates
        if (!coordinates[0] && !coordinates[1]) return;
        
        // Create marker with appropriate color based on price
        const marker = createDestinationMarker(destination, coordinates);
        
        // Add marker to the map
        marker.addTo(map);
        
        // Store marker for later filtering
        allMarkers.push(marker);
    });
    
    // If markers were added, fit map to show all markers
    if (allMarkers.length > 0) {
        const markersGroup = L.featureGroup(allMarkers);
        map.fitBounds(markersGroup.getBounds(), { padding: [50, 50] });
    }
}

/**
 * Get coordinates for a destination
 */
function getDestinationCoordinates(name) {
    // Use predefined coordinates or add slight randomization for demo purposes
    if (cityCoordinates[name]) {
        const [lat, lng] = cityCoordinates[name];
        
        // Add slight randomization to prevent markers from overlapping perfectly
        const randomLat = lat + (Math.random() - 0.5) * 0.05;
        const randomLng = lng + (Math.random() - 0.5) * 0.05;
        
        return [randomLat, randomLng];
    }
    
    // For destinations without predefined coordinates, try to extract city name
    const cityMatch = name.match(/([^,]+)/);
    if (cityMatch) {
        const cityName = cityMatch[0].trim();
        
        // Check known cities
        for (const [key, value] of Object.entries(cityCoordinates)) {
            if (key.includes(cityName)) {
                const [lat, lng] = value;
                
                // Add slight randomization
                const randomLat = lat + (Math.random() - 0.5) * 0.05;
                const randomLng = lng + (Math.random() - 0.5) * 0.05;
                
                return [randomLat, randomLng];
            }
        }
    }
    
    // Return null coordinates if not found
    return [0, 0];
}

/**
 * Create a marker for a destination
 */
function createDestinationMarker(destination, coordinates) {
    // Determine marker color based on price
    const markerColor = getMarkerColor(destination.price);
    
    // Create marker with custom icon
    const marker = L.circleMarker(coordinates, {
        radius: 8,
        fillColor: markerColor,
        color: 'white',
        weight: 2,
        opacity: 1,
        fillOpacity: 0.8
    });
    
    // Format price
    const price = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(destination.price);
    
    // Create tooltip
    marker.bindTooltip(destination.name, {
        className: 'marker-tooltip',
        direction: 'top'
    });
    
    // Create popup with destination details
    const popupContent = `
        <div class="marker-popup">
            <img src="${destination.image_url}" alt="${destination.name}" onerror="this.src='https://source.unsplash.com/800x600/?travel'">
            <h3>${destination.name}</h3>
            <div class="marker-popup-price">${price}</div>
            <a href="/place_detail.html?name=${encodeURIComponent(destination.name)}" class="btn btn-primary btn-sm">View Details</a>
        </div>
    `;
    
    marker.bindPopup(popupContent, {
        maxWidth: 300,
        minWidth: 200
    });
    
    // Add price range as a property for filtering
    marker.priceRange = getPriceRange(destination.price);
    
    return marker;
}

/**
 * Get a color for a marker based on price
 */
function getMarkerColor(price) {
    if (price < 800) {
        return '#2ecc71'; // Green for budget
    } else if (price >= 800 && price < 1100) {
        return '#f39c12'; // Orange for mid-range
    } else {
        return '#e74c3c'; // Red for luxury
    }
}

/**
 * Get price range category
 */
function getPriceRange(price) {
    if (price < 800) {
        return 'budget';
    } else if (price >= 800 && price < 1100) {
        return 'mid-range';
    } else {
        return 'luxury';
    }
}

/**
 * Clear all markers from the map
 */
function clearMarkers() {
    allMarkers.forEach(marker => {
        map.removeLayer(marker);
    });
    
    allMarkers = [];
}

/**
 * Setup filter buttons
 */
function setupFilterButtons() {
    const filterButtons = document.querySelectorAll('.filter-btn');
    
    filterButtons.forEach(button => {
        button.addEventListener('click', () => {
            // Update active button
            filterButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
            
            // Get filter value
            const filter = button.dataset.filter;
            currentFilter = filter;
            
            // Apply filter
            filterMarkers(filter);
        });
    });
}

/**
 * Filter markers based on price range
 */
function filterMarkers(filter) {
    // Clear existing markers
    clearMarkers();
    
    // Filter destinations
    let filteredDestinations;
    
    if (filter === 'all') {
        filteredDestinations = destinationsData;
    } else {
        filteredDestinations = destinationsData.filter(destination => {
            const range = getPriceRange(destination.price);
            return range === filter;
        });
    }
    
    // Add filtered markers
    addDestinationMarkers(filteredDestinations);
    
    // Update count
    updateDestinationCount(filteredDestinations.length);
}

/**
 * Update the destination count display
 */
function updateDestinationCount(count) {
    const countElement = document.getElementById('destinationCount');
    
    if (currentFilter === 'all') {
        countElement.textContent = `all ${count}`;
    } else {
        countElement.textContent = `${count} ${currentFilter}`;
    }
}