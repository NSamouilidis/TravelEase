/**
 * TravelEase Chatbot with trip planning calculations
 * Recommends destinations and hotels based on duration and budget
 */

document.addEventListener('DOMContentLoaded', () => {
    initChatbot();
});

// Chat messages
const botResponses = {
    welcome: "👋 Hi there! I'm TravelBot, your travel assistant. I'll help you plan your perfect trip. How many days are you planning to travel?",
    days_invalid: "Please enter a valid number of days (between 1 and 30).",
    days_confirmed: "Great! You're planning a $DAYS-day trip. Now, what's your total budget for the trip? (in USD)",
    budget_invalid: "Please enter a valid budget amount (a number greater than 0)",
    budget_too_low: "I couldn't find suitable options at that price point. For a $DAYS-day trip, our minimum recommended budget is $MINPRICE. Please enter a higher amount.",
    budget_confirmed: "Perfect! I'll find some great $DAYS-day trips within your $BUDGET budget.",
    no_results: "I couldn't find any suitable combinations within your budget. Try increasing your budget or shortening your trip duration.",
    error: "Sorry, I encountered an error while searching. Please try again later.",
    more_help: "Would you like more trip suggestions or help with something else?",
    dont_understand: "I'm not sure I understand. I can help you plan a trip based on your duration and budget. Please tell me how many days you'd like to travel.",
    goodbye: "Thanks for chatting! Feel free to return when you're ready to plan your next adventure. Have a great day! 😊",
    help: "I can help you plan your perfect trip. I'll ask about your travel duration and budget, then suggest destinations and hotels that fit your preferences."
};

// Chatbot state
let chatbotState = {
    active: false,
    waitingForDays: false,
    waitingForBudget: false,
    travelDays: 0,
    currentBudget: 0,
    suggestedTrips: [],
    stats: {
        minDailyBudget: 150, // Minimum budget per day
        avgHotelPrice: 200,  // Average hotel price per night
        avgDestPrice: 800    // Average destination ticket price
    }
};

// Initialize the chatbot
function initChatbot() {
    // Create chatbot elements if they don't exist
    if (!document.getElementById('chatbot-container')) {
        createChatbotUI();
    }
    
    // Set up event listeners
    const chatToggle = document.getElementById('chat-toggle');
    const chatInput = document.getElementById('chat-input');
    const chatSend = document.getElementById('chat-send');
    const chatClose = document.getElementById('chat-close');
    
    // Toggle chatbot visibility
    chatToggle.addEventListener('click', () => {
        toggleChatbot();
    });
    
    // Close chatbot
    chatClose.addEventListener('click', () => {
        toggleChatbot(false);
    });
    
    // Send message on button click
    chatSend.addEventListener('click', () => {
        sendUserMessage();
    });
    
    // Send message on Enter key
    chatInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            sendUserMessage();
        }
    });
    
    // Load chatbot stats from the database
    loadChatbotStats();
}

// Load chatbot stats from database
async function loadChatbotStats() {
    try {
        // Load destination stats
        const destResponse = await fetch('/api/chatbot/stats');
        
        if (destResponse.ok) {
            const destStats = await destResponse.json();
            chatbotState.stats.avgDestPrice = Math.ceil(destStats.avg_price);
            chatbotState.stats.minDestPrice = Math.ceil(destStats.min_price);
        }
        
        // Load hotel stats
        const hotelResponse = await fetch('/api/hotels');
        
        if (hotelResponse.ok) {
            const hotels = await hotelResponse.json();
            if (hotels.length > 0) {
                let totalPrice = 0;
                let minPrice = Number.MAX_VALUE;
                
                hotels.forEach(hotel => {
                    const price = parseFloat(hotel.price_per_night);
                    totalPrice += price;
                    minPrice = Math.min(minPrice, price);
                });
                
                chatbotState.stats.avgHotelPrice = Math.ceil(totalPrice / hotels.length);
                chatbotState.stats.minHotelPrice = Math.ceil(minPrice);
                
                // Update minimum daily budget
                chatbotState.stats.minDailyBudget = chatbotState.stats.minHotelPrice + 50; // Hotel + daily expenses
            }
        }
        
        console.log('Chatbot stats loaded:', chatbotState.stats);
    } catch (error) {
        console.error('Error loading chatbot stats:', error);
    }
}

// Create chatbot UI elements
function createChatbotUI() {
    // Create chatbot toggle button
    const chatToggle = document.createElement('div');
    chatToggle.id = 'chat-toggle';
    chatToggle.innerHTML = '<i class="fas fa-comment"></i>';
    chatToggle.title = 'Chat with TravelBot';
    
    // Create chatbot container
    const chatbotContainer = document.createElement('div');
    chatbotContainer.id = 'chatbot-container';
    chatbotContainer.classList.add('chatbot-hidden');
    
    // Create chatbot header
    const chatHeader = document.createElement('div');
    chatHeader.id = 'chat-header';
    chatHeader.innerHTML = `
        <div class="chat-title">
            <i class="fas fa-robot"></i>
            <span>TravelBot</span>
        </div>
        <button id="chat-close"><i class="fas fa-times"></i></button>
    `;
    
    // Create chatbot messages area
    const chatMessages = document.createElement('div');
    chatMessages.id = 'chat-messages';
    
    // Create chatbot input area
    const chatInputArea = document.createElement('div');
    chatInputArea.id = 'chat-input-area';
    chatInputArea.innerHTML = `
        <input type="text" id="chat-input" placeholder="Type your message...">
        <button id="chat-send"><i class="fas fa-paper-plane"></i></button>
    `;
    
    // Assemble chatbot elements
    chatbotContainer.appendChild(chatHeader);
    chatbotContainer.appendChild(chatMessages);
    chatbotContainer.appendChild(chatInputArea);
    
    // Add chatbot to the page
    document.body.appendChild(chatToggle);
    document.body.appendChild(chatbotContainer);
    
    // Add chatbot styles if not already added
    if (!document.getElementById('chatbot-styles')) {
        addChatbotStyles();
    }
}

// Add chatbot CSS styles
function addChatbotStyles() {
    const styleSheet = document.createElement('style');
    styleSheet.id = 'chatbot-styles';
    styleSheet.textContent = `
        #chat-toggle {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 60px;
            height: 60px;
            background-color: var(--primary-color);
            color: white;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            transition: transform 0.3s ease;
        }
        
        #chat-toggle:hover {
            transform: scale(1.1);
        }
        
        #chat-toggle i {
            font-size: 24px;
        }
        
        #chatbot-container {
            position: fixed;
            bottom: 90px;
            right: 20px;
            width: 350px;
            height: 500px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            display: flex;
            flex-direction: column;
            overflow: hidden;
            z-index: 1000;
            transition: all 0.3s ease;
        }
        
        .chatbot-hidden {
            opacity: 0;
            visibility: hidden;
            transform: translateY(20px);
        }
        
        #chat-header {
            padding: 15px;
            background-color: var(--primary-color);
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .chat-title {
            display: flex;
            align-items: center;
            font-weight: bold;
        }
        
        .chat-title i {
            margin-right: 10px;
            font-size: 18px;
        }
        
        #chat-close {
            background: none;
            border: none;
            color: white;
            cursor: pointer;
            font-size: 16px;
        }
        
        #chat-messages {
            flex: 1;
            padding: 15px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        
        .chat-message {
            max-width: 80%;
            padding: 10px 15px;
            border-radius: 18px;
            line-height: 1.4;
            word-wrap: break-word;
        }
        
        .bot-message {
            background-color: #f0f0f0;
            align-self: flex-start;
            border-bottom-left-radius: 5px;
        }
        
        .user-message {
            background-color: var(--primary-color);
            color: white;
            align-self: flex-end;
            border-bottom-right-radius: 5px;
        }
        
        .trip-card {
            width: 100%;
            background-color: white;
            border: 1px solid #eee;
            border-radius: 8px;
            margin-bottom: 10px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        
        .trip-card-header {
            display: flex;
            align-items: center;
            padding: 10px;
            background-color: rgba(52, 152, 219, 0.1);
        }
        
        .trip-card-header h4 {
            margin: 0;
            font-size: 16px;
            flex: 1;
        }
        
        .trip-rating {
            color: #f39c12;
            margin-left: 10px;
        }
        
        .trip-card-images {
            display: flex;
        }
        
        .trip-card-images img {
            width: 50%;
            height: 120px;
            object-fit: cover;
        }
        
        .trip-card-content {
            padding: 10px;
        }
        
        .trip-breakdown {
            margin: 10px 0;
            font-size: 14px;
        }
        
        .trip-breakdown-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
        }
        
        .trip-total {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
            padding-top: 10px;
            border-top: 1px dashed #ddd;
            font-weight: bold;
        }
        
        .trip-links {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
        
        .trip-links a {
            flex: 1;
            text-align: center;
            padding: 8px;
            border-radius: 5px;
            font-size: 14px;
            text-decoration: none;
            background-color: #f0f0f0;
            color: var(--text-color);
        }
        
        .trip-links a:hover {
            background-color: var(--primary-color);
            color: white;
        }
        
        .typing-indicator {
            display: flex;
            align-items: center;
            gap: 5px;
            padding: 10px 15px;
            background-color: #f0f0f0;
            border-radius: 18px;
            align-self: flex-start;
            border-bottom-left-radius: 5px;
            max-width: 80%;
        }
        
        .typing-indicator span {
            width: 8px;
            height: 8px;
            background-color: #888;
            border-radius: 50%;
            animation: typing-dot 1.4s infinite ease-in-out both;
        }
        
        .typing-indicator span:nth-child(1) {
            animation-delay: 0s;
        }
        
        .typing-indicator span:nth-child(2) {
            animation-delay: 0.2s;
        }
        
        .typing-indicator span:nth-child(3) {
            animation-delay: 0.4s;
        }
        
        @keyframes typing-dot {
            0%, 80%, 100% { 
                transform: scale(0.7);
                opacity: 0.5;
            }
            40% { 
                transform: scale(1);
                opacity: 1;
            }
        }
        
        #chat-input-area {
            padding: 15px;
            display: flex;
            border-top: 1px solid #eee;
        }
        
        #chat-input {
            flex: 1;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 20px;
            outline: none;
        }
        
        #chat-input:focus {
            border-color: var(--primary-color);
        }
        
        #chat-send {
            background: var(--primary-color);
            color: white;
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-left: 10px;
            cursor: pointer;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        @media (max-width: 576px) {
            #chatbot-container {
                width: calc(100% - 40px);
                height: 60vh;
            }
        }
    `;
    document.head.appendChild(styleSheet);
}

// Toggle chatbot visibility
function toggleChatbot(show) {
    const chatbotContainer = document.getElementById('chatbot-container');
    
    if (show === undefined) {
        show = chatbotContainer.classList.contains('chatbot-hidden');
    }
    
    if (show) {
        chatbotContainer.classList.remove('chatbot-hidden');
        chatbotState.active = true;
        
        // Send welcome message if this is the first time opening
        const chatMessages = document.getElementById('chat-messages');
        if (chatMessages.children.length === 0) {
            setTimeout(() => {
                addBotMessage(botResponses.welcome);
                chatbotState.waitingForDays = true;
            }, 500);
        }
    } else {
        chatbotContainer.classList.add('chatbot-hidden');
        chatbotState.active = false;
    }
}

// Send user message
function sendUserMessage() {
    const chatInput = document.getElementById('chat-input');
    const message = chatInput.value.trim();
    
    if (message === '') return;
    
    // Add user message to chat
    addUserMessage(message);
    
    // Clear input field
    chatInput.value = '';
    
    // Process user message
    processUserMessage(message);
}

// Show typing indicator
function showTypingIndicator() {
    const chatMessages = document.getElementById('chat-messages');
    const indicator = document.createElement('div');
    indicator.id = 'typing-indicator';
    indicator.className = 'typing-indicator';
    indicator.innerHTML = '<span></span><span></span><span></span>';
    
    chatMessages.appendChild(indicator);
    scrollToBottom();
    
    return indicator;
}

// Remove typing indicator
function removeTypingIndicator() {
    const indicator = document.getElementById('typing-indicator');
    if (indicator) {
        indicator.remove();
    }
}

// Add a bot message to the chat
function addBotMessage(message) {
    const chatMessages = document.getElementById('chat-messages');
    const messageElement = document.createElement('div');
    messageElement.classList.add('chat-message', 'bot-message');
    messageElement.textContent = message;
    
    chatMessages.appendChild(messageElement);
    scrollToBottom();
}

// Add a user message to the chat
function addUserMessage(message) {
    const chatMessages = document.getElementById('chat-messages');
    const messageElement = document.createElement('div');
    messageElement.classList.add('chat-message', 'user-message');
    messageElement.textContent = message;
    
    chatMessages.appendChild(messageElement);
    scrollToBottom();
}

// Add trip recommendations to the chat
function addTripCards(trips) {
    const chatMessages = document.getElementById('chat-messages');
    const containerElement = document.createElement('div');
    containerElement.classList.add('chat-message', 'bot-message');
    
    let content = '<div class="trips-container">';
    
    trips.forEach(trip => {
        const destinationPrice = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD'
        }).format(trip.destination.price);
        
        const hotelPricePerNight = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD'
        }).format(trip.hotel.price_per_night);
        
        const totalHotelPrice = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD'
        }).format(trip.hotel.price_per_night * chatbotState.travelDays);
        
        const dailyExpenses = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD'
        }).format(trip.dailyExpenses * chatbotState.travelDays);
        
        const totalPrice = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD'
        }).format(trip.totalPrice);
        
        // Create hotel rating
        let hotelRating = '';
        const fullStars = Math.floor(trip.hotel.rating);
        
        for (let i = 0; i < fullStars; i++) {
            hotelRating += '<i class="fas fa-star"></i>';
        }
        
        if (trip.hotel.rating % 1 >= 0.5) {
            hotelRating += '<i class="fas fa-star-half-alt"></i>';
        }
        
        content += `
            <div class="trip-card">
                <div class="trip-card-header">
                    <h4>${trip.destination.name} with ${trip.hotel.name}</h4>
                    <div class="trip-rating">${hotelRating}</div>
                </div>
                <div class="trip-card-images">
                    <img src="${trip.destination.image_url}" alt="${trip.destination.name}" onerror="this.src='https://source.unsplash.com/800x600/?travel'">
                    <img src="${trip.hotel.image_url}" alt="${trip.hotel.name}" onerror="this.src='https://source.unsplash.com/800x600/?hotel'">
                </div>
                <div class="trip-card-content">
                    <div class="trip-breakdown">
                        <div class="trip-breakdown-item">
                            <span>Destination:</span>
                            <span>${destinationPrice}</span>
                        </div>
                        <div class="trip-breakdown-item">
                            <span>Hotel (${chatbotState.travelDays} nights at ${hotelPricePerNight}/night):</span>
                            <span>${totalHotelPrice}</span>
                        </div>
                        <div class="trip-breakdown-item">
                            <span>Daily expenses:</span>
                            <span>${dailyExpenses}</span>
                        </div>
                        <div class="trip-total">
                            <span>Total:</span>
                            <span>${totalPrice}</span>
                        </div>
                    </div>
                    <div class="trip-links">
                        <a href="/place_detail.html?name=${encodeURIComponent(trip.destination.name)}" target="_blank">View Destination</a>
                        <a href="/hotel_detail.html?id=${trip.hotel.id}" target="_blank">View Hotel</a>
                    </div>
                </div>
            </div>
        `;
    });
    
    content += '</div>';
    containerElement.innerHTML = content;
    
    chatMessages.appendChild(containerElement);
    scrollToBottom();
}

// Process user message and generate appropriate response
function processUserMessage(message) {
    // Show typing indicator
    const typingIndicator = showTypingIndicator();
    
    // Simulate typing delay
    setTimeout(() => {
        // Remove typing indicator
        removeTypingIndicator();
        
        if (chatbotState.waitingForDays) {
            processDaysInput(message);
        } else if (chatbotState.waitingForBudget) {
            processBudgetInput(message);
        } else if (message.toLowerCase().includes('days') || message.toLowerCase().includes('how long')) {
            chatbotState.waitingForDays = true;
            addBotMessage("How many days are you planning to travel?");
        } else if (message.toLowerCase().includes('budget') || message.toLowerCase().includes('money') || message.toLowerCase().includes('cost')) {
            // If days aren't provided yet, ask for days first
            if (chatbotState.travelDays === 0) {
                chatbotState.waitingForDays = true;
                addBotMessage("First, let me know how many days you're planning to travel, then we can discuss your budget.");
            } else {
                chatbotState.waitingForBudget = true;
                addBotMessage(`What's your total budget for the ${chatbotState.travelDays}-day trip? (in USD)`);
            }
        } else if (message.toLowerCase().includes('hello') || message.toLowerCase().includes('hi')) {
            addBotMessage(botResponses.welcome);
            chatbotState.waitingForDays = true;
        } else if (message.toLowerCase().includes('thank')) {
            addBotMessage(botResponses.goodbye);
        } else if (message.toLowerCase().includes('help')) {
            addBotMessage(botResponses.help);
        } else if (message.toLowerCase().includes('more') && chatbotState.suggestedTrips.length > 0) {
            // User wants more recommendations
            getMoreRecommendations();
        } else {
            addBotMessage(botResponses.dont_understand);
        }
    }, 1000);
}

// Process days input from user
function processDaysInput(input) {
    // Clean the input and convert to number
    const days = parseInt(input.trim());
    
    // Validate days
    if (isNaN(days) || days <= 0 || days > 30) {
        addBotMessage(botResponses.days_invalid);
        return;
    }
    
    // Store days and confirm
    chatbotState.travelDays = days;
    
    const daysConfirmation = botResponses.days_confirmed.replace('$DAYS', days);
    addBotMessage(daysConfirmation);
    
    // Reset waiting states
    chatbotState.waitingForDays = false;
    chatbotState.waitingForBudget = true;
}

// Process budget input from user
function processBudgetInput(input) {
    // Remove currency symbols and commas
    const cleanInput = input.replace(/[$,]/g, '');
    const budget = parseFloat(cleanInput);
    
    if (isNaN(budget) || budget <= 0) {
        addBotMessage(botResponses.budget_invalid);
        return;
    }
    
    // Calculate minimum budget for the trip duration
    const minDailyBudget = chatbotState.stats.minDailyBudget;
    const minDestinationPrice = chatbotState.stats.minDestPrice || 500;
    const minTotalBudget = (minDailyBudget * chatbotState.travelDays) + minDestinationPrice;
    
    if (budget < minTotalBudget) {
        const tooLowMsg = botResponses.budget_too_low
            .replace('$DAYS', chatbotState.travelDays)
            .replace('$MINPRICE', minTotalBudget.toLocaleString());
        addBotMessage(tooLowMsg);
        return;
    }
    
    // Store budget and confirm
    chatbotState.currentBudget = budget;
    
    const budgetConfirmation = botResponses.budget_confirmed
        .replace('$DAYS', chatbotState.travelDays)
        .replace('$BUDGET', budget.toLocaleString());
    addBotMessage(budgetConfirmation);
    
    // Reset waiting states
    chatbotState.waitingForBudget = false;
    
    // Show loading message
    addBotMessage(`Planning your ${chatbotState.travelDays}-day trip within a budget of $${budget.toLocaleString()}...`);
    
    // Get trip recommendations
    getTripRecommendations(chatbotState.travelDays, budget);
}

// Get trip recommendations based on days and budget
async function getTripRecommendations(days, budget) {
    try {
        // Fetch all destinations
        const destResponse = await fetch('/api/destinations');
        
        if (!destResponse.ok) {
            throw new Error('Failed to load destinations');
        }
        
        const destinations = await destResponse.json();
        
        // Fetch all hotels
        const hotelResponse = await fetch('/api/hotels');
        
        if (!hotelResponse.ok) {
            throw new Error('Failed to load hotels');
        }
        
        const hotels = await hotelResponse.json();
        
        // Calculate trip combinations
        const tripOptions = calculateTripOptions(destinations, hotels, days, budget);
        
        // Store all recommended trips
        chatbotState.suggestedTrips = tripOptions;
        
        if (tripOptions.length === 0) {
            addBotMessage(botResponses.no_results);
            return;
        }
        
        // Show top 3 recommendations
        const topRecommendations = tripOptions.slice(0, 3);
        
        // Add message before recommendations
        addBotMessage(`I found ${tripOptions.length} trip options within your budget! Here are my top recommendations for your ${days}-day trip:`);
        
        // Add trip cards
        addTripCards(topRecommendations);
        
        // Remove these trips from our list for "more" functionality
        chatbotState.suggestedTrips = tripOptions.slice(3);
        
        // Add follow-up message
        if (tripOptions.length > 3) {
            addBotMessage("Would you like to see more options? Just ask for 'more' or start over with a new search.");
        } else {
            addBotMessage(botResponses.more_help);
        }
        
    } catch (error) {
        console.error('Error getting trip recommendations:', error);
        addBotMessage(botResponses.error);
    }
}

/**
 * Calculate possible trip options based on destinations, hotels, days and budget
 */
function calculateTripOptions(destinations, hotels, days, budget) {
    const tripOptions = [];
    
    // Daily expenses estimate (food, local transport, activities)
    const dailyExpenses = 50;
    
    // Try all combinations of destinations and hotels
    destinations.forEach(destination => {
        // Skip if destination price is already over budget
        if (destination.price > budget) return;
        
        // Calculate remaining budget for hotel and expenses
        const remainingBudget = budget - destination.price;
        const requiredBudgetForExpenses = dailyExpenses * days;
        const maxHotelBudget = remainingBudget - requiredBudgetForExpenses;
        
        // Skip if not enough budget left for hotel and expenses
        if (maxHotelBudget <= 0) return;
        
        // Calculate max price per night for hotel
        const maxPricePerNight = maxHotelBudget / days;
        
        // Find suitable hotels
        const suitableHotels = hotels.filter(hotel => 
            hotel.price_per_night <= maxPricePerNight
        );
        
        // Sort hotels by rating (highest first)
        suitableHotels.sort((a, b) => b.rating - a.rating);
        
        // Take the top 3 hotels for this destination
        const topHotels = suitableHotels.slice(0, 3);
        
        topHotels.forEach(hotel => {
            const totalHotelCost = hotel.price_per_night * days;
            const totalExpenses = dailyExpenses * days;
            const totalPrice = destination.price + totalHotelCost + totalExpenses;
            
            tripOptions.push({
                destination: destination,
                hotel: hotel,
                dailyExpenses: dailyExpenses,
                totalPrice: totalPrice,
                // Calculate value score (higher is better)
                valueScore: (hotel.rating * 10) - (totalPrice / 100)
            });
        });
    });
    
    // Sort by value score (highest first)
    tripOptions.sort((a, b) => b.valueScore - a.valueScore);
    
    return tripOptions;
}

// Get more trip recommendations
function getMoreRecommendations() {
    if (chatbotState.suggestedTrips.length === 0) {
        addBotMessage("I've already shown you all the trip options that match your criteria. Would you like to start a new search?");
        return;
    }
    
    // Get the next 3 trips (or fewer if less than 3 remaining)
    const nextBatch = Math.min(3, chatbotState.suggestedTrips.length);
    const nextRecommendations = chatbotState.suggestedTrips.slice(0, nextBatch);
    
    // Update the remaining trips
    chatbotState.suggestedTrips = chatbotState.suggestedTrips.slice(nextBatch);
    
    // Add message
    addBotMessage("Here are more trip options within your budget:");
    
    // Add trip cards
    addTripCards(nextRecommendations);
    
    // Add follow-up message
    if (chatbotState.suggestedTrips.length > 0) {
        addBotMessage("Would you like to see more options? Just ask for 'more' or start over with a new search.");
    } else {
        addBotMessage(botResponses.more_help);
    }
}

// Scroll chat messages to bottom
function scrollToBottom() {
    const chatMessages = document.getElementById('chat-messages');
    chatMessages.scrollTop = chatMessages.scrollHeight;
}