document.addEventListener('DOMContentLoaded', () => {
    const user = initAuth ? initAuth() : null;
    
    initMap();
});

let map;
let allMarkers = [];
let destinationsData = [];
let currentFilter = 'all';

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
    'Machu Picchu, Peru': [-13.1631, -72.5450],
    'Barcelona, Spain': [41.3851, 2.1734],
    'Marrakech, Morocco': [31.6295, -7.9811],
    'Queenstown, New Zealand': [-45.0312, 168.6626],
    'Prague, Czech Republic': [50.0755, 14.4378],
    'Rio de Janeiro, Brazil': [-22.9068, -43.1729],
    'Petra, Jordan': [30.3285, 35.4444],
    'Venice, Italy': [45.4408, 12.3155],
    'Bora Bora, French Polynesia': [-16.5004, -151.7415],
    'Amsterdam, Netherlands': [52.3676, 4.9041],
    'Serengeti National Park, Tanzania': [-2.1540, 34.6857],
    'Istanbul, Turkey': [41.0082, 28.9784],
    'Great Barrier Reef, Australia': [-18.2871, 147.6992],
    'Dubrovnik, Croatia': [42.6507, 18.0944],
    'Angkor Wat, Cambodia': [13.4125, 103.8670],
    'Reykjavik, Iceland': [64.1466, -21.9426],
    'Havana, Cuba': [23.1136, -82.3666],
    'Cinque Terre, Italy': [44.1461, 9.6439],
    'Galápagos Islands, Ecuador': [-0.9538, -90.9656],
    'Cappadocia, Turkey': [38.6431, 34.8307],
    'Budapest, Hungary': [47.4979, 19.0402],
    'Ha Long Bay, Vietnam': [20.9101, 107.1839],
    'Amalfi Coast, Italy': [40.6340, 14.6027],
    'Yellowstone National Park, USA': [44.4280, -110.5885],
    'St. Petersburg, Russia': [59.9311, 30.3609],
    'Maui, Hawaii, USA': [20.7984, -156.3319],
    'Cusco, Peru': [-13.5320, -71.9675],
    'default': [0, 0]
};

function initMap() {
    map = L.map('destinations-map').setView([20, 0], 2);
    
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
        maxZoom: 19
    }).addTo(map);
    
    loadDestinations();
    
    setupFilterButtons();
}

async function loadDestinations() {
    try {
        const response = await fetch('/api/destinations');
        
        if (!response.ok) {
            throw new Error('Failed to load destinations');
        }
        
        destinationsData = await response.json();
        
       
        addDestinationMarkers(destinationsData);
        
        updateDestinationCount(destinationsData.length);
        
    } catch (error) {
        console.error('Error loading destinations:', error);
        
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

function addDestinationMarkers(destinations) {
    clearMarkers();
    
    destinations.forEach(destination => {
        const coordinates = getDestinationCoordinates(destination.name);
        
        if (!coordinates[0] && !coordinates[1]) return;
        
        const marker = createDestinationMarker(destination, coordinates);
        
        marker.addTo(map);
        
        allMarkers.push(marker);
    });
    
    if (allMarkers.length > 0) {
        const markersGroup = L.featureGroup(allMarkers);
        map.fitBounds(markersGroup.getBounds(), { padding: [50, 50] });
    }
}


function getDestinationCoordinates(name) {
    if (cityCoordinates[name]) {
        const [lat, lng] = cityCoordinates[name];
        
        const randomLat = lat + (Math.random() - 0.5) * 0.05;
        const randomLng = lng + (Math.random() - 0.5) * 0.05;
        
        return [randomLat, randomLng];
    }
    
    const cityMatch = name.match(/([^,]+)/);
    if (cityMatch) {
        const cityName = cityMatch[0].trim();
        
        for (const [key, value] of Object.entries(cityCoordinates)) {
            if (key.includes(cityName)) {
                const [lat, lng] = value;
                
                const randomLat = lat + (Math.random() - 0.5) * 0.05;
                const randomLng = lng + (Math.random() - 0.5) * 0.05;
                
                return [randomLat, randomLng];
            }
        }
    }
    
    return [0, 0];
}

function createDestinationMarker(destination, coordinates) {
    const markerColor = getMarkerColor(destination.price);
    
    const marker = L.circleMarker(coordinates, {
        radius: 8,
        fillColor: markerColor,
        color: 'white',
        weight: 2,
        opacity: 1,
        fillOpacity: 0.8
    });
    
    const price = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(destination.price);
    
    marker.bindTooltip(destination.name, {
        className: 'marker-tooltip',
        direction: 'top'
    });
    
    const imageUrl = destination.image_url || 'https://source.unsplash.com/800x600/?travel,destination';
    
    const popupContent = `
        <div class="marker-popup">
            <img src="${imageUrl}" alt="${destination.name}" onerror="this.src='https://source.unsplash.com/800x600/?travel'">
            <h3>${destination.name}</h3>
            <div class="marker-popup-price">${price}</div>
            <a href="/place_detail.html?name=${encodeURIComponent(destination.name)}" class="btn btn-primary btn-sm">View Details</a>
        </div>
    `;
    
    marker.bindPopup(popupContent, {
        maxWidth: 300,
        minWidth: 200
    });
    
    marker.priceRange = getPriceRange(destination.price);
    
    return marker;
}

function getMarkerColor(price) {
    if (price < 800) {
        return '#2ecc71'; 
    } else if (price >= 800 && price < 1100) {
        return '#f39c12'; 
    } else {
        return '#e74c3c'; 
    }
}

function getPriceRange(price) {
    if (price < 800) {
        return 'budget';
    } else if (price >= 800 && price < 1100) {
        return 'mid-range';
    } else {
        return 'luxury';
    }
}


function clearMarkers() {
    allMarkers.forEach(marker => {
        map.removeLayer(marker);
    });
    
    allMarkers = [];
}


function setupFilterButtons() {
    const filterButtons = document.querySelectorAll('.filter-btn');
    
    filterButtons.forEach(button => {
        button.addEventListener('click', () => {
            filterButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
            
            const filter = button.dataset.filter;
            currentFilter = filter;
            
            filterMarkers(filter);
        });
    });
}

function filterMarkers(filter) {
    clearMarkers();
    
    let filteredDestinations;
    
    if (filter === 'all') {
        filteredDestinations = destinationsData;
    } else {
        filteredDestinations = destinationsData.filter(destination => {
            const range = getPriceRange(destination.price);
            return range === filter;
        });
    }
    
   
    addDestinationMarkers(filteredDestinations);
    
    
    updateDestinationCount(filteredDestinations.length);
}


function updateDestinationCount(count) {
    const countElement = document.getElementById('destinationCount');
    
    if (currentFilter === 'all') {
        countElement.textContent = `all ${count}`;
    } else {
        countElement.textContent = `${count} ${currentFilter}`;
    }
}