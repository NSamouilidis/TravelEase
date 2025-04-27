document.addEventListener('DOMContentLoaded', () => {
    const user = initAuth ? initAuth() : null;
    
    loadFeaturedDestinations();
    
    const searchBox = document.querySelector('.search-box input');
    const searchBtn = document.querySelector('.search-box .btn');
    
    if (searchBox && searchBtn) {
        searchBox.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                performSearch(searchBox.value);
            }
        });
        
        searchBtn.addEventListener('click', () => {
            performSearch(searchBox.value);
        });
    }
});

async function loadFeaturedDestinations() {
    const featuredContainer = document.getElementById('featuredDestinations');
    
    if (!featuredContainer) return;
    
    try {
        featuredContainer.innerHTML = `
            <div class="loading-spinner">
                <i class="fas fa-spinner fa-spin"></i>
            </div>
        `;
        
        const response = await fetch('/api/destinations/featured');
        
        if (!response.ok) {
            throw new Error('Failed to load destinations');
        }
        
        const destinations = await response.json();
        
        featuredContainer.innerHTML = '';
        
        if (destinations.length === 0) {
            featuredContainer.innerHTML = '<p class="no-results">No featured destinations found.</p>';
            return;
        }
        
        destinations.forEach(destination => {
            const card = createDestinationCard(destination);
            featuredContainer.appendChild(card);
        });
        
    } catch (error) {
        console.error('Error loading destinations:', error);
        featuredContainer.innerHTML = `
            <div class="error-message">
                <p>Failed to load destinations. Please try again later.</p>
                <p>Error details: ${error.message}</p>
            </div>
        `;
    }
}

function performSearch(query) {
    if (query.trim() === '') return;
    
    window.location.href = `/places.html?search=${encodeURIComponent(query)}`;
}

function createDestinationCard(destination) {
    const card = document.createElement('div');
    card.className = 'destination-card';
    
    const price = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(destination.price);
    
    const description = destination.description.length > 100 
        ? destination.description.substring(0, 100) + '...'
        : destination.description;
    
    const imageUrl = destination.image_url || 'https://source.unsplash.com/800x600/?travel,destination';
    
    card.innerHTML = `
        <div class="destination-img">
            <img src="${imageUrl}" alt="${destination.name}" onerror="this.src='https://source.unsplash.com/800x600/?travel'">
            <div class="destination-price">${price}</div>
        </div>
        <div class="destination-content">
            <h3>${destination.name}</h3>
            <p>${description}</p>
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