document.addEventListener('DOMContentLoaded', () => {
    const user = initAuth ? initAuth() : null;
    
    console.log("Itineraries page loaded"); 
    loadFeaturedItineraries();
    
    loadAllItineraries();
    
    setupFilterButtons();
});

const DEFAULT_IMAGE = 'https://source.unsplash.com/800x600/?travel';

async function loadFeaturedItineraries() {
    const container = document.getElementById('featuredItineraries');
    if (!container) return;
    
    try {
        container.innerHTML = `<div class="loading-spinner"><i class="fas fa-spinner fa-spin"></i></div>`;
        
        console.log("Fetching featured itineraries from API..."); 
        const response = await fetch('/api/itineraries/featured');
        
        if (!response.ok) {
            throw new Error(`Failed to load featured itineraries: ${response.status}`);
        }
        
        const featured = await response.json();
        console.log('Featured itineraries loaded:', featured); 
        
        if (!featured || featured.length === 0) {
            container.innerHTML = '<p class="no-results">No featured itineraries available.</p>';
            return;
        }
        
        container.innerHTML = '';
        featured.forEach(itinerary => {
            const card = createItineraryCard(itinerary);
            container.appendChild(card);
        });
    } catch (error) {
        console.error('Error loading featured itineraries:', error);
        container.innerHTML = `<p class="error-message">Failed to load featured itineraries. Error: ${error.message}</p>`;
    }
}

async function loadAllItineraries() {
    const container = document.getElementById('allItineraries');
    if (!container) return;
    
    try {
        container.innerHTML = `<div class="loading-spinner"><i class="fas fa-spinner fa-spin"></i></div>`;
        
        console.log("Fetching all itineraries from API..."); 
        const response = await fetch('/api/itineraries');
        
        if (!response.ok) {
            throw new Error(`Failed to load itineraries: ${response.status}`);
        }
        
        const itineraries = await response.json();
        console.log('All itineraries loaded:', itineraries); 
        
        if (!itineraries || itineraries.length === 0) {
            container.innerHTML = '<p class="no-results">No itineraries available.</p>';
            return;
        }
        
        container.innerHTML = '';
        itineraries.forEach(itinerary => {
            const card = createItineraryCard(itinerary);
            container.appendChild(card);
        });
        
        setupFilterButtons();
    } catch (error) {
        console.error('Error loading all itineraries:', error);
        container.innerHTML = `<p class="error-message">Failed to load itineraries. Error: ${error.message}</p>`;
    }
}

function createItineraryCard(itinerary) {
    const card = document.createElement('div');
    card.className = 'itinerary-card';
    card.dataset.type = itinerary.type || 'default';
    
    console.log('Creating card for itinerary:', itinerary);
    
    const price = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(itinerary.price || 0);
    
    let destinationTags = '';
    if (Array.isArray(itinerary.destinations)) {
        itinerary.destinations.forEach(destination => {
            destinationTags += `<span class="destination-tag">${destination}</span>`;
        });
    }
    
    let imageUrl = DEFAULT_IMAGE;
    
    if (itinerary.image_url && typeof itinerary.image_url === 'string' && itinerary.image_url.trim() !== '') {
        if (itinerary.image_url.startsWith('/')) {
            imageUrl = window.location.origin + itinerary.image_url;
        } else {
            imageUrl = itinerary.image_url;
        }
    }
    
    console.log(`Itinerary ${itinerary.id} image URL: ${imageUrl}`);
    
    card.innerHTML = `
        <div class="itinerary-image">
            <img src="${imageUrl}" alt="${itinerary.title || 'Itinerary'}" 
                 onerror="this.onerror=null; this.src='${DEFAULT_IMAGE}'; console.log('Image failed to load, using default');">
            <div class="itinerary-badge">${(itinerary.type || 'default').charAt(0).toUpperCase() + (itinerary.type || 'default').slice(1)}</div>
        </div>
        <div class="itinerary-content">
            <h3 class="itinerary-title">${itinerary.title || 'Unnamed Itinerary'}</h3>
            <div class="itinerary-meta">
                <span><i class="fas fa-user"></i> ${itinerary.author || 'Unknown'}</span>
                <span><i class="fas fa-calendar"></i> ${formatDate(itinerary.date)}</span>
            </div>
            <div class="itinerary-info">
                <div class="info-item">
                    <i class="fas fa-clock"></i>
                    <span>${itinerary.days || 0} days</span>
                </div>
                <div class="info-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <span>${Array.isArray(itinerary.destinations) ? itinerary.destinations.length : 0} destinations</span>
                </div>
            </div>
            <p class="itinerary-description">${itinerary.description || 'No description available.'}</p>
            <div class="destinations-list">
                ${destinationTags}
            </div>
            <div class="itinerary-actions">
                <span class="itinerary-price">${price}</span>
                <a href="/itinerary_detail.html?id=${itinerary.id}" class="btn btn-primary btn-sm">View Details</a>
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
        return dateString; ls
    }
}


function setupFilterButtons() {
    const filterButtons = document.querySelectorAll('.itinerary-filters .filter-btn');
    const itineraryCards = document.querySelectorAll('#allItineraries .itinerary-card');
    
    if (!filterButtons || filterButtons.length === 0) {
        console.log("No filter buttons found");
        return;
    }
    
    if (!itineraryCards || itineraryCards.length === 0) {
        console.log("No itinerary cards found to filter");
        return;
    }
    
    console.log(`Found ${filterButtons.length} filter buttons and ${itineraryCards.length} cards`);
    
    filterButtons.forEach(button => {
        button.addEventListener('click', () => {
            // Update active button
            filterButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
            
            // Get filter value
            const filter = button.dataset.filter;
            console.log('Filtering itineraries by:', filter); 
            
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