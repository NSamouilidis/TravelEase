-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 27, 2025 at 05:45 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

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

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `destination`, `transport`, `start_date`, `end_date`, `num_people`, `notes`, `created_at`) VALUES
(1, 1, 'Paris, France', 'Flight', '2025-04-30', '2025-05-02', 2, '', '2025-04-26 10:22:56'),
(2, 1, 'Kyoto, Japan', 'Flight', '2025-04-30', '2025-05-02', 2, '', '2025-04-26 10:50:17'),
(3, 1, 'Bali, Indonesia', 'Flight', '2025-04-30', '2025-05-06', 2, '', '2025-04-26 10:54:47'),
(4, 1, 'Santorini, Greece', 'Flight', '2025-04-30', '2025-05-02', 2, '', '2025-04-26 10:58:05'),
(5, 1, 'Serengeti National Park, Tanzania', 'Flight', '2025-04-26', '2025-04-27', 2, '', '2025-04-26 15:33:05'),
(6, 1, 'Istanbul, Turkey', 'Bus', '2025-04-26', '2025-04-27', 2, '', '2025-04-26 15:57:45'),
(7, 1, 'Santorini, Greece', 'Bus', '2025-04-26', '2025-04-27', 5, 'hello', '2025-04-26 16:01:22'),
(8, 2, 'Rio de Janeiro, Brazil', 'Flight', '2025-04-27', '2025-04-28', 2, '', '2025-04-27 09:44:44');

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
(1, 'Paris, France', 'https://worldinparis.com/wp-content/uploads/2022/01/View-from-the-Pantheon.jpg', '1200.00', 'Explore the romantic streets of Paris, visit the iconic Eiffel Tower, Louvre Museum, and enjoy exquisite French cuisine. Paris offers a perfect blend of history, art, and culinary experiences, making it one of the most visited cities in the world.', '2025-04-15 13:15:36'),
(2, 'Bali, Indonesia', 'https://images.ctfassets.net/x5n15ofh32yq/7ipnhOeuVkQUiXCXcPavD7/d299d7ed9835329cf179cdb9a1b71181/Bali_09_AdobeStock_84849478.jpeg?fm=webp&q=75&w=3840', '850.00', 'Experience the tropical paradise of Bali with its stunning beaches, lush rice terraces, and spiritual temples. Perfect for relaxation, adventure, and cultural immersion. Enjoy affordable luxury accommodations, traditional Balinese massages, and vibrant nightlife.', '2025-04-15 13:15:36'),
(3, 'Kyoto, Japan', 'https://www.touristjapan.com/wp-content/uploads/2025/01/map-of-kyoto-japan-travel-1024x683.jpg', '1050.00', 'Discover the traditional side of Japan in Kyoto, home to thousands of classical Buddhist temples, gardens, imperial palaces, Shinto shrines, and traditional wooden houses. Experience the geisha culture in Gion district and the serene bamboo forests of Arashiyama.', '2025-04-15 13:15:36'),
(4, 'Rome, Italy', 'https://i.natgeofe.com/n/3012ffcc-7361-45f6-98b3-a36d4153f660/colosseum-daylight-rome-italy.jpg', '950.00', 'Step back in time in the Eternal City of Rome. Explore ancient ruins like the Colosseum and Roman Forum, toss a coin in the Trevi Fountain, and marvel at Michelangelo\'s masterpiece in the Sistine Chapel. Indulge in authentic Italian pasta, pizza, and gelato.', '2025-04-15 13:15:36'),
(5, 'Santorini, Greece', 'https://www.greekexclusiveproperties.com/wp-content/uploads/2019/10/Santorini-Declared-No1-Island-in-the-World-.jpg', '1300.00', 'Experience the breathtaking beauty of Santorini with its white-washed buildings, blue-domed churches, and stunning sunsets over the Aegean Sea. Explore charming villages, volcanic beaches, ancient ruins, and enjoy world-class wineries and restaurants.', '2025-04-15 13:15:36'),
(6, 'New York City, USA', 'https://cdn.britannica.com/61/93061-050-99147DCE/Statue-of-Liberty-Island-New-York-Bay.jpg', '1100.00', 'Discover the city that never sleeps! From iconic landmarks like Times Square and the Statue of Liberty to world-class museums, Broadway shows, diverse neighborhoods, and endless shopping and dining options, New York offers something for everyone.', '2025-04-15 13:15:36'),
(7, 'Bangkok, Thailand', 'https://blog.bangkokair.com/wp-content/uploads/2024/10/Cover_bangkok-travel-guide-thailand-capital.jpg', '700.00', 'Immerse yourself in the vibrant capital of Thailand. Bangkok offers a unique blend of traditional temples, bustling markets, modern shopping malls, and legendary street food. Visit the Grand Palace, float through canals on a longtail boat, and experience the famous nightlife.', '2025-04-15 13:15:36'),
(8, 'Cairo, Egypt', 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2b/28/57/ef/caption.jpg?w=1200&h=-1&s=1', '750.00', 'Journey to the land of pharaohs and pyramids. Explore the ancient wonders of Egypt, including the Great Pyramids of Giza and the Sphinx. Cruise down the Nile River, visit the Egyptian Museum, and experience the bustling energy of Cairo\'s markets and streets.', '2025-04-15 13:15:36'),
(9, 'Sydney, Australia', 'https://www.sydneytravelguide.com.au/wp-content/uploads/2024/09/sydney-australia.jpg', '1250.00', 'Enjoy the stunning harbor city of Sydney with its iconic Opera House, Harbour Bridge, and beautiful beaches like Bondi and Manly. Experience a unique blend of urban excitement and natural beauty, with excellent dining, shopping, and cultural attractions.', '2025-04-15 13:15:36'),
(10, 'Machu Picchu, Peru', 'https://www.journeysinternational.com/wp-content/uploads/2019/04/Machu-Picchu-Inca-ruins-iStock-1339071089.jpg', '1350.00', 'Explore the ancient Incan citadel set high in the Andes Mountains. This UNESCO World Heritage site features remarkable stonework, terraces, and panoramic views of the surrounding mountains and valleys.', '2025-04-18 17:11:46'),
(12, 'Barcelona, Spain', 'https://img1.10bestmedia.com/Images/Photos/378847/GettyImages-1085317916_54_990x660.jpg?auto=webp&width=3840&quality=75', '950.00', 'Discover the vibrant capital of Catalonia, known for Antoni Gaudí\'s incredible architecture, excellent cuisine, Mediterranean beaches, and a bustling cultural scene that perfectly blends historic charm with modern innovation.', '2025-04-18 17:11:46'),
(13, 'Marrakech, Morocco', 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2b/9f/11/0a/caption.jpg?w=1200&h=-1&s=1&cx=1920&cy=1080&chk=v1_8e5215ef0ffaccc19ef9', '720.00', 'Lose yourself in the labyrinthine medina of Marrakech, where ancient traditions thrive alongside contemporary luxury. Explore bustling souks, ornate palaces, and tranquil gardens in this captivating North African destination.', '2025-04-18 17:11:46'),
(14, 'Queenstown, New Zealand', 'https://4kwallpapers.com/images/wallpapers/lake-wakatipu-queenstown-new-zealand-snow-mountains-4480x2520-2125.jpg', '1280.00', 'Experience the adventure capital of the world nestled between majestic mountains and the crystal-clear Lake Wakatipu. Enjoy world-class skiing, bungee jumping, hiking, and breathtaking scenery in every direction.', '2025-04-18 17:11:46'),
(15, 'Prague, Czech Republic', 'https://media.timeout.com/images/106252639/750/562/image.jpg', '850.00', 'Wander through the medieval streets of Prague, with its preserved Gothic, Renaissance, and Baroque architecture. Explore Prague Castle, cross the iconic Charles Bridge, and enjoy the city\'s rich cultural heritage and affordable beer.', '2025-04-18 17:11:46'),
(16, 'Rio de Janeiro, Brazil', 'https://www.mauriciotravels.com/wp-content/uploads/2023/10/rio.jpg', '1050.00', 'Experience the vibrant energy of Rio with its stunning beaches, iconic Christ the Redeemer statue, and famous Carnival celebrations. Enjoy spectacular views from Sugarloaf Mountain and the rhythm of samba in this Brazilian metropolis.', '2025-04-18 17:11:46'),
(17, 'Petra, Jordan', 'https://www.gokitetours.com/wp-content/uploads/2025/01/The-10-Best-Things-to-do-in-Petra-Jordan-1200x900.webp', '890.00', 'Discover the ancient city carved into rose-colored stone, a UNESCO World Heritage site and one of the New Seven Wonders of the World. Walk through the narrow Siq to reveal the magnificent Treasury facade and explore elaborate tombs and temples.', '2025-04-18 17:11:46'),
(18, 'Venice, Italy', 'https://ik.imgkit.net/3vlqs5axxjf/MM-TP/https://cdn.travelpulse.com/images/eea9edf4-a957-df11-b491-006073e71405/1722a4c2-f6c5-41e5-ad1f-b6872e4f96c0/source.jpg?tr=w-1200%2Cfo-auto', '1080.00', 'Navigate the romantic canals of Venice in a gondola, explore St. Mark\'s Square, and lose yourself in the labyrinth of narrow streets. This unique city built on water offers incomparable architecture, art, and cuisine.', '2025-04-18 17:11:46'),
(19, 'Bora Bora, French Polynesia', 'https://www.chartertravel.co.uk/assets/img/holidays/french-polynesia-fiji/french-polynesia21-x768.webp', '2800.00', 'Indulge in the ultimate luxury escape on this small South Pacific island, renowned for its overwater bungalows, turquoise lagoon, and coral reefs. Enjoy privacy, relaxation, and some of the most beautiful waters on Earth.', '2025-04-18 17:11:46'),
(20, 'Amsterdam, Netherlands', 'https://www.cunard.com/content/dam/cunard/inventory-assets/ports/AMS/AMS.jpg', '920.00', 'Cruise along picturesque canals lined with 17th-century buildings in the Dutch capital. Visit world-class museums like the Rijksmuseum and Van Gogh Museum, explore vibrant neighborhoods, and enjoy the city\'s progressive atmosphere.', '2025-04-18 17:11:46'),
(21, 'Serengeti National Park, Tanzania', 'https://www.arushapark.com/wp-content/uploads/2022/06/istockphoto-1141711907-612x612-1.jpg', '1950.00', 'Witness the spectacular Great Migration where millions of wildebeest, zebra, and gazelle traverse the plains. This vast ecosystem offers unparalleled wildlife viewing, including the \"Big Five\" and diverse birdlife.', '2025-04-18 17:11:46'),
(22, 'Istanbul, Turkey', 'https://lp-cms-production.imgix.net/2024-06/shutterstockRF291252509.jpg', '780.00', 'Experience the city that bridges Europe and Asia, where Byzantine churches stand alongside Ottoman mosques. Explore the Hagia Sophia, Blue Mosque, and Grand Bazaar while savoring delicious Turkish cuisine.', '2025-04-18 17:11:46'),
(23, 'Great Barrier Reef, Australia', 'https://www.australia.com/content/australia/en/places/cairns-and-surrounds/guide-to-the-great-barrier-reef/jcr:content/image.adapt.800.HIGH.jpg', '1420.00', 'Dive or snorkel through the world\'s largest coral reef system, home to thousands of marine species. This natural wonder offers unforgettable underwater adventures along Australia\'s northeast coast.', '2025-04-18 17:11:46'),
(24, 'Dubrovnik, Croatia', 'https://lp-cms-production.imgix.net/2021-06/shutterstockRF_662032261.jpg', '870.00', 'Walk the ancient walls surrounding this perfectly preserved medieval city on the Adriatic Coast. Explore marble streets, baroque buildings, and enjoy dramatic views of the fortified old town and sparkling sea.', '2025-04-18 17:11:46'),
(25, 'Angkor Wat, Cambodia', 'https://cdn.expeditions.com/globalassets/expedition-stories/cambodia-up-close-7-must-see-sites-at-angkor-wat/angkor-wat-main.jpg', '680.00', 'Marvel at the world\'s largest religious monument, an architectural masterpiece built by the Khmer Empire. The temple complex features intricate carvings telling stories from Hindu mythology and Buddhist traditions.', '2025-04-18 17:11:46'),
(26, 'Reykjavik, Iceland', 'https://silversea-discover.imgix.net/2021/06/REYKJAVIK-shutterstock_613997816.jpg?auto=compress%2Cformat&ixlib=php-3.3.1', '1190.00', 'Use Iceland\'s capital as your base to explore volcanoes, geysers, hot springs, and glaciers. Experience the midnight sun in summer, the northern lights in winter, and the country\'s unique blend of Nordic heritage and modern design.', '2025-04-18 17:11:46'),
(27, 'Havana, Cuba', 'https://media.gq.com/photos/5914dd2943572d096b80c8f3/4:3/w_1728,h_1296,c_limit/guide-to-old-havana-cuba.jpg', '760.00', 'Step back in time in Cuba\'s colorful capital, where vintage American cars cruise past colonial architecture. Experience the rich culture through music, dance, art, and rum while exploring the city\'s revolutionary history.', '2025-04-18 17:11:46'),
(28, 'Cinque Terre, Italy', 'https://portlandfoodanddrink.com/wp-content/uploads/2007/12/Riomaggiore-800-shutterstock_156908369.jpg', '980.00', 'Discover five colorful fishing villages clinging to the cliffs along the Italian Riviera. Connected by scenic hiking trails and a railway, these car-free towns offer charming harbors, vineyards, and spectacular Mediterranean views.', '2025-04-18 17:11:46'),
(29, 'Galápagos Islands, Ecuador', 'https://www.wendyperrin.com/wp-content/uploads/2020/02/Galapagos-Ecuador-cr-Shutterstock.jpg', '2350.00', 'Follow in Darwin\'s footsteps on these remote Pacific islands, where unique wildlife shows no fear of humans. Observe giant tortoises, marine iguanas, and blue-footed boobies in their natural habitat.', '2025-04-18 17:11:46'),
(30, 'Cappadocia, Turkey', 'https://static.independent.co.uk/2023/07/25/10/iStock-500615584.jpg', '680.00', 'Soar over surreal landscapes in a hot air balloon at sunrise, explore underground cities, and stay in cave hotels. This region\'s unique rock formations, known as \"fairy chimneys,\" create an otherworldly setting.', '2025-04-18 17:11:46'),
(31, 'Budapest, Hungary', 'https://lp-cms-production.imgix.net/2023-03/GettyRF_473481530.jpg', '670.00', 'Relax in thermal baths, cruise the Danube River, and admire the city\'s stunning architecture from Buda Castle. This \"Pearl of the Danube\" offers a perfect blend of history, culture, and nightlife.', '2025-04-18 17:11:46'),
(32, 'Ha Long Bay, Vietnam', 'https://www.paradisevietnam.com/public/backend/uploads/what-about-ha-long-bay.jpg', '590.00', 'Sail through emerald waters dotted with thousands of limestone karsts and isles. This UNESCO World Heritage site offers breathtaking scenery, floating villages, and hidden beaches and caves to explore.', '2025-04-18 17:11:46'),
(33, 'Amalfi Coast, Italy', 'https://www.thetrainline.com/cms/media/1452/italy-atrani-amalfi-coast.jpg?mode=crop&width=860&height=574&quality=70', '1250.00', 'Drive along dramatic cliffs overlooking the Mediterranean, stopping at picturesque towns like Positano and Ravello. Enjoy exquisite cuisine, lemon groves, and the perfect blend of natural beauty and Italian elegance.', '2025-04-18 17:11:46'),
(34, 'Yellowstone National Park, USA', 'https://www.fodors.com/wp-content/uploads/2023/04/HERO_WindRiverVsYellowstone_WindRiverRange_hike-in-wind-river-range-in-wyoming-usa-summer-season-2300757321.jpg', '780.00', 'Discover America\'s first national park, a wilderness wonderland of geysers, hot springs, canyons, and diverse wildlife. Witness Old Faithful\'s eruption and spot bison, elk, and perhaps even wolves or bears.', '2025-04-18 17:11:46'),
(35, 'St. Petersburg, Russia', 'https://www.ambassadorcruiseline.com/_astro/1200x675_Z1KLv8g.webp', '920.00', 'Explore the cultural capital of Russia with its magnificent palaces, museums, and theaters. Visit the Hermitage, one of the world\'s greatest art museums, and experience the city\'s legendary White Nights in summer.', '2025-04-18 17:11:46'),
(36, 'Maui, Hawaii, USA', 'https://aboardtheworld.com/wp-content/uploads/2022/11/Honolulu-Hawaii.jpg', '1680.00', 'Experience the Valley Isle\'s diverse landscapes, from the volcanic Haleakalā to the lush Road to Hana. Enjoy world-class beaches, snorkeling, surfing, and authentic Hawaiian culture.', '2025-04-18 17:11:46'),
(37, 'Cusco, Peru', 'https://www.peruforless.com/_next/image?url=https%3A%2F%2Fwww.peruforless.com%2Fimages%2Ftg-cusco-top-mobile.jpg&w=3840&q=75', '750.00', 'Discover the ancient capital of the Inca Empire nestled in the Peruvian Andes. Explore well-preserved colonial architecture built upon Incan foundations and use the city as your gateway to nearby Machu Picchu.', '2025-04-18 17:11:46'),
(38, 'Santorini, Greece', 'https://www.greekexclusiveproperties.com/wp-content/uploads/2019/10/Santorini-Declared-No1-Island-in-the-World-.jpg', '1320.00', 'Experience the postcard-perfect white-washed buildings with blue domes perched on cliffs overlooking the azure Aegean Sea. Enjoy spectacular sunsets, volcanic beaches, ancient ruins, and exceptional local wines.', '2025-04-18 17:11:46'),
(39, 'Los Angeles, USA', 'https://bucket-files.city-sightseeing.com/blog/2023/05/los-angeles-city-skyline.jpg', '1050.00', 'Explore the entertainment capital of the world, from the glitz of Hollywood to the beaches of Malibu. Visit iconic landmarks like the Hollywood Sign, enjoy world-class museums, and experience diverse neighborhoods and cuisine.', '2025-04-18 17:11:46'),
(40, 'Berlin, Germany', 'https://cdn.britannica.com/39/6839-050-27891400/Brandenburg-Gate-Berlin.jpg', '780.00', 'Immerse yourself in the dynamic capital known for its cutting-edge art, architecture, and nightlife. Explore historic sites related to World War II and the Cold War while experiencing the city\'s creative energy and cultural diversity.', '2025-04-18 17:11:46');

-- --------------------------------------------------------

--
-- Table structure for table `itineraries`
--

CREATE TABLE `itineraries` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `featured` tinyint(1) DEFAULT 0,
  `days` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(512) DEFAULT NULL,
  `author` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `description` text NOT NULL,
  `destinations` text NOT NULL,
  `highlights` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `itineraries`
--

INSERT INTO `itineraries` (`id`, `title`, `type`, `featured`, `days`, `price`, `image_url`, `author`, `date`, `description`, `destinations`, `highlights`, `created_at`) VALUES
(1, 'European Highlights', 'cultural', 1, 10, '2500.00', 'https://media.timeout.com/images/106177478/750/562/image.jpg', 'Travel Team', '2023-06-15', 'Experience the best of Europe with this carefully curated itinerary covering iconic landmarks and hidden gems. From the romantic streets of Paris to the ancient ruins of Rome and the sun-drenched islands of Greece, this journey will immerse you in the rich history, diverse cultures, and breathtaking landscapes that make Europe a timeless destination.', '[\"Paris, France\", \"Rome, Italy\", \"Santorini, Greece\"]', '[\"Skip-the-line access to major attractions\", \"Private guided tours with local experts\", \"Authentic culinary experiences\", \"Luxury accommodations in prime locations\", \"Seamless transportation between destinations\"]', '2025-04-26 16:24:00'),
(2, 'Asian Adventure', 'adventure', 1, 14, '3200.00', 'https://thetravelexpert.ie/wp-content/uploads/2018/09/thai-tourists-web.jpg', 'Adventure Guides', '2023-07-10', 'Embark on an unforgettable journey through the diverse landscapes and cultures of Asia. This carefully crafted itinerary takes you from the ancient temples of Kyoto to the bustling streets of Bangkok and the serene beaches of Bali. Immerse yourself in rich traditions, sample exotic cuisines, and witness breathtaking natural wonders.', '[\"Kyoto, Japan\", \"Bangkok, Thailand\", \"Bali, Indonesia\"]', '[\"Traditional cultural workshops and demonstrations\", \"Guided temple and historical site tours\", \"Street food tours with culinary experts\", \"Natural wonders and scenic landscapes\", \"Authentic homestay experiences\"]', '2025-04-26 16:24:00'),
(3, 'American Road Trip', 'adventure', 0, 7, '1800.00', 'https://thebathandwiltshireparent.co.uk/wp-content/uploads/2024/02/21.-Monument-Valley-Arizona-Sean-Pavone-759x500.jpeg', 'Road Warriors', '2023-08-05', 'Hit the open road and discover the breathtaking landscapes and vibrant cities of America. This road trip adventure takes you from the bustling streets of New York City to the dazzling lights of Las Vegas and the scenic beauty of San Francisco. Experience the freedom of the highway as you traverse diverse terrains.', '[\"New York City, USA\", \"Las Vegas, USA\", \"San Francisco, USA\"]', '[\"Premium rental vehicle with unlimited mileage\", \"Skip-the-line access to major attractions\", \"Curated dining experiences at iconic establishments\", \"Scenic routes with panoramic viewpoints\", \"Specially selected accommodations with character\"]', '2025-04-26 16:24:00'),
(4, 'Tropical Paradise', 'beach', 1, 7, '2100.00', 'https://thumb.photo-ac.com/d5/d5baebc9ef8dc28ea38f20bdd68214fc_t.jpeg', 'Beach Lovers', '2023-09-20', 'Relax and unwind on some of the world\'s most beautiful beaches with this perfect tropical getaway. From the tranquil shores of Bali to the crystal-clear waters of the Maldives and the scenic coastlines of Phuket, this journey is designed for ultimate relaxation and rejuvenation.', '[\"Bali, Indonesia\", \"Maldives\", \"Phuket, Thailand\"]', '[\"Premium beachfront accommodations\", \"Private snorkeling and diving excursions\", \"Sunset sailing trips with refreshments\", \"Beach yoga and wellness activities\", \"Island-hopping adventures to hidden gems\"]', '2025-04-26 16:24:00'),
(5, 'Historical Journey', 'cultural', 0, 12, '2800.00', 'https://www.arch2o.com/wp-content/uploads/2018/07/Arch2O-4-historical-sites-that-offer-free-online-virtual-tours-3.jpg', 'History Buffs', '2023-10-15', 'Step back in time and explore ancient civilizations and historical landmarks on this educational journey. From the pyramids of Egypt to the Acropolis in Greece and the ancient ruins of Rome, this trip connects you to the roots of human civilization.', '[\"Cairo, Egypt\", \"Athens, Greece\", \"Rome, Italy\"]', '[\"Expert archaeologist guides at each site\", \"Special access to restricted areas\", \"Interactive historical workshops\", \"Authentic period-inspired dining experiences\", \"Comprehensive historical context for each location\"]', '2025-04-26 16:24:00'),
(6, 'Urban Explorer', 'city', 0, 9, '2300.00', 'https://media.istockphoto.com/id/1454217037/photo/statue-of-liberty-and-new-york-city-skyline-with-manhattan-financial-district-world-trade.jpg?s=612x612&w=0&k=20&c=6V54_qVlDfo59GLEdY2W8DOjLbbHTJ9y4AnJ58a3cis=', 'City Guides', '2023-11-10', 'Experience the vibrant energy of the world\'s most exciting cities on this urban adventure. From the iconic skylines to hidden local gems, this journey takes you through the cultural heart of the world\'s greatest metropolises, with expert guides to navigate you through bustling streets and fascinating neighborhoods.', '[\"New York City, USA\", \"Tokyo, Japan\", \"London, UK\"]', '[\"Skip-the-line access to major landmarks\", \"Private city tours with local experts\", \"Culinary exploration of each city\'s specialties\", \"Luxury accommodations in central locations\", \"After-hours museum and gallery access\"]', '2025-04-26 16:29:42'),
(7, 'Nature Retreat', 'nature', 0, 8, '1900.00', 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2a/0d/a5/00/caption.jpg?w=1200&h=-1&s=1&cx=960&cy=540&chk=v1_4054ba9f6d2ab3122887', 'Nature Experts', '2023-12-05', 'Reconnect with nature as you explore stunning national parks, forests, and natural wonders. This eco-conscious journey brings you face-to-face with breathtaking landscapes and diverse wildlife while you learn about conservation efforts and sustainable tourism practices from expert naturalist guides.', '[\"Yellowstone, USA\", \"Swiss Alps\", \"Amazon Rainforest\"]', '[\"Guided hiking experiences with naturalists\", \"Wildlife spotting expeditions\", \"Eco-friendly accommodations\", \"Conservation workshops\", \"Photography sessions in prime locations\"]', '2025-04-26 16:29:42'),
(8, 'Island Hopping', 'beach', 0, 10, '2700.00', 'https://media-api.xogrp.com/images/0108e30b-f23f-4d5b-bacb-c13df8215c94~rs_768.h', 'Island Life', '2024-01-15', 'Discover paradise as you hop between beautiful islands with crystal clear waters and white sandy beaches. From Mediterranean gems to tropical havens, this island-hopping adventure offers a perfect blend of relaxation and exploration, with plenty of opportunities for both water activities and cultural immersion.', '[\"Santorini, Greece\", \"Bali, Indonesia\", \"Hawaii, USA\"]', '[\"Private boat transfers between islands\", \"Beachfront accommodations\", \"Water sports and activities package\", \"Local island cuisine experiences\", \"Hidden beaches and coves exploration\"]', '2025-04-26 16:29:42');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `profile_image` varchar(500) DEFAULT 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `created_at`, `profile_image`) VALUES
(1, 'dom', 'dom@dom.dom', '$2b$12$3no2DdjVmDWHXmIr9BQYS.ne7gbeI2sRftElmd.Y4ixH1SpXij0fu', '2025-04-25 17:39:31', 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
(2, 'test', 'test@test.com', '$2b$12$062J6hUq.2AKbXxFChU9M.mccY4f/XkBBJ2CMa3tBUHZwPjIENnbS', '2025-04-27 09:44:29', 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png');

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
-- Indexes for table `itineraries`
--
ALTER TABLE `itineraries`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `destinations`
--
ALTER TABLE `destinations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `itineraries`
--
ALTER TABLE `itineraries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
