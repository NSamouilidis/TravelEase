/**
 * Itineraries functionality for TravelEase
 */

document.addEventListener('DOMContentLoaded', () => {
    // Initialize authentication
    const user = initAuth ? initAuth() : null;
    
    // Load featured itineraries
    loadFeaturedItineraries();
    
    // Load all itineraries
    loadAllItineraries();
    
    // Setup filter buttons
    setupFilterButtons();
});

// Sample itinerary data (since we don't have a real itineraries table in the database yet)
const sampleItineraries = [
    {
        id: 1,
        title: "European Highlights",
        type: "cultural",
        featured: true,
        days: 10,
        price: 2500,
        image: "https://source.unsplash.com/800x600/?europe",
        author: "Travel Team",
        date: "2023-06-15",
        description: "Experience the best of Europe with this carefully curated itinerary covering iconic landmarks and hidden gems.",
        destinations: ["Paris, France", "Rome, Italy", "Santorini, Greece"]
    },
    {
        id: 2,
        title: "Asian Adventure",
        type: "adventure",
        featured: true,
        days: 14,
        price: 3200,
        image: "https://source.unsplash.com/800x600/?asia",
        author: "Adventure Guides",
        date: "2023-07-10",
        description: "Embark on an unforgettable journey through the diverse landscapes and cultures of Asia.",
        destinations: ["Kyoto, Japan", "Bangkok, Thailand", "Bali, Indonesia"]
    },
    {
        id: 3,
        title: "American Road Trip",
        type: "adventure",
        featured: false,
        days: 7,
        price: 1800,
        image: "https://source.unsplash.com/800x600/?usa",
        author: "Road Warriors",
        date: "2023-08-05",
        description: "Hit the open road and discover the breathtaking landscapes and vibrant cities of America.",
        destinations: ["New York City, USA", "Las Vegas, USA", "San Francisco, USA"]
    },
    {
        id: 4,
        title: "Tropical Paradise",
        type: "beach",
        featured: true,
        days: 7,
        price: 2100,
        image: "https://source.unsplash.com/800x600/?beach",
        author: "Beach Lovers",
        date: "2023-09-20",
        description: "Relax and unwind on some of the world's most beautiful beaches with this perfect tropical getaway.",
        destinations: ["Bali, Indonesia", "Maldives", "Phuket, Thailand"]
    },
    {
        id: 5,
        title: "Historical Journey",
        type: "cultural",
        featured: false,
        days: 12,
        price: 2800,
        image: "https://source.unsplash.com/800x600/?history",
        author: "History Buffs",
        date: "2023-10-15",
        description: "Step back in time and explore ancient civilizations and historical landmarks on this educational journey.",
        destinations: ["Cairo, Egypt", "Athens, Greece", "Rome, Italy"]
    },
    {
        id: 6,
        title: "Urban Explorer",
        type: "city",
        featured: false,
        days: 9,
        price: 2300,
        image: "https://source.unsplash.com/800x600/?city",
        author: "City Guides",
        date: "2023-11-10",
        description: "Experience the vibrant energy of the world's most exciting cities on this urban adventure.",
        destinations: ["New York City, USA", "Tokyo, Japan", "London, UK"]
    },
    {
        id: 7,
        title: "Nature Retreat",
        type: "nature",
        featured: false,
        days: 8,
        price: 1900,
        image: "https://source.unsplash.com/800x600/?nature",
        author: "Nature Experts",
        date: "2023-12-05",
        description: "Reconnect with nature as you explore stunning national parks, forests, and natural wonders.",
        destinations: ["Yellowstone, USA", "Swiss Alps", "Amazon Rainforest"]
    },
    {
        id: 8,
        title: "Island Hopping",
        type: "beach",
        featured: false,
        days: 10,
        price: 2700,
        image: "https://source.unsplash.com/800x600/?islands",
        author: "Island Life",
        date: "2024-01-15",
        description: "Discover paradise as you hop between beautiful islands with crystal clear waters and white sandy beaches.",
        destinations: ["Santorini, Greece", "Bali, Indonesia", "Hawaii, USA"]
    }
];

/**
 * Load featured itineraries
 */
function loadFeaturedItineraries() {
    const container = document.getElementById('featuredItineraries');
    if (!container) return;
    
    // Filter featured itineraries
    const featured = sampleItineraries.filter(itinerary => itinerary.featured);
    
    // Display itineraries
    if (featured.length === 0) {
        container.innerHTML = '<p class="no-results">No featured itineraries available.</p>';
        return;
    }
    
    container.innerHTML = '';
    featured.forEach(itinerary => {
        const card = createItineraryCard(itinerary);
        container.appendChild(card);
    });
}

/**
 * Load all itineraries
 */
function loadAllItineraries() {
    const container = document.getElementById('allItineraries');
    if (!container) return;
    
    // Display all itineraries
    if (sampleItineraries.length === 0) {
        container.innerHTML = '<p class="no-results">No itineraries available.</p>';
        return;
    }
    
    container.innerHTML = '';
    sampleItineraries.forEach(itinerary => {
        const card = createItineraryCard(itinerary);
        container.appendChild(card);
    });
}

/**
 * Create an itinerary card element
 */
function createItineraryCard(itinerary) {
    const card = document.createElement('div');
    card.className = 'itinerary-card';
    card.dataset.type = itinerary.type;
    
    // Format price as currency
    const price = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(itinerary.price);
    
    // Create destinations tags
    let destinationTags = '';
    itinerary.destinations.forEach(destination => {
        destinationTags += `<span class="destination-tag">${destination}</span>`;
    });
    
    card.innerHTML = `
        <div class="itinerary-image">
            <img src="${itinerary.image}" alt="${itinerary.title}" onerror="this.src='https://source.unsplash.com/800x600/?travel'">
            <div class="itinerary-badge">${itinerary.type.charAt(0).toUpperCase() + itinerary.type.slice(1)}</div>
        </div>
        <div class="itinerary-content">
            <h3 class="itinerary-title">${itinerary.title}</h3>
            <div class="itinerary-meta">
                <span><i class="fas fa-user"></i> ${itinerary.author}</span>
                <span><i class="fas fa-calendar"></i> ${formatDate(itinerary.date)}</span>
            </div>
            <div class="itinerary-info">
                <div class="info-item">
                    <i class="fas fa-clock"></i>
                    <span>${itinerary.days} days</span>
                </div>
                <div class="info-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <span>${itinerary.destinations.length} destinations</span>
                </div>
            </div>
            <p class="itinerary-description">${itinerary.description}</p>
            <div class="destinations-list">
                ${destinationTags}
            </div>
            <div class="itinerary-actions">
                <span class="itinerary-price">${price}</span>
                <a href="#" class="btn btn-primary btn-sm">View Details</a>
            </div>
        </div>
    `;
    
    return card;
}

/**
 * Format date to readable format
 */
function formatDate(dateString) {
    const options = { year: 'numeric', month: 'short', day: 'numeric' };
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', options);
}

/**
 * Setup filter buttons
 */
function setupFilterButtons() {
    const filterButtons = document.querySelectorAll('.itinerary-filters .filter-btn');
    const itineraryCards = document.querySelectorAll('#allItineraries .itinerary-card');
    
    filterButtons.forEach(button => {
        button.addEventListener('click', () => {
            // Update active button
            filterButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
            
            // Get filter value
            const filter = button.dataset.filter;
            
            // Apply filter
            itineraryCards.forEach(card => {
                if (filter === 'all' || card.dataset.type === filter) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    });
}