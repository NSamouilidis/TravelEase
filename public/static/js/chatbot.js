document.addEventListener('DOMContentLoaded', () => {
    initChatbot();
});

const botResponses = {
    welcome: "👋 Hi there! I'm TravelBot, your travel assistant. I'll help you plan your perfect trip. How many days are you planning to travel?",
    days_invalid: "Please enter a valid number of days (between 1 and 30).",
    days_confirmed: "Great! You're planning a $DAYS-day trip. Now, what's your total budget for the trip? (in USD)",
    budget_invalid: "Please enter a valid budget amount (a number greater than 0)",
    budget_too_low: "I couldn't find suitable options at that price point. For a $DAYS-day trip, our minimum recommended budget is $MINPRICE. Please enter a higher amount.",
    budget_confirmed: "Perfect! I'll find some great $DAYS-day trips within your $BUDGET budget.",
    no_results: "I couldn't find any suitable destinations within your budget. Try increasing your budget or shortening your trip duration.",
    error: "Sorry, I encountered an error while searching. Please try again later.",
    more_help: "Would you like more destination suggestions or help with something else?",
    dont_understand: "I'm not sure I understand. I can help you plan a trip based on your duration and budget. Please tell me how many days you'd like to travel.",
    goodbye: "Thanks for chatting! Feel free to return when you're ready to plan your next adventure. Have a great day! 😊",
    help: "I can help you plan your perfect trip. I'll ask about your travel duration and budget, then suggest destinations that fit your preferences."
};

let chatbotState = {
    active: false,
    waitingForDays: false,
    waitingForBudget: false,
    travelDays: 0,
    currentBudget: 0,
    suggestedDestinations: [],
    stats: {
        minDailyBudget: 75, 
        avgDestPrice: 800   
    }
};

function initChatbot() {
    if (!document.getElementById('chatbot-container')) {
        createChatbotUI();
    }
    
    const chatToggle = document.getElementById('chat-toggle');
    const chatInput = document.getElementById('chat-input');
    const chatSend = document.getElementById('chat-send');
    const chatClose = document.getElementById('chat-close');
    
    chatToggle.addEventListener('click', () => {
        toggleChatbot();
    });
    
    chatClose.addEventListener('click', () => {
        toggleChatbot(false);
    });
    
    chatSend.addEventListener('click', () => {
        sendUserMessage();
    });
    
    chatInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            sendUserMessage();
        }
    });
    
    loadChatbotStats();
}

async function loadChatbotStats() {
    try {
        const destResponse = await fetch('/api/chatbot/stats');
        
        if (destResponse.ok) {
            const destStats = await destResponse.json();
            chatbotState.stats.avgDestPrice = Math.ceil(destStats.avg_price);
            chatbotState.stats.minDestPrice = Math.ceil(destStats.min_price);
            
            chatbotState.stats.minDailyBudget = Math.ceil(chatbotState.stats.minDestPrice / 10);
        }
        
        console.log('Chatbot stats loaded:', chatbotState.stats);
    } catch (error) {
        console.error('Error loading chatbot stats:', error);
    }
}
function createChatbotUI() {
    const chatToggle = document.createElement('div');
    chatToggle.id = 'chat-toggle';
    chatToggle.innerHTML = '<i class="fas fa-comment"></i>';
    chatToggle.title = 'Chat with TravelBot';
    
    const chatbotContainer = document.createElement('div');
    chatbotContainer.id = 'chatbot-container';
    chatbotContainer.classList.add('chatbot-hidden');
    
    const chatHeader = document.createElement('div');
    chatHeader.id = 'chat-header';
    chatHeader.innerHTML = `
        <div class="chat-title">
            <i class="fas fa-robot"></i>
            <span>TravelBot</span>
        </div>
        <button id="chat-close"><i class="fas fa-times"></i></button>
    `;
    
    const chatMessages = document.createElement('div');
    chatMessages.id = 'chat-messages';
    
    const chatInputArea = document.createElement('div');
    chatInputArea.id = 'chat-input-area';
    chatInputArea.innerHTML = `
        <input type="text" id="chat-input" placeholder="Type your message...">
        <button id="chat-send"><i class="fas fa-paper-plane"></i></button>
    `;
    
    chatbotContainer.appendChild(chatHeader);
    chatbotContainer.appendChild(chatMessages);
    chatbotContainer.appendChild(chatInputArea);
    
    document.body.appendChild(chatToggle);
    document.body.appendChild(chatbotContainer);
    
    if (!document.getElementById('chatbot-styles')) {
        addChatbotStyles();
    }
}

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
        
        .destination-card {
            width: 100%;
            background-color: white;
            border: 1px solid #eee;
            border-radius: 8px;
            margin-bottom: 10px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        
        .destination-card-header {
            display: flex;
            align-items: center;
            padding: 10px;
            background-color: rgba(52, 152, 219, 0.1);
        }
        
        .destination-card-header h4 {
            margin: 0;
            font-size: 16px;
            flex: 1;
        }
        
        .destination-rating {
            color: #f39c12;
            margin-left: 10px;
        }
        
        .destination-card-image {
            width: 100%;
            height: 120px;
        }
        
        .destination-card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .destination-card-content {
            padding: 10px;
        }
        
        .destination-breakdown {
            margin: 10px 0;
            font-size: 14px;
        }
        
        .destination-breakdown-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
        }
        
        .destination-total {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
            padding-top: 10px;
            border-top: 1px dashed #ddd;
            font-weight: bold;
        }
        
        .destination-links {
            display: flex;
            margin-top: 10px;
        }
        
        .destination-links a {
            flex: 1;
            text-align: center;
            padding: 8px;
            border-radius: 5px;
            font-size: 14px;
            text-decoration: none;
            background-color: var(--primary-color);
            color: white;
        }
        
        .destination-links a:hover {
            background-color: var(--primary-dark);
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

function toggleChatbot(show) {
    const chatbotContainer = document.getElementById('chatbot-container');
    
    if (show === undefined) {
        show = chatbotContainer.classList.contains('chatbot-hidden');
    }
    
    if (show) {
        chatbotContainer.classList.remove('chatbot-hidden');
        chatbotState.active = true;
        
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

function sendUserMessage() {
    const chatInput = document.getElementById('chat-input');
    const message = chatInput.value.trim();
    
    if (message === '') return;
    
    addUserMessage(message);
    
    chatInput.value = '';
    
    processUserMessage(message);
}

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

function removeTypingIndicator() {
    const indicator = document.getElementById('typing-indicator');
    if (indicator) {
        indicator.remove();
    }
}

function addBotMessage(message) {
    const chatMessages = document.getElementById('chat-messages');
    const messageElement = document.createElement('div');
    messageElement.classList.add('chat-message', 'bot-message');
    messageElement.textContent = message;
    
    chatMessages.appendChild(messageElement);
    scrollToBottom();
}

function addUserMessage(message) {
    const chatMessages = document.getElementById('chat-messages');
    const messageElement = document.createElement('div');
    messageElement.classList.add('chat-message', 'user-message');
    messageElement.textContent = message;
    
    chatMessages.appendChild(messageElement);
    scrollToBottom();
}

function addDestinationCards(destinations) {
    const chatMessages = document.getElementById('chat-messages');
    const containerElement = document.createElement('div');
    containerElement.classList.add('chat-message', 'bot-message');
    
    let content = '<div class="destinations-container">';
    
    destinations.forEach(destination => {
        const destinationPrice = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD'
        }).format(destination.price);
        
        const dailyExpenses = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD'
        }).format(chatbotState.stats.minDailyBudget * chatbotState.travelDays);
        
        const totalPrice = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD'
        }).format(destination.price + (chatbotState.stats.minDailyBudget * chatbotState.travelDays));
        
        content += `
            <div class="destination-card">
                <div class="destination-card-header">
                    <h4>${destination.name}</h4>
                    <div class="destination-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                </div>
                <div class="destination-card-image">
                    <img src="${destination.image_url}" alt="${destination.name}" onerror="this.src='https://source.unsplash.com/800x600/?travel'">
                </div>
                <div class="destination-card-content">
                    <div class="destination-breakdown">
                        <div class="destination-breakdown-item">
                            <span>Destination:</span>
                            <span>${destinationPrice}</span>
                        </div>
                        <div class="destination-breakdown-item">
                            <span>Daily expenses (${chatbotState.travelDays} days):</span>
                            <span>${dailyExpenses}</span>
                        </div>
                        <div class="destination-total">
                            <span>Total:</span>
                            <span>${totalPrice}</span>
                        </div>
                    </div>
                    <div class="destination-links">
                        <a href="/place_detail.html?name=${encodeURIComponent(destination.name)}" target="_blank">View Details</a>
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

function processUserMessage(message) {
    const typingIndicator = showTypingIndicator();
    
    setTimeout(() => {
        removeTypingIndicator();
        
        if (chatbotState.waitingForDays) {
            processDaysInput(message);
        } else if (chatbotState.waitingForBudget) {
            processBudgetInput(message);
        } else if (message.toLowerCase().includes('days') || message.toLowerCase().includes('how long')) {
            chatbotState.waitingForDays = true;
            addBotMessage("How many days are you planning to travel?");
        } else if (message.toLowerCase().includes('budget') || message.toLowerCase().includes('money') || message.toLowerCase().includes('cost')) {
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
        } else if (message.toLowerCase().includes('more') && chatbotState.suggestedDestinations.length > 0) {
            getMoreRecommendations();
        } else {
            addBotMessage(botResponses.dont_understand);
        }
    }, 1000);
}

function processDaysInput(input) {
    const days = parseInt(input.trim());
    
    if (isNaN(days) || days <= 0 || days > 30) {
        addBotMessage(botResponses.days_invalid);
        return;
    }
    
    chatbotState.travelDays = days;
    
    const daysConfirmation = botResponses.days_confirmed.replace('$DAYS', days);
    addBotMessage(daysConfirmation);
    
    chatbotState.waitingForDays = false;
    chatbotState.waitingForBudget = true;
}

function processBudgetInput(input) {
    const cleanInput = input.replace(/[$,]/g, '');
    const budget = parseFloat(cleanInput);
    
    if (isNaN(budget) || budget <= 0) {
        addBotMessage(botResponses.budget_invalid);
        return;
    }
    
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
    
    chatbotState.currentBudget = budget;
    
    const budgetConfirmation = botResponses.budget_confirmed
        .replace('$DAYS', chatbotState.travelDays)
        .replace('$BUDGET', budget.toLocaleString());
    addBotMessage(budgetConfirmation);
    
    chatbotState.waitingForBudget = false;
    
    addBotMessage(`Planning your ${chatbotState.travelDays}-day trip within a budget of $${budget.toLocaleString()}...`);
    
    getDestinationRecommendations(chatbotState.travelDays, budget);
}

async function getDestinationRecommendations(days, budget) {
    try {
        const dailyExpenses = chatbotState.stats.minDailyBudget;
        const totalDailyExpenses = dailyExpenses * days;
        const maxDestinationPrice = budget - totalDailyExpenses;
        
        const response = await fetch(`/api/chatbot/recommendations?budget=${maxDestinationPrice}`);
        
        if (!response.ok) {
            throw new Error('Failed to load destination recommendations');
        }
        
        const data = await response.json();
        const destinations = data.destinations || [];
        
        chatbotState.suggestedDestinations = destinations;
        
        if (destinations.length === 0) {
            addBotMessage(botResponses.no_results);
            return;
        }
        
        const topRecommendations = destinations.slice(0, 3);
        
        addBotMessage(`I found ${destinations.length} destinations within your budget! Here are my top recommendations for your ${days}-day trip:`);
        
        addDestinationCards(topRecommendations);
        
        chatbotState.suggestedDestinations = destinations.slice(3);
        
        if (destinations.length > 3) {
            addBotMessage("Would you like to see more options? Just ask for 'more' or start over with a new search.");
        } else {
            addBotMessage(botResponses.more_help);
        }
        
    } catch (error) {
        console.error('Error getting destination recommendations:', error);
        addBotMessage(botResponses.error);
    }
}

function getMoreRecommendations() {
    if (chatbotState.suggestedDestinations.length === 0) {
        addBotMessage("I've already shown you all the destinations that match your criteria. Would you like to start a new search?");
        return;
    }
    
    const nextBatch = Math.min(3, chatbotState.suggestedDestinations.length);
    const nextRecommendations = chatbotState.suggestedDestinations.slice(0, nextBatch);
    
    chatbotState.suggestedDestinations = chatbotState.suggestedDestinations.slice(nextBatch);
    
    addBotMessage("Here are more destination options within your budget:");
    
    addDestinationCards(nextRecommendations);
    
    if (chatbotState.suggestedDestinations.length > 0) {
        addBotMessage("Would you like to see more options? Just ask for 'more' or start over with a new search.");
    } else {
        addBotMessage(botResponses.more_help);
    }
}

function scrollToBottom() {
    const chatMessages = document.getElementById('chat-messages');
    chatMessages.scrollTop = chatMessages.scrollHeight;
}