-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 18, 2025 at 07:39 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `travelease`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `destination` varchar(255) NOT NULL,
  `transport` varchar(50) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `num_people` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `destinations`
--

CREATE TABLE `destinations` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `destinations`
--

INSERT INTO `destinations` (`id`, `name`, `image_url`, `price`, `description`, `created_at`) VALUES
(1, 'Paris, France', 'https://source.unsplash.com/800x600/?paris', 1200.00, 'Explore the romantic streets of Paris, visit the iconic Eiffel Tower, Louvre Museum, and enjoy exquisite French cuisine. Paris offers a perfect blend of history, art, and culinary experiences, making it one of the most visited cities in the world.', '2025-04-15 13:15:36'),
(2, 'Bali, Indonesia', 'https://source.unsplash.com/800x600/?bali', 850.00, 'Experience the tropical paradise of Bali with its stunning beaches, lush rice terraces, and spiritual temples. Perfect for relaxation, adventure, and cultural immersion. Enjoy affordable luxury accommodations, traditional Balinese massages, and vibrant nightlife.', '2025-04-15 13:15:36'),
(3, 'Kyoto, Japan', 'https://source.unsplash.com/800x600/?kyoto', 1050.00, 'Discover the traditional side of Japan in Kyoto, home to thousands of classical Buddhist temples, gardens, imperial palaces, Shinto shrines, and traditional wooden houses. Experience the geisha culture in Gion district and the serene bamboo forests of Arashiyama.', '2025-04-15 13:15:36'),
(4, 'Rome, Italy', 'https://source.unsplash.com/800x600/?rome', 950.00, 'Step back in time in the Eternal City of Rome. Explore ancient ruins like the Colosseum and Roman Forum, toss a coin in the Trevi Fountain, and marvel at Michelangelo\'s masterpiece in the Sistine Chapel. Indulge in authentic Italian pasta, pizza, and gelato.', '2025-04-15 13:15:36'),
(5, 'Santorini, Greece', 'https://source.unsplash.com/800x600/?santorini', 1300.00, 'Experience the breathtaking beauty of Santorini with its white-washed buildings, blue-domed churches, and stunning sunsets over the Aegean Sea. Explore charming villages, volcanic beaches, ancient ruins, and enjoy world-class wineries and restaurants.', '2025-04-15 13:15:36'),
(6, 'New York City, USA', 'https://source.unsplash.com/800x600/?newyork', 1100.00, 'Discover the city that never sleeps! From iconic landmarks like Times Square and the Statue of Liberty to world-class museums, Broadway shows, diverse neighborhoods, and endless shopping and dining options, New York offers something for everyone.', '2025-04-15 13:15:36'),
(7, 'Bangkok, Thailand', 'https://source.unsplash.com/800x600/?bangkok', 700.00, 'Immerse yourself in the vibrant capital of Thailand. Bangkok offers a unique blend of traditional temples, bustling markets, modern shopping malls, and legendary street food. Visit the Grand Palace, float through canals on a longtail boat, and experience the famous nightlife.', '2025-04-15 13:15:36'),
(8, 'Cairo, Egypt', 'https://source.unsplash.com/800x600/?cairo', 750.00, 'Journey to the land of pharaohs and pyramids. Explore the ancient wonders of Egypt, including the Great Pyramids of Giza and the Sphinx. Cruise down the Nile River, visit the Egyptian Museum, and experience the bustling energy of Cairo\'s markets and streets.', '2025-04-15 13:15:36'),
(9, 'Sydney, Australia', 'https://source.unsplash.com/800x600/?sydney', 1250.00, 'Enjoy the stunning harbor city of Sydney with its iconic Opera House, Harbour Bridge, and beautiful beaches like Bondi and Manly. Experience a unique blend of urban excitement and natural beauty, with excellent dining, shopping, and cultural attractions.', '2025-04-15 13:15:36'),
(10, 'Machu Picchu, Peru', 'https://source.unsplash.com/800x600/?machupicchu', 1350.00, 'Explore the ancient Incan citadel set high in the Andes Mountains. This UNESCO World Heritage site features remarkable stonework, terraces, and panoramic views of the surrounding mountains and valleys.', '2025-04-18 17:11:46'),
(11, 'Kyoto, Japan', 'https://source.unsplash.com/800x600/?kyoto', 1150.00, 'Immerse yourself in traditional Japanese culture in Kyoto, home to over 1,600 Buddhist temples, 400 Shinto shrines, and 17 UNESCO World Heritage sites. Experience tea ceremonies, zen gardens, and stunning seasonal landscapes.', '2025-04-18 17:11:46'),
(12, 'Barcelona, Spain', 'https://source.unsplash.com/800x600/?barcelona', 950.00, 'Discover the vibrant capital of Catalonia, known for Antoni Gaudí\'s incredible architecture, excellent cuisine, Mediterranean beaches, and a bustling cultural scene that perfectly blends historic charm with modern innovation.', '2025-04-18 17:11:46'),
(13, 'Marrakech, Morocco', 'https://source.unsplash.com/800x600/?marrakech', 720.00, 'Lose yourself in the labyrinthine medina of Marrakech, where ancient traditions thrive alongside contemporary luxury. Explore bustling souks, ornate palaces, and tranquil gardens in this captivating North African destination.', '2025-04-18 17:11:46'),
(14, 'Queenstown, New Zealand', 'https://source.unsplash.com/800x600/?queenstown', 1280.00, 'Experience the adventure capital of the world nestled between majestic mountains and the crystal-clear Lake Wakatipu. Enjoy world-class skiing, bungee jumping, hiking, and breathtaking scenery in every direction.', '2025-04-18 17:11:46'),
(15, 'Prague, Czech Republic', 'https://source.unsplash.com/800x600/?prague', 850.00, 'Wander through the medieval streets of Prague, with its preserved Gothic, Renaissance, and Baroque architecture. Explore Prague Castle, cross the iconic Charles Bridge, and enjoy the city\'s rich cultural heritage and affordable beer.', '2025-04-18 17:11:46'),
(16, 'Rio de Janeiro, Brazil', 'https://source.unsplash.com/800x600/?riodejaneiro', 1050.00, 'Experience the vibrant energy of Rio with its stunning beaches, iconic Christ the Redeemer statue, and famous Carnival celebrations. Enjoy spectacular views from Sugarloaf Mountain and the rhythm of samba in this Brazilian metropolis.', '2025-04-18 17:11:46'),
(17, 'Petra, Jordan', 'https://source.unsplash.com/800x600/?petra', 890.00, 'Discover the ancient city carved into rose-colored stone, a UNESCO World Heritage site and one of the New Seven Wonders of the World. Walk through the narrow Siq to reveal the magnificent Treasury facade and explore elaborate tombs and temples.', '2025-04-18 17:11:46'),
(18, 'Venice, Italy', 'https://source.unsplash.com/800x600/?venice', 1080.00, 'Navigate the romantic canals of Venice in a gondola, explore St. Mark\'s Square, and lose yourself in the labyrinth of narrow streets. This unique city built on water offers incomparable architecture, art, and cuisine.', '2025-04-18 17:11:46'),
(19, 'Bora Bora, French Polynesia', 'https://source.unsplash.com/800x600/?borabora', 2800.00, 'Indulge in the ultimate luxury escape on this small South Pacific island, renowned for its overwater bungalows, turquoise lagoon, and coral reefs. Enjoy privacy, relaxation, and some of the most beautiful waters on Earth.', '2025-04-18 17:11:46'),
(20, 'Amsterdam, Netherlands', 'https://source.unsplash.com/800x600/?amsterdam', 920.00, 'Cruise along picturesque canals lined with 17th-century buildings in the Dutch capital. Visit world-class museums like the Rijksmuseum and Van Gogh Museum, explore vibrant neighborhoods, and enjoy the city\'s progressive atmosphere.', '2025-04-18 17:11:46'),
(21, 'Serengeti National Park, Tanzania', 'https://source.unsplash.com/800x600/?serengeti', 1950.00, 'Witness the spectacular Great Migration where millions of wildebeest, zebra, and gazelle traverse the plains. This vast ecosystem offers unparalleled wildlife viewing, including the \"Big Five\" and diverse birdlife.', '2025-04-18 17:11:46'),
(22, 'Istanbul, Turkey', 'https://source.unsplash.com/800x600/?istanbul', 780.00, 'Experience the city that bridges Europe and Asia, where Byzantine churches stand alongside Ottoman mosques. Explore the Hagia Sophia, Blue Mosque, and Grand Bazaar while savoring delicious Turkish cuisine.', '2025-04-18 17:11:46'),
(23, 'Great Barrier Reef, Australia', 'https://source.unsplash.com/800x600/?greatbarrierreef', 1420.00, 'Dive or snorkel through the world\'s largest coral reef system, home to thousands of marine species. This natural wonder offers unforgettable underwater adventures along Australia\'s northeast coast.', '2025-04-18 17:11:46'),
(24, 'Dubrovnik, Croatia', 'https://source.unsplash.com/800x600/?dubrovnik', 870.00, 'Walk the ancient walls surrounding this perfectly preserved medieval city on the Adriatic Coast. Explore marble streets, baroque buildings, and enjoy dramatic views of the fortified old town and sparkling sea.', '2025-04-18 17:11:46'),
(25, 'Angkor Wat, Cambodia', 'https://source.unsplash.com/800x600/?angkorwat', 680.00, 'Marvel at the world\'s largest religious monument, an architectural masterpiece built by the Khmer Empire. The temple complex features intricate carvings telling stories from Hindu mythology and Buddhist traditions.', '2025-04-18 17:11:46'),
(26, 'Reykjavik, Iceland', 'https://source.unsplash.com/800x600/?reykjavik', 1190.00, 'Use Iceland\'s capital as your base to explore volcanoes, geysers, hot springs, and glaciers. Experience the midnight sun in summer, the northern lights in winter, and the country\'s unique blend of Nordic heritage and modern design.', '2025-04-18 17:11:46'),
(27, 'Havana, Cuba', 'https://source.unsplash.com/800x600/?havana', 760.00, 'Step back in time in Cuba\'s colorful capital, where vintage American cars cruise past colonial architecture. Experience the rich culture through music, dance, art, and rum while exploring the city\'s revolutionary history.', '2025-04-18 17:11:46'),
(28, 'Cinque Terre, Italy', 'https://source.unsplash.com/800x600/?cinqueterre', 980.00, 'Discover five colorful fishing villages clinging to the cliffs along the Italian Riviera. Connected by scenic hiking trails and a railway, these car-free towns offer charming harbors, vineyards, and spectacular Mediterranean views.', '2025-04-18 17:11:46'),
(29, 'Galápagos Islands, Ecuador', 'https://source.unsplash.com/800x600/?galapagos', 2350.00, 'Follow in Darwin\'s footsteps on these remote Pacific islands, where unique wildlife shows no fear of humans. Observe giant tortoises, marine iguanas, and blue-footed boobies in their natural habitat.', '2025-04-18 17:11:46'),
(30, 'Cappadocia, Turkey', 'https://source.unsplash.com/800x600/?cappadocia', 680.00, 'Soar over surreal landscapes in a hot air balloon at sunrise, explore underground cities, and stay in cave hotels. This region\'s unique rock formations, known as \"fairy chimneys,\" create an otherworldly setting.', '2025-04-18 17:11:46'),
(31, 'Budapest, Hungary', 'https://source.unsplash.com/800x600/?budapest', 670.00, 'Relax in thermal baths, cruise the Danube River, and admire the city\'s stunning architecture from Buda Castle. This \"Pearl of the Danube\" offers a perfect blend of history, culture, and nightlife.', '2025-04-18 17:11:46'),
(32, 'Ha Long Bay, Vietnam', 'https://source.unsplash.com/800x600/?halongbay', 590.00, 'Sail through emerald waters dotted with thousands of limestone karsts and isles. This UNESCO World Heritage site offers breathtaking scenery, floating villages, and hidden beaches and caves to explore.', '2025-04-18 17:11:46'),
(33, 'Amalfi Coast, Italy', 'https://source.unsplash.com/800x600/?amalficoast', 1250.00, 'Drive along dramatic cliffs overlooking the Mediterranean, stopping at picturesque towns like Positano and Ravello. Enjoy exquisite cuisine, lemon groves, and the perfect blend of natural beauty and Italian elegance.', '2025-04-18 17:11:46'),
(34, 'Yellowstone National Park, USA', 'https://source.unsplash.com/800x600/?yellowstone', 780.00, 'Discover America\'s first national park, a wilderness wonderland of geysers, hot springs, canyons, and diverse wildlife. Witness Old Faithful\'s eruption and spot bison, elk, and perhaps even wolves or bears.', '2025-04-18 17:11:46'),
(35, 'St. Petersburg, Russia', 'https://source.unsplash.com/800x600/?stpetersburg', 920.00, 'Explore the cultural capital of Russia with its magnificent palaces, museums, and theaters. Visit the Hermitage, one of the world\'s greatest art museums, and experience the city\'s legendary White Nights in summer.', '2025-04-18 17:11:46'),
(36, 'Maui, Hawaii, USA', 'https://source.unsplash.com/800x600/?maui', 1680.00, 'Experience the Valley Isle\'s diverse landscapes, from the volcanic Haleakalā to the lush Road to Hana. Enjoy world-class beaches, snorkeling, surfing, and authentic Hawaiian culture.', '2025-04-18 17:11:46'),
(37, 'Cusco, Peru', 'https://source.unsplash.com/800x600/?cusco', 750.00, 'Discover the ancient capital of the Inca Empire nestled in the Peruvian Andes. Explore well-preserved colonial architecture built upon Incan foundations and use the city as your gateway to nearby Machu Picchu.', '2025-04-18 17:11:46'),
(38, 'Santorini, Greece', 'https://source.unsplash.com/800x600/?santorini', 1320.00, 'Experience the postcard-perfect white-washed buildings with blue domes perched on cliffs overlooking the azure Aegean Sea. Enjoy spectacular sunsets, volcanic beaches, ancient ruins, and exceptional local wines.', '2025-04-18 17:11:46'),
(39, 'Los Angeles, USA', 'https://source.unsplash.com/800x600/?losangeles', 1050.00, 'Explore the entertainment capital of the world, from the glitz of Hollywood to the beaches of Malibu. Visit iconic landmarks like the Hollywood Sign, enjoy world-class museums, and experience diverse neighborhoods and cuisine.', '2025-04-18 17:11:46'),
(40, 'Berlin, Germany', 'https://source.unsplash.com/800x600/?berlin', 780.00, 'Immerse yourself in the dynamic capital known for its cutting-edge art, architecture, and nightlife. Explore historic sites related to World War II and the Cold War while experiencing the city\'s creative energy and cultural diversity.', '2025-04-18 17:11:46');

-- --------------------------------------------------------

--
-- Table structure for table `hotels`
--

CREATE TABLE `hotels` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `price_per_night` decimal(10,2) NOT NULL,
  `rating` decimal(3,1) NOT NULL,
  `description` text NOT NULL,
  `amenities` text NOT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hotels`
--

INSERT INTO `hotels` (`id`, `name`, `location`, `image_url`, `price_per_night`, `rating`, `description`, `amenities`, `latitude`, `longitude`, `created_at`) VALUES
(1, 'Grand Hyatt', 'New York City, USA', 'https://source.unsplash.com/800x600/?hotel,luxury', 350.00, 4.5, 'Experience luxury in the heart of Manhattan. This 5-star hotel features spacious rooms with panoramic city views, multiple restaurants, and a world-class spa.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Business Center,Concierge', 40.7505, -73.9764, '2025-04-18 17:11:01'),
(2, 'The Ritz-Carlton', 'Paris, France', 'https://source.unsplash.com/800x600/?hotel,paris', 520.00, 4.8, 'Located near the Champs-Élysées, this iconic hotel offers elegant accommodations with classic French décor, marble bathrooms, and views of the Eiffel Tower.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Concierge,Valet Parking', 48.8698, 2.3079, '2025-04-18 17:11:01'),
(3, 'Mandarin Oriental', 'Tokyo, Japan', 'https://source.unsplash.com/800x600/?hotel,tokyo', 480.00, 4.7, 'Occupying the top floors of a skyscraper, this luxury hotel offers breathtaking views of Tokyo, Michelin-starred dining, and serene spa treatments inspired by Japanese traditions.', 'Free WiFi,Spa,Fitness Center,Restaurant,Room Service,Business Center,Concierge,Airport Shuttle', 35.6895, 139.774, '2025-04-18 17:11:01'),
(4, 'Burj Al Arab Jumeirah', 'Dubai, UAE', 'https://source.unsplash.com/800x600/?hotel,dubai', 1200.00, 4.9, 'This iconic sail-shaped hotel on a private island offers ultra-luxurious suites, personal butler service, and gold-plated opulence throughout.', 'Free WiFi,Private Beach,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Helipad', 25.1412, 55.1854, '2025-04-18 17:11:01'),
(5, 'The Peninsula', 'Hong Kong', 'https://source.unsplash.com/800x600/?hotel,hongkong', 550.00, 4.8, 'This historic luxury hotel combines colonial charm with modern amenities, offering harbor views, a fleet of Rolls-Royces, and impeccable service.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Business Center,Airport Shuttle', 22.2934, 114.173, '2025-04-18 17:11:01'),
(6, 'Atlantis Paradise Island', 'Nassau, Bahamas', 'https://source.unsplash.com/800x600/?hotel,beach', 450.00, 4.3, 'This massive ocean-themed resort features a water park, marine habitat, casino, and numerous restaurants spread across a tropical paradise island.', 'Free WiFi,Private Beach,Water Park,Swimming Pool,Casino,Spa,Fitness Center,Restaurant', 25.083, -77.3248, '2025-04-18 17:11:01'),
(7, 'Hotel Arts Barcelona', 'Barcelona, Spain', 'https://source.unsplash.com/800x600/?hotel,barcelona', 320.00, 4.5, 'This beachfront high-rise hotel offers stunning Mediterranean views, contemporary design, and a two-Michelin-star restaurant.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Business Center,Beach Access', 41.3868, 2.19, '2025-04-18 17:11:01'),
(8, 'Waldorf Astoria', 'Beverly Hills, USA', 'https://source.unsplash.com/800x600/?hotel,beverlyhills', 850.00, 4.7, 'This modern luxury hotel offers California elegance, rooftop pool with panoramic views, and spacious rooms with private balconies.', 'Free WiFi,Rooftop Pool,Spa,Fitness Center,Restaurant,Room Service,Concierge,Valet Parking', 34.0672, -118.41, '2025-04-18 17:11:01'),
(9, 'Raffles Hotel', 'Singapore', 'https://source.unsplash.com/800x600/?hotel,singapore', 600.00, 4.9, 'This colonial-style icon has hosted celebrities and royalty since 1887, offering luxurious suites, a tropical garden, and the home of the Singapore Sling cocktail.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Business Center,Butler Service', 1.295, 103.852, '2025-04-18 17:11:01'),
(10, 'Bellagio', 'Las Vegas, USA', 'https://source.unsplash.com/800x600/?hotel,lasvegas', 280.00, 4.4, 'Famous for its dancing fountains, this luxury resort features elegant rooms, a casino, fine dining restaurants, and spectacular entertainment.', 'Free WiFi,Swimming Pool,Casino,Spa,Fitness Center,Restaurant,Room Service,Nightclub', 36.1126, -115.177, '2025-04-18 17:11:01'),
(11, 'The Savoy', 'London, UK', 'https://source.unsplash.com/800x600/?hotel,london', 590.00, 4.7, 'This historic luxury hotel on the River Thames blends English Edwardian and Art Deco styles with modern amenities and world-class dining.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Concierge,Butler Service', 51.51, -0.12, '2025-04-18 17:11:01'),
(12, 'Aman Tokyo', 'Tokyo, Japan', 'https://source.unsplash.com/800x600/?hotel,luxury,japan', 800.00, 4.8, 'This urban sanctuary occupies the top floors of a skyscraper, offering minimalist luxury with traditional Japanese aesthetics and an indulgent spa.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Business Center,Panoramic Views', 35.6868, 139.765, '2025-04-18 17:11:01'),
(13, 'The Plaza', 'New York City, USA', 'https://source.unsplash.com/800x600/?hotel,newyork', 650.00, 4.6, 'This landmark luxury hotel facing Central Park offers opulent rooms, a champagne bar, and a legacy of elegance dating back to 1907.', 'Free WiFi,Spa,Fitness Center,Restaurant,Room Service,Concierge,Butler Service,Shopping Arcade', 40.7643, -73.9743, '2025-04-18 17:11:01'),
(14, 'Four Seasons Resort Bora Bora', 'Bora Bora, French Polynesia', 'https://source.unsplash.com/800x600/?hotel,borabora', 1100.00, 4.9, 'This paradise resort offers overwater bungalows with direct lagoon access, mountain views, and unparalleled luxury in a stunning natural setting.', 'Free WiFi,Private Beach,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Water Sports', -16.5069, -151.722, '2025-04-18 17:11:01'),
(15, 'Marina Bay Sands', 'Singapore', 'https://source.unsplash.com/800x600/?hotel,singapore,modern', 450.00, 4.5, 'This iconic hotel features the world\'s largest rooftop infinity pool, a massive casino, luxury shopping mall, and rooms with spectacular city views.', 'Free WiFi,Infinity Pool,Casino,Spa,Fitness Center,Restaurant,Room Service,Shopping Mall', 1.2834, 103.861, '2025-04-18 17:11:01'),
(16, 'Claridge\'s', 'London, UK', 'https://source.unsplash.com/800x600/?hotel,classic,luxury', 720.00, 4.8, 'This Art Deco jewel in Mayfair has been a London landmark since the 1800s, offering timeless elegance and impeccable service.', 'Free WiFi,Spa,Fitness Center,Restaurant,Room Service,Concierge,Business Center,Afternoon Tea', 51.5129, -0.1476, '2025-04-18 17:11:01'),
(17, 'Soneva Jani', 'Maldives', 'https://source.unsplash.com/800x600/?hotel,maldives', 1800.00, 4.9, 'This spectacular resort offers overwater villas with retractable roofs, water slides, and direct ocean access in a pristine lagoon setting.', 'Free WiFi,Private Pool,Private Beach,Spa,Restaurant,Room Service,Water Sports,Outdoor Cinema', 5.5583, 73.625, '2025-04-18 17:11:01'),
(18, 'The Langham', 'Chicago, USA', 'https://source.unsplash.com/800x600/?hotel,chicago', 380.00, 4.7, 'Occupying floors 1-13 of a landmark building, this luxury hotel offers spacious rooms, river views, and award-winning wellness facilities.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Business Center,Club Lounge', 41.8905, -87.6273, '2025-04-18 17:11:01'),
(19, 'Hotel du Cap-Eden-Roc', 'Antibes, France', 'https://source.unsplash.com/800x600/?hotel,france,riviera', 1250.00, 4.8, 'This legendary hotel on the French Riviera has hosted celebrities and royalty since 1870, offering seaside pavilions, lush gardens, and timeless elegance.', 'Free WiFi,Swimming Pool,Private Beach,Spa,Tennis Courts,Restaurant,Room Service,Water Sports', 43.5538, 7.1269, '2025-04-18 17:11:01'),
(20, 'The Oberoi Udaivilas', 'Udaipur, India', 'https://source.unsplash.com/800x600/?hotel,india,palace', 580.00, 4.9, 'This palatial hotel on Lake Pichola offers luxury inspired by the royal heritage of Rajasthan, with private pools, lake views, and exquisite architecture.', 'Free WiFi,Swimming Pool,Private Pools,Spa,Fitness Center,Restaurant,Room Service,Boat Rides', 24.5771, 73.6828, '2025-04-18 17:11:01'),
(21, 'Hotel Bel-Air', 'Los Angeles, USA', 'https://source.unsplash.com/800x600/?hotel,luxury,garden', 720.00, 4.8, 'Nestled in 12 acres of gardens, this Spanish mission-style luxury retreat offers privacy, a renowned spa, and Wolfgang Puck cuisine.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Garden,Concierge', 34.082, -118.449, '2025-04-18 17:11:01'),
(22, 'The Silo', 'Cape Town, South Africa', 'https://source.unsplash.com/800x600/?hotel,capetown', 950.00, 4.7, 'Built in a converted grain silo above the Zeitz Museum of Contemporary Art Africa, this distinctive hotel offers spectacular views through geometric windows.', 'Free WiFi,Rooftop Pool,Spa,Fitness Center,Restaurant,Room Service,Art Gallery,Concierge', -33.9066, 18.4164, '2025-04-18 17:11:01'),
(23, 'Bulgari Resort', 'Bali, Indonesia', 'https://source.unsplash.com/800x600/?hotel,bali', 880.00, 4.8, 'Perched on a cliff overlooking the Indian Ocean, this Italian-designed resort blends traditional Balinese style with contemporary luxury.', 'Free WiFi,Infinity Pool,Private Beach,Spa,Fitness Center,Restaurant,Room Service,Wedding Chapel', -8.8149, 115.089, '2025-04-18 17:11:01'),
(24, 'The St. Regis', 'Rome, Italy', 'https://source.unsplash.com/800x600/?hotel,rome', 620.00, 4.6, 'This opulent hotel near the Spanish Steps offers Belle Époque grandeur, custom furnishings, and the famous St. Regis butler service.', 'Free WiFi,Spa,Fitness Center,Restaurant,Room Service,Butler Service,Concierge,Business Center', 41.9043, 12.4944, '2025-04-18 17:11:01'),
(25, 'Jade Mountain', 'St. Lucia', 'https://source.unsplash.com/800x600/?hotel,caribbean', 1400.00, 4.9, 'This architectural marvel offers open-air sanctuaries with private infinity pools and spectacular views of the Piton Mountains.', 'Free WiFi,Private Infinity Pools,Spa,Fitness Center,Restaurant,Room Service,Beach Access,Organic Farm', 13.8646, -61.0757, '2025-04-18 17:11:01'),
(26, 'Park Hyatt', 'Sydney, Australia', 'https://source.unsplash.com/800x600/?hotel,sydney', 700.00, 4.7, 'This luxury hotel offers harbor-front rooms with private balconies facing the Sydney Opera House and direct access to the historic Rocks district.', 'Free WiFi,Rooftop Pool,Spa,Fitness Center,Restaurant,Room Service,Concierge,24-Hour Reception', -33.8594, 151.201, '2025-04-18 17:11:01'),
(27, 'Amangiri', 'Utah, USA', 'https://source.unsplash.com/800x600/?hotel,desert', 1900.00, 4.9, 'This remote desert hideaway blends into the landscape with concrete pavilions, offering luxury suites with private terraces and breathtaking canyon views.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Desert Excursions,Stargazing', 37.0413, -111.226, '2025-04-18 17:11:01'),
(28, 'The Ritz', 'Madrid, Spain', 'https://source.unsplash.com/800x600/?hotel,madrid', 480.00, 4.7, 'This Belle Époque palace near the Prado Museum offers old-world luxury with chandeliers, antiques, and one of Europe\'s most spectacular indoor pools.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Concierge,Champagne Bar', 40.4158, -3.6926, '2025-04-18 17:11:01'),
(29, 'The Brando', 'Tetiaroa, French Polynesia', 'https://source.unsplash.com/800x600/?hotel,island', 3000.00, 4.9, 'This exclusive eco-luxury resort on Marlon Brando\'s private island offers beachfront villas with private pools and a commitment to sustainability.', 'Free WiFi,Private Pool,Private Beach,Spa,Fitness Center,Restaurant,Room Service,Water Sports', -17.0022, -149.59, '2025-04-18 17:11:01'),
(30, 'The Balmoral', 'Edinburgh, UK', 'https://source.unsplash.com/800x600/?hotel,edinburgh', 520.00, 4.6, 'This landmark hotel at the top of Princes Street offers castle views, Michelin-starred dining, and traditional Scottish luxury.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Whisky Bar,Afternoon Tea', 55.9535, -3.1884, '2025-04-18 17:11:01'),
(31, 'The Upper House', 'Hong Kong', 'https://source.unsplash.com/800x600/?hotel,modern,asian', 650.00, 4.8, 'This sleek, contemporary hotel starts on the 38th floor, offering harbor views, paperless check-in, and spacious studios with luxurious bathrooms.', 'Free WiFi,Fitness Center,Restaurant,Room Service,Concierge,Business Center,EV Charging,Yoga Classes', 22.2785, 114.165, '2025-04-18 17:11:01'),
(32, 'Royal Mansour', 'Marrakech, Morocco', 'https://source.unsplash.com/800x600/?hotel,morocco', 1500.00, 4.9, 'Commissioned by the King of Morocco, this palatial hotel offers private riads with plunge pools, rooftop terraces, and traditional Moroccan craftsmanship.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Hammam,Private Riads', 31.6309, -7.9931, '2025-04-18 17:11:01'),
(33, 'Four Seasons Hotel', 'Florence, Italy', 'https://source.unsplash.com/800x600/?hotel,florence', 780.00, 4.8, 'This converted Renaissance palace and convent features original frescoes, hand-painted ceilings, and the city\'s largest private garden.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Garden,Art Collection', 43.7731, 11.2594, '2025-04-18 17:11:01'),
(34, 'Singita Lebombo Lodge', 'Kruger National Park, South Africa', 'https://source.unsplash.com/800x600/?hotel,safari', 2100.00, 4.9, 'This contemporary safari lodge offers glass-walled suites suspended above the N\'wanetsi River with spectacular views of the surrounding wildlife.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Game Drives,Wine Cellar', -23.9986, 31.7218, '2025-04-18 17:11:01'),
(35, 'The Connaught', 'London, UK', 'https://source.unsplash.com/800x600/?hotel,luxury,british', 690.00, 4.7, 'This Mayfair institution blends original features with contemporary design, offering a Michelin-starred restaurant and one of London\'s best cocktail bars.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Concierge,Art Collection', 51.5107, -0.1496, '2025-04-18 17:11:01'),
(36, 'Amanpuri', 'Phuket, Thailand', 'https://source.unsplash.com/800x600/?hotel,thailand', 950.00, 4.8, 'Aman\'s original resort offers pavilions and villas scattered among coconut palms, with private pools and access to a secluded white-sand beach.', 'Free WiFi,Swimming Pool,Private Beach,Spa,Fitness Center,Restaurant,Room Service,Water Sports', 7.9757, 98.2794, '2025-04-18 17:11:01'),
(37, 'Hotel Cipriani', 'Venice, Italy', 'https://source.unsplash.com/800x600/?hotel,venice', 970.00, 4.9, 'Located on Giudecca Island with views of the lagoon and St. Mark\'s Square, this legendary hotel offers old-world Venetian luxury and Olympic-sized pool.', 'Free WiFi,Swimming Pool,Spa,Fitness Center,Restaurant,Room Service,Boat Shuttle,Garden', 45.4268, 12.3414, '2025-04-18 17:11:01'),
(38, 'Tierra Patagonia', 'Torres del Paine, Chile', 'https://source.unsplash.com/800x600/?hotel,mountain', 800.00, 4.8, 'This striking, low-impact lodge blends into the landscape at the edge of Torres del Paine National Park, offering all-inclusive adventures and panoramic views.', 'Free WiFi,Swimming Pool,Spa,Restaurant,All-Inclusive Activities,Guided Excursions,Stargazing,Library', -50.9423, -73.114, '2025-04-18 17:11:01'),
(39, 'The Gritti Palace', 'Venice, Italy', 'https://source.unsplash.com/800x600/?hotel,grandeur', 830.00, 4.8, 'This 15th-century palazzo on the Grand Canal has hosted nobility and celebrities, offering sumptuous rooms with antiques and Murano glass chandeliers.', 'Free WiFi,Spa,Fitness Center,Restaurant,Room Service,Concierge,Culinary School,Private Dock', 45.4318, 12.3315, '2025-04-18 17:11:01'),
(40, 'Nihi Sumba', 'Sumba Island, Indonesia', 'https://source.unsplash.com/800x600/?hotel,beach,remote', 1500.00, 4.9, 'This remote luxury resort on a wild Indonesian island offers private pool villas, world-class surfing, and a spa safari experience.', 'Free WiFi,Private Pool,Private Beach,Spa,Fitness Center,Restaurant,Horseback Riding,Surfing', -9.7739, 119.393, '2025-04-18 17:11:01');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_bookings_user_id` (`user_id`),
  ADD KEY `idx_bookings_destination` (`destination`);

--
-- Indexes for table `destinations`
--
ALTER TABLE `destinations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_destinations_name` (`name`);

--
-- Indexes for table `hotels`
--
ALTER TABLE `hotels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_hotels_name` (`name`),
  ADD KEY `idx_hotels_location` (`location`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_users_username` (`username`),
  ADD KEY `idx_users_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `destinations`
--
ALTER TABLE `destinations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `hotels`
--
ALTER TABLE `hotels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
