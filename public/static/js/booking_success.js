document.addEventListener('DOMContentLoaded', () => {
    const user = initAuth();
    
    if (!user) {
        window.location.href = '/login.html';
        return;
    }
    
    const urlParams = new URLSearchParams(window.location.search);
    const bookingId = urlParams.get('id');
    
    if (!bookingId) {
        window.location.href = '/profile.html';
        return;
    }
    
    const bookingIdElement = document.getElementById('bookingId');
    if (bookingIdElement) {
        bookingIdElement.textContent = bookingId;
    }
    
    displaySessionData();
    
    fetchBookingDetails(bookingId);
});


function displaySessionData() {
    const destination = sessionStorage.getItem('bookingDestination');
    const dates = sessionStorage.getItem('bookingDates');
    const people = sessionStorage.getItem('bookingPeople');
    const transport = sessionStorage.getItem('bookingTransport');
    
    if (destination) {
        const destElement = document.getElementById('bookingDestination');
        if (destElement) destElement.textContent = destination;
    }
    
    if (dates) {
        const datesElement = document.getElementById('bookingDates');
        if (datesElement) datesElement.textContent = dates;
    }
    
    if (people) {
        const peopleElement = document.getElementById('bookingTravelers');
        if (peopleElement) {
            const peopleCount = parseInt(people);
            peopleElement.textContent = `${peopleCount} ${peopleCount === 1 ? 'Person' : 'People'}`;
        }
    }
    
    if (transport) {
        const transportElement = document.getElementById('bookingTransport');
        if (transportElement) transportElement.textContent = transport;
    }
    
    if (destination || dates || people || transport) {
        hideLoadingIndicator();
    }
    
    console.log("Displayed data from session storage");
}


async function fetchBookingDetails(bookingId) {
    try {
        console.log(`Fetching booking details for ID: ${bookingId}`);
        
        const response = await fetch(`/api/bookings/details/${bookingId}`);
        
        if (!response.ok) {
            console.error(`Error fetching booking: ${response.status} ${response.statusText}`);
            hideLoadingIndicator();
            return;
        }
        
        const booking = await response.json();
        console.log("Received booking data:", booking);
        
        updateBookingElements(booking);
        
    } catch (error) {
        console.error("Failed to fetch booking details:", error);
        hideLoadingIndicator();
    }
}

function updateBookingElements(booking) {
    const destElement = document.getElementById('bookingDestination');
    if (destElement && booking.destination) {
        destElement.textContent = booking.destination;
    }
    
    const datesElement = document.getElementById('bookingDates');
    if (datesElement && booking.start_date && booking.end_date) {
        datesElement.textContent = `${formatDate(booking.start_date)} - ${formatDate(booking.end_date)}`;
    }
    
    const travelersElement = document.getElementById('bookingTravelers');
    if (travelersElement && booking.num_people) {
        const numPeople = parseInt(booking.num_people);
        travelersElement.textContent = `${numPeople} ${numPeople === 1 ? 'Person' : 'People'}`;
    }
    
    const transportElement = document.getElementById('bookingTransport');
    if (transportElement && booking.transport) {
        transportElement.textContent = booking.transport;
    }
    
    hideLoadingIndicator();
    
    console.log("Updated elements with API data");
}

function formatDate(dateString) {
    if (!dateString) return '';
    
    try {
        const options = { year: 'numeric', month: 'long', day: 'numeric' };
        return new Date(dateString).toLocaleDateString('en-US', options);
    } catch (e) {
        console.error("Error formatting date:", e);
        return dateString;
    }
}


function hideLoadingIndicator() {
    const loadingIndicator = document.getElementById('loadingIndicator');
    if (loadingIndicator) {
        loadingIndicator.style.display = 'none';
    }
}