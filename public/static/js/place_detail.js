document.addEventListener('DOMContentLoaded', () => {
    const user = initAuth();
    
    const urlParams = new URLSearchParams(window.location.search);
    const destinationName = urlParams.get('name');
    
    if (!destinationName) {
        window.location.href = '/places.html';
        return;
    }
    loadDestinationDetails(destinationName);
    
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
            
            const formData = new FormData(bookingForm);
            const bookingData = {
                user_id: user.id,
                destination: formData.get('destination'),
                transport: formData.get('transport'),
                start_date: formData.get('startDate'),
                end_date: formData.get('endDate'),
                num_people: formData.get('numPeople'),
                notes: formData.get('notes') || ''
            };
            
            sessionStorage.setItem('bookingDestination', bookingData.destination);
            sessionStorage.setItem('bookingDates', `${bookingData.start_date} to ${bookingData.end_date}`);
            sessionStorage.setItem('bookingPeople', bookingData.num_people);
            sessionStorage.setItem('bookingTransport', bookingData.transport);
            
            try {
                console.log('Submitting booking data:', bookingData);
                
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
                
                bookNowBtn.disabled = false;
                bookNowBtn.textContent = 'Book Now';
            }
        });
    }
});

async function loadDestinationDetails(destinationName) {
    try {
        const response = await fetch(`/api/destinations/${encodeURIComponent(destinationName)}`);
        
        if (!response.ok) {
            throw new Error('Failed to load destination details');
        }
        
        const destination = await response.json();
        
        document.title = `${destination.name} - TravelEase`;
        
        document.getElementById('placeName').textContent = destination.name;
        document.getElementById('placeLocation').innerHTML = `
            <i class="fas fa-map-marker-alt"></i>
            <span>${destination.name}</span>
        `;
        document.getElementById('placeDescription').innerHTML = `<p>${destination.description}</p>`;
        
        const price = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD'
        }).format(destination.price);
        
        document.getElementById('placePrice').textContent = price;
        updateTotalPrice();
        
        document.getElementById('destinationName').value = destination.name;
        
        updateGallery(destination);
        
    } catch (error) {
        console.error('Error loading destination details:', error);
        
        document.getElementById('placeName').textContent = 'Error loading destination';
        document.getElementById('placeDescription').innerHTML = `
            <div class="error-message">
                <p>Failed to load destination details. Please try again later.</p>
                <a href="/places.html" class="btn btn-primary">Back to Destinations</a>
            </div>
        `;
    }
}

function updateGallery(destination) {
    const galleryContainer = document.getElementById('placeGallery');
    if (!galleryContainer) return;
    
    const defaultImage = 'https://cdn.pixabay.com/photo/2015/07/13/14/40/paris-843229_1280.jpg';
    const mainImageUrl = (destination.image_url && destination.image_url.trim() !== '') 
        ? destination.image_url 
        : defaultImage;
    const img = document.createElement('img');
    img.src = mainImageUrl;
    img.alt = destination.name;
    
    img.onerror = function() {
        this.src = defaultImage;
        console.log('Error loading destination image, using default');
    };
    
    galleryContainer.innerHTML = '';
    galleryContainer.appendChild(img);
    
    console.log('Destination image loaded successfully');
}

function updateTotalPrice() {
    const priceElement = document.getElementById('placePrice');
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