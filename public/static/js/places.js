
document.addEventListener('DOMContentLoaded', () => {
    const user = typeof initAuth === 'function' ? initAuth() : null;
    
    loadAllDestinations();
    
    const filterButtons = document.querySelectorAll('.filter-btn');
    if (filterButtons) {
        filterButtons.forEach(button => {
            button.addEventListener('click', () => {
                filterButtons.forEach(btn => btn.classList.remove('active'));
                
                button.classList.add('active');
                
                const filter = button.dataset.filter;
                filterDestinations(filter);
            });
        });
    }
    
    const urlParams = new URLSearchParams(window.location.search);
    const searchQuery = urlParams.get('search');
    
    if (searchQuery) {
        const searchInput = document.getElementById('searchInput');
        if (searchInput) {
            searchInput.value = searchQuery;
            searchDestinations(searchQuery);
        }
    }
    
    const searchInput = document.getElementById('searchInput');
    const searchButton = document.getElementById('searchButton');
    
    if (searchInput && searchButton) {
        searchInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                searchDestinations(searchInput.value);
            }
        });
        
        searchButton.addEventListener('click', () => {
            searchDestinations(searchInput.value);
        });
    }
});

let allDestinations = [];

const DEFAULT_IMAGE = 'https://cdn.pixabay.com/photo/2015/07/13/14/40/paris-843229_1280.jpg';

async function loadAllDestinations() {
    const destinationsContainer = document.getElementById('destinationsGrid');
    
    if (!destinationsContainer) return;
    
    try {
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
        console.log('Destinations loaded:', destinations);
        allDestinations = destinations; 
        
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

function displayDestinations(destinations) {
    const destinationsContainer = document.getElementById('destinationsGrid');
    
    if (!destinationsContainer) return;
    
    destinationsContainer.innerHTML = '';
    
    if (destinations.length === 0) {
        destinationsContainer.innerHTML = '<p class="no-results">No destinations found matching your criteria.</p>';
        return;
    }
    
    destinations.forEach(destination => {
        const card = createDestinationCard(destination);
        destinationsContainer.appendChild(card);
    });
}

function createDestinationCard(destination) {
    const card = document.createElement('div');
    card.className = 'destination-card';
    
    let price = 0;
    if (destination.price !== null && destination.price !== undefined) {
        price = destination.price;
    }
    
    const formattedPrice = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(price);
    
    const description = destination.description || '';
    
    const truncatedDescription = description.length > 100 
        ? description.substring(0, 100) + '...'
        : description;
    
    console.log(`Destination ${destination.name} image URL:`, destination.image_url);
    
    const imageUrl = (destination.image_url && destination.image_url.trim() !== '') 
        ? destination.image_url 
        : DEFAULT_IMAGE;
    
    card.innerHTML = `
        <div class="destination-img">
            <img 
                src="${imageUrl}" 
                alt="${destination.name}" 
                onerror="this.onerror=null; this.src='${DEFAULT_IMAGE}'; console.log('Image failed to load, using default:', this.src);"
            >
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
                    d.name.toLowerCase().includes('europe') ||
                    d.name.toLowerCase().includes('greece') ||
                    d.name.toLowerCase().includes('italy') ||
                    d.name.toLowerCase().includes('spain') ||
                    d.name.toLowerCase().includes('london')
                )
            );
            break;
        case 'asia':
            filteredDestinations = allDestinations.filter(d => 
                d.name && (
                    d.name.toLowerCase().includes('bali') || 
                    d.name.toLowerCase().includes('kyoto') || 
                    d.name.toLowerCase().includes('bangkok') || 
                    d.name.toLowerCase().includes('asia') ||
                    d.name.toLowerCase().includes('japan') ||
                    d.name.toLowerCase().includes('china') ||
                    d.name.toLowerCase().includes('india') ||
                    d.name.toLowerCase().includes('singapore')
                )
            );
            break;
        default:
            filteredDestinations = allDestinations;
    }
    
    displayDestinations(filteredDestinations);
}

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
    
    const headerTitle = document.querySelector('.places-header h1');
    if (headerTitle) {
        headerTitle.textContent = `Search results for "${query}"`;
    }
}