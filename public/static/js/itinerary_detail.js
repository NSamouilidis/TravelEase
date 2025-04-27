document.addEventListener('DOMContentLoaded', () => {
    const user = initAuth();
    
    console.log("Itinerary detail page loaded"); 
    
    const urlParams = new URLSearchParams(window.location.search);
    const itineraryId = urlParams.get('id');
    
    console.log("Itinerary ID from URL:", itineraryId); 
    
    if (!itineraryId) {
        console.log("No itinerary ID found, redirecting"); 
        window.location.href = '/itineraries.html';
        return;
    }
    
    loadItineraryDetails(itineraryId);
    
    const bookingForm = document.getElementById('bookingForm');
    const bookNowBtn = document.getElementById('bookNowBtn');
    
    if (bookingForm) {
        const numPeopleSelect = document.getElementById('numPeople');
        if (numPeopleSelect) {
            numPeopleSelect.addEventListener('change', updateTotalPrice);
        }
        
        const today = new Date();
        const startDateInput = document.getElementById('startDate');
        const endDateInput = document.getElementById('endDate');
        
        if (startDateInput && endDateInput) {
            const todayFormatted = today.toISOString().split('T')[0];
            startDateInput.min = todayFormatted;
            startDateInput.value = todayFormatted;
            
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            const tomorrowFormatted = tomorrow.toISOString().split('T')[0];
            endDateInput.min = tomorrowFormatted;
            endDateInput.value = tomorrowFormatted;
            
            startDateInput.addEventListener('change', () => {
                const newStartDate = new Date(startDateInput.value);
                newStartDate.setDate(newStartDate.getDate() + 1);
                const newMinEndDate = newStartDate.toISOString().split('T')[0];
                
                endDateInput.min = newMinEndDate;
                
                if (endDateInput.value < newMinEndDate) {
                    endDateInput.value = newMinEndDate;
                }
                
                updateTotalPrice();
            });
            
            endDateInput.addEventListener('change', updateTotalPrice);
        }
        
        bookingForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            
            if (!user) {
                window.location.href = `/login.html?redirect=${encodeURIComponent(window.location.href)}`;
                return;
            }
            
            // Get form data
            const formData = new FormData(bookingForm);
            const bookingData = {
                user_id: user.id,
                destination: formData.get('itineraryName'), 
                transport: formData.get('transport'),
                start_date: formData.get('startDate'),
                end_date: formData.get('endDate'),
                num_people: formData.get('numPeople'),
                notes: `Itinerary Booking #${formData.get('itineraryId')}: ${formData.get('notes') || ''}`
            };
            
            sessionStorage.setItem('bookingDestination', bookingData.destination);
            sessionStorage.setItem('bookingDates', `${bookingData.start_date} to ${bookingData.end_date}`);
            sessionStorage.setItem('bookingPeople', bookingData.num_people);
            sessionStorage.setItem('bookingTransport', bookingData.transport);
            
            try {
                console.log('Submitting itinerary booking data:', bookingData);
                
                bookNowBtn.disabled = true;
                bookNowBtn.textContent = 'Processing...';
                
                const response = await fetch('/api/bookings', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(bookingData),
                });
                
                const data = await response.json();
                
                if (!response.ok) {
                    throw new Error(data.error || 'Failed to create booking');
                }
                
                sessionStorage.setItem('lastBookingId', data.bookingId);
                
                window.location.href = `/booking_success.html?id=${data.bookingId}`;
                
            } catch (error) {
                console.error('Booking error:', error);
                alert(`Booking failed: ${error.message}`);
                
                // Re-enable button
                bookNowBtn.disabled = false;
                bookNowBtn.textContent = 'Book Now';
            }
        });
    }
});

async function loadItineraryDetails(itineraryId) {
    console.log("Loading itinerary details for ID:", itineraryId); 
    
    try {
        // Show loading states
        document.getElementById('itineraryTitle').textContent = 'Loading...';
        document.getElementById('itineraryDescription').innerHTML = '<p>Loading itinerary details...</p>';
        
        // Fetch itinerary data from API
        const response = await fetch(`/api/itineraries/${itineraryId}`);
        
        if (!response.ok) {
            throw new Error(`Failed to load itinerary: ${response.status}`);
        }
        
        const itinerary = await response.json();
        console.log("Fetched itinerary data:", itinerary); 
        
        document.title = `${itinerary.title} - TravelEase`;
        
        updateItineraryDetails(itinerary);
        
        updateBanner(itinerary);
        updateDestinationsList(itinerary.destinations);
        
        updateHighlightsList(itinerary.highlights);
        
        updateBookingForm(itinerary);
        
    } catch (error) {
        console.error('Error loading itinerary details:', error);
        
        document.getElementById('itineraryTitle').textContent = 'Error loading itinerary';
        document.getElementById('itineraryDescription').innerHTML = `
            <div class="error-message">
                <p>Failed to load itinerary details. Please try again later.</p>
                <p>Error: ${error.message}</p>
                <a href="/itineraries.html" class="btn btn-primary">Back to Itineraries</a>
            </div>
        `;
    }
}

function updateItineraryDetails(itinerary) {
    console.log("Updating itinerary details on page"); 
    
    document.getElementById('itineraryTitle').textContent = itinerary.title;
    document.getElementById('itineraryAuthor').textContent = itinerary.author;
    document.getElementById('itineraryDate').textContent = formatDate(itinerary.date);
    document.getElementById('itineraryDays').textContent = itinerary.days;
    document.getElementById('itineraryDestCount').textContent = 
        Array.isArray(itinerary.destinations) ? itinerary.destinations.length : 0;
    document.getElementById('itineraryDescription').innerHTML = `<p>${itinerary.description}</p>`;
    
    const bannerElement = document.getElementById('itineraryBanner');
    if (!bannerElement.querySelector('.itinerary-badge')) {
        const badgeElement = document.createElement('div');
        badgeElement.className = 'itinerary-badge';
        badgeElement.textContent = itinerary.type.charAt(0).toUpperCase() + itinerary.type.slice(1);
        bannerElement.appendChild(badgeElement);
    }
}


function updateBanner(itinerary) {
    const bannerContainer = document.getElementById('itineraryBanner');
    if (!bannerContainer) return;
    
    const defaultImage = 'https://source.unsplash.com/800x600/?travel';
    const mainImageUrl = itinerary.image_url || defaultImage;
    
    const img = document.createElement('img');
    img.src = mainImageUrl;
    img.alt = itinerary.title;
    
    img.onerror = function() {
        this.src = defaultImage;
        console.log('Error loading itinerary image, using default');
    };
    
    const badge = bannerContainer.querySelector('.itinerary-badge');
    bannerContainer.innerHTML = '';
    if (badge) {
        bannerContainer.appendChild(badge);
    }
    
    bannerContainer.appendChild(img);
    
    console.log('Itinerary banner image loaded successfully');
}

function updateDestinationsList(destinations) {
    const destinationsContainer = document.getElementById('destinationsList');
    if (!destinationsContainer) return;
    
    destinationsContainer.innerHTML = '';
    
    if (!Array.isArray(destinations) || destinations.length === 0) {
        destinationsContainer.innerHTML = '<p>No destinations available for this itinerary.</p>';
        return;
    }
    
   
    destinations.forEach((destination, index) => {
        const destinationElement = document.createElement('div');
        destinationElement.className = 'destination-item';
        
        let destName = destination;
        let destDescription = '';
        
        if (typeof destination === 'object' && destination !== null) {
            destName = destination.name || 'Unknown destination';
            destDescription = destination.description || '';
        }
        
        destinationElement.innerHTML = `
            <div class="destination-day">
                Day ${index + 1}
            </div>
            <div class="destination-details">
                <h4>${destName}</h4>
                <p>${destDescription}</p>
            </div>
        `;
        
        destinationsContainer.appendChild(destinationElement);
    });
}

function updateHighlightsList(highlights) {
    const highlightsContainer = document.getElementById('highlightsList');
    if (!highlightsContainer) return;
    
    highlightsContainer.innerHTML = '';
    
    if (!Array.isArray(highlights) || highlights.length === 0) {
        highlightsContainer.innerHTML = '<li>No highlights available for this itinerary.</li>';
        return;
    }
    highlights.forEach(highlight => {
        const li = document.createElement('li');
        li.textContent = highlight;
        highlightsContainer.appendChild(li);
    });
}

function updateBookingForm(itinerary) {
    document.getElementById('itineraryId').value = itinerary.id;
    document.getElementById('itineraryName').value = itinerary.title;
    
    const formattedPrice = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(itinerary.price);
    
    document.getElementById('itineraryPrice').textContent = formattedPrice;
    
    const startDateInput = document.getElementById('startDate');
    const endDateInput = document.getElementById('endDate');
    
    if (startDateInput && endDateInput && startDateInput.value) {
        const startDate = new Date(startDateInput.value);
        const endDate = new Date(startDate);
        endDate.setDate(startDate.getDate() + itinerary.days);
        
        endDateInput.value = endDate.toISOString().split('T')[0];
    }
    
    updateTotalPrice();
}


function updateTotalPrice() {
    const priceElement = document.getElementById('itineraryPrice');
    const numPeopleSelect = document.getElementById('numPeople');
    const totalPriceElement = document.getElementById('totalPrice');
    
    if (!priceElement || !numPeopleSelect || !totalPriceElement) return;
    
    const basePrice = parseFloat(priceElement.textContent.replace(/[^0-9.]/g, ''));
    
    const numPeople = parseInt(numPeopleSelect.value);
    
    const total = basePrice * numPeople;
    
    totalPriceElement.textContent = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(total);
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