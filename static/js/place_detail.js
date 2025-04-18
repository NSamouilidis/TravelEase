/**
 * Place/Destination detail page functionality for TravelEase
 */

document.addEventListener('DOMContentLoaded', () => {
    const user = initAuth();
    
    // Get destination name from URL
    const urlParams = new URLSearchParams(window.location.search);
    const destinationName = urlParams.get('name');
    
    if (!destinationName) {
        // Redirect to places page if no destination specified
        window.location.href = '/places.html';
        return;
    }
    
    // Load destination details
    loadDestinationDetails(destinationName);
    
    // Setup booking form
    const bookingForm = document.getElementById('bookingForm');
    const bookNowBtn = document.getElementById('bookNowBtn');
    
    if (bookingForm) {
        // Calculate total price when form values change
        const numPeopleSelect = document.getElementById('numPeople');
        if (numPeopleSelect) {
            numPeopleSelect.addEventListener('change', updateTotalPrice);
        }
        
        // Set minimum dates for date inputs
        const today = new Date();
        const startDateInput = document.getElementById('startDate');
        const endDateInput = document.getElementById('endDate');
        
        if (startDateInput && endDateInput) {
            const todayFormatted = today.toISOString().split('T')[0];
            startDateInput.min = todayFormatted;
            
            startDateInput.addEventListener('change', () => {
                // Set end date minimum to start date
                endDateInput.min = startDateInput.value;
                
                // If end date is before start date, update it
                if (endDateInput.value && endDateInput.value < startDateInput.value) {
                    endDateInput.value = startDateInput.value;
                }
            });
        }
        
        // Handle form submission
        bookingForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            
            if (!user) {
                // Redirect to login page if not logged in
                window.location.href = `/login.html?redirect=${encodeURIComponent(window.location.href)}`;
                return;
            }
            
            // Get form data
            const formData = new FormData(bookingForm);
            const bookingData = {
                user_id: user.id,
                destination: formData.get('destination'),
                transport: formData.get('transport'),
                start_date: formData.get('startDate'),
                end_date: formData.get('endDate'),
                num_people: formData.get('numPeople'),
                notes: formData.get('notes')
            };
            
            try {
                // Submit booking
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
                
                // Redirect to booking success page
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

/**
 * Load destination details from the API
 */
async function loadDestinationDetails(destinationName) {
    try {
        const response = await fetch(`/api/destinations/${encodeURIComponent(destinationName)}`);
        
        if (!response.ok) {
            throw new Error('Failed to load destination details');
        }
        
        const destination = await response.json();
        
        // Update page title
        document.title = `${destination.name} - TravelEase`;
        
        // Update destination details
        document.getElementById('placeName').textContent = destination.name;
        document.getElementById('placeLocation').innerHTML = `
            <i class="fas fa-map-marker-alt"></i>
            <span>${destination.name}</span>
        `;
        document.getElementById('placeDescription').innerHTML = `<p>${destination.description}</p>`;
        
        // Format and update price
        const price = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD'
        }).format(destination.price);
        
        document.getElementById('placePrice').textContent = price;
        updateTotalPrice();
        
        // Update hidden form field
        document.getElementById('destinationName').value = destination.name;
        
        // Update gallery
        updateGallery(destination);
        
    } catch (error) {
        console.error('Error loading destination details:', error);
        
        // Show error message
        document.getElementById('placeName').textContent = 'Error loading destination';
        document.getElementById('placeDescription').innerHTML = `
            <div class="error-message">
                <p>Failed to load destination details. Please try again later.</p>
                <a href="/places.html" class="btn btn-primary">Back to Destinations</a>
            </div>
        `;
    }
}

/**
 * Update the gallery with destination images
 */
function updateGallery(destination) {
    const galleryContainer = document.getElementById('placeGallery');
    if (!galleryContainer) return;
    
    // Create gallery with main image and additional images
    galleryContainer.innerHTML = `
        <div class="gallery-main">
            <img src="${destination.image_url}" alt="${destination.name}">
        </div>
        <div class="gallery-item">
            <img src="https://source.unsplash.com/800x600/?${encodeURIComponent(destination.name)},landmark" alt="${destination.name} landmark">
        </div>
        <div class="gallery-item">
            <img src="https://source.unsplash.com/800x600/?${encodeURIComponent(destination.name)},travel" alt="${destination.name} travel">
        </div>
    `;
}

/**
 * Calculate and update the total price
 */
function updateTotalPrice() {
    const priceElement = document.getElementById('placePrice');
    const numPeopleSelect = document.getElementById('numPeople');
    const totalPriceElement = document.getElementById('totalPrice');
    
    if (!priceElement || !numPeopleSelect || !totalPriceElement) return;
    
    // Get base price (remove currency symbol and commas)
    const basePrice = parseFloat(priceElement.textContent.replace(/[^0-9.]/g, ''));
    
    // Get number of people
    const numPeople = parseInt(numPeopleSelect.value);
    
    // Calculate total
    const total = basePrice * numPeople;
    
    // Update total price display
    totalPriceElement.textContent = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(total);
}