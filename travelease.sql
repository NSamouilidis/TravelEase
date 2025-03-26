-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 26, 2025 at 04:36 PM
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
-- Table structure for table `attractions`
--

CREATE TABLE `attractions` (
  `attraction_id` int(11) NOT NULL,
  `destination_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `entry_fee` decimal(10,2) DEFAULT NULL,
  `opening_hours` text DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `popularity_score` decimal(3,1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attractions`
--

INSERT INTO `attractions` (`attraction_id`, `destination_id`, `name`, `description`, `category`, `address`, `latitude`, `longitude`, `entry_fee`, `opening_hours`, `image_url`, `popularity_score`, `created_at`, `updated_at`) VALUES
(31, 1, 'Louvre Museum', 'The world\'s largest art museum and a historic monument housing nearly 38,000 objects from prehistory to the 21st century.', 'Museum', 'Rue de Rivoli, 75001 Paris, France', '48.86110900', '2.33574400', '17.00', 'Monday, Thursday, Saturday, Sunday: 9:00 AM - 6:00 PM; Wednesday, Friday: 9:00 AM - 9:45 PM; Closed on Tuesdays', 'attractions/louvre_museum.jpg', '9.7', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(32, 2, 'Vatican Museums', 'A complex of museums and galleries housed in the Vatican City, featuring works from the immense collection amassed by the Roman Catholic Church.', 'Museum', 'Viale Vaticano, 00165 Roma RM, Italy', '41.90691200', '12.45338900', '17.00', 'Monday to Saturday: 9:00 AM - 6:00 PM; Closed on Sundays (except last Sunday of month)', 'attractions/vatican_museums.jpg', '9.5', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(33, 3, 'Park Güell', 'A public park system composed of gardens and architectural elements designed by Antoni Gaudí.', 'Park', 'Carrer d\'Olot, 08024 Barcelona, Spain', '41.41449900', '2.15237900', '10.00', 'Daily: 9:30 AM - 7:30 PM (hours vary by season)', 'attractions/park_guell.jpg', '9.2', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(34, 4, 'Acropolis Museum', 'Archaeological museum focused on the findings of the archaeological site of the Acropolis of Athens.', 'Museum', 'Dionysiou Areopagitou 15, Athens 117 42, Greece', '37.96873500', '23.72859300', '10.00', 'Summer: Monday: 8:00 AM - 4:00 PM; Tuesday-Sunday: 8:00 AM - 8:00 PM; Winter: Monday-Sunday: 9:00 AM - 5:00 PM', 'attractions/acropolis_museum.jpg', '9.4', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(35, 5, 'Oia Sunset Point', 'Famous viewpoint offering stunning sunset views over the caldera with the iconic white buildings and blue domes.', 'Viewpoint', 'Oia, Santorini 847 02, Greece', '36.46151800', '25.37566600', '0.00', 'Open 24 hours', 'attractions/oia_sunset.jpg', '9.8', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(36, 6, 'British Museum', 'World-famous museum of art and antiquities from ancient and living cultures, spanning two million years of human history.', 'Museum', 'Great Russell Street, London WC1B 3DG, United Kingdom', '51.51954500', '-0.12695500', '0.00', 'Daily: 10:00 AM - 5:00 PM; Fridays: 10:00 AM - 8:30 PM', 'attractions/british_museum.jpg', '9.5', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(37, 7, 'Hohenschwangau Castle', 'A 19th-century palace in southern Germany, the childhood residence of King Ludwig II of Bavaria.', 'Castle', 'Alpseestraße 30, 87645 Hohenschwangau, Germany', '47.55745800', '10.73865500', '13.00', 'April to September: 9:00 AM - 6:00 PM; October to March: 10:00 AM - 4:00 PM', 'attractions/hohenschwangau_castle.jpg', '8.9', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(38, 8, 'St. Mark\'s Basilica', 'The cathedral church of the Roman Catholic Archdiocese of Venice, known for its opulent design, gold mosaics, and its connection to the Palazzo Ducale.', 'Church', 'Piazza San Marco, 328, 30124 Venezia VE, Italy', '45.43454200', '12.33959600', '0.00', 'Monday to Saturday: 9:30 AM - 5:00 PM; Sunday: 2:00 PM - 5:00 PM', 'attractions/st_marks_basilica.jpg', '9.6', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(39, 9, 'Forbidden City', 'A palace complex in central Beijing, China, and houses the Palace Museum. It served as the home of emperors and their households.', 'Historical Site', '4 Jingshan Front Street, Dongcheng District, Beijing, China', '39.91689600', '116.39032500', '9.00', 'Tuesday to Sunday: 8:30 AM - 5:00 PM; Closed on Mondays', 'attractions/forbidden_city.jpg', '9.7', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(40, 10, 'Agra Fort', 'A historical fort in the city of Agra, a UNESCO World Heritage site located about 2.5 km northwest of its more famous sister monument, the Taj Mahal.', 'Historical Site', 'Agra Fort, Rakabganj, Agra, Uttar Pradesh 282003, India', '27.17938800', '78.02176400', '7.00', 'Daily: 6:00 AM - 6:00 PM', 'attractions/agra_fort.jpg', '9.1', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(41, 11, 'Bayon Temple', 'A richly decorated Khmer temple at Angkor, built in the late 12th or early 13th century as the state temple of King Jayavarman VII.', 'Temple', 'Angkor Thom, Siem Reap, Cambodia', '13.44138900', '103.85916700', '37.00', 'Daily: 5:00 AM - 5:30 PM (included in Angkor Pass)', 'attractions/bayon_temple.jpg', '9.3', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(42, 12, 'Chureito Pagoda', 'A five-story pagoda offering one of Japan\'s most iconic views of Mt. Fuji framed by cherry blossoms in spring.', 'Landmark', '2-chōme-8-1 Arakurayama, Fujiyoshida, Yamanashi 403-0011, Japan', '35.50147200', '138.80069400', '0.00', 'Daily: 9:00 AM - 5:00 PM', 'attractions/chureito_pagoda.jpg', '9.4', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(43, 13, 'Ubud Monkey Forest', 'A natural forest sanctuary and temple complex in Ubud, home to over 700 Balinese long-tailed macaques.', 'Nature Reserve', 'Jl. Monkey Forest, Ubud, Kecamatan Ubud, Kabupaten Gianyar, Bali 80571, Indonesia', '-8.51867200', '115.25879100', '8.00', 'Daily: 8:30 AM - 6:00 PM', 'attractions/ubud_monkey_forest.jpg', '9.1', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(44, 14, 'Gardens by the Bay', 'A nature park spanning 101 hectares of reclaimed land in the central region of Singapore, featuring the iconic Supertree Grove and Flower Dome.', 'Garden', '18 Marina Gardens Drive, Singapore 018953', '1.28150500', '103.86469000', '12.00', 'Daily: 9:00 AM - 9:00 PM (Outdoor Gardens); 9:00 AM - 9:00 PM (Conservatories)', 'attractions/gardens_by_the_bay.jpg', '9.6', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(45, 15, 'Grand Canyon Skywalk', 'A horseshoe-shaped cantilever bridge with a glass walkway at Eagle Point offering views 4,000 feet down to the floor of the Grand Canyon.', 'Viewpoint', 'Eagle Point Rd, Peach Springs, AZ 86434, USA', '36.01190000', '-113.82360000', '25.00', 'Daily: 8:00 AM - 6:00 PM (hours vary by season)', 'attractions/grand_canyon_skywalk.jpg', '8.9', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(46, 16, 'Empire State Building', 'A 102-story Art Deco skyscraper in Midtown Manhattan, offering panoramic views from its observation decks.', 'Landmark', '20 W 34th St, New York, NY 10001, USA', '40.74844300', '-73.98566300', '42.00', 'Daily: 8:00 AM - 2:00 AM', 'attractions/empire_state_building.jpg', '9.4', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(47, 17, 'Maid of the Mist', 'A boat tour of Niagara Falls that has carried passengers into the heart of the falls since 1846.', 'Tour', 'Prospect Point, Niagara Falls, NY 14303, USA', '43.08233700', '-79.07512300', '25.50', 'April to October: 9:00 AM - 8:00 PM (hours vary by season)', 'attractions/maid_of_the_mist.jpg', '9.5', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(48, 18, 'Lake Louise', 'A glacial lake known for its turquoise waters and the Victoria Glacier providing a stunning backdrop.', 'Natural Landmark', 'Lake Louise, AB T0L 1E0, Canada', '51.41730000', '-116.22390000', '0.00', 'Open 24 hours (Park pass required)', 'attractions/lake_louise.jpg', '9.7', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(49, 19, 'Cenote Ik Kil', 'A sacred natural pit or sinkhole featuring crystal-clear waters, just a short drive from Chichen Itza.', 'Natural Landmark', 'Carretera Costera del Golfo, Yucatán, Mexico', '20.66104100', '-88.56604200', '8.00', 'Daily: 9:00 AM - 5:00 PM', 'attractions/cenote_ik_kil.jpg', '9.2', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(50, 20, 'Sacred Valley', 'A region in Peru\'s Andean highlands with fertile farmland, colonial villages and Incan sites including terraces built on the slopes.', 'Historical Site', 'Sacred Valley, Cusco Region, Peru', '-13.32560000', '-72.08770000', '25.00', 'Daily: 7:00 AM - 6:00 PM (with tourist ticket)', 'attractions/sacred_valley.jpg', '9.3', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(51, 21, 'Copacabana Beach', 'The most famous beach in Rio, stretching for 4 km along the city\'s urban coastline.', 'Beach', 'Avenida Atlântica, Rio de Janeiro, Brazil', '-22.97105000', '-43.18236000', '0.00', 'Open 24 hours', 'attractions/copacabana_beach.jpg', '9.5', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(52, 22, 'Isla Incahuasi', 'A rocky outcrop of land and former island in Bolivia with giant cacti and unusual geological formations.', 'Natural Landmark', 'Salar de Uyuni, Bolivia', '-20.24300000', '-67.62300000', '5.00', 'Daily: 8:00 AM - 5:00 PM', 'attractions/isla_incahuasi.jpg', '9.0', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(53, 23, 'The Great Sphinx', 'A limestone statue of a reclining sphinx, a mythical creature with the head of a human and the body of a lion, dating from the reign of King Khafre.', 'Landmark', 'Al Giza Desert, Giza Governorate, Egypt', '29.97538900', '31.13766700', '9.00', 'Winter: 8:00 AM - 5:00 PM; Summer: 7:00 AM - 7:00 PM', 'attractions/great_sphinx.jpg', '9.4', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(54, 24, 'Devil\'s Pool', 'A natural infinity pool at the edge of Victoria Falls, allowing visitors to swim right up to the edge of the waterfall.', 'Natural Landmark', 'Livingstone Island, Zambia', '-17.92460000', '25.85700000', '95.00', 'Seasonal (August to January), guided tours only', 'attractions/devils_pool.jpg', '9.1', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(55, 25, 'Great Migration Viewing', 'Annual movement of wildebeest and other grazing herbivores across the Serengeti-Mara ecosystem.', 'Wildlife', 'Serengeti National Park, Tanzania', '-2.33333300', '34.83333300', '60.00', 'Daily: 6:00 AM - 6:00 PM (park entrance fee)', 'attractions/great_migration.jpg', '9.8', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(56, 26, 'Sydney Harbour Bridge', 'Steel arch bridge across Sydney Harbour carrying rail, vehicular, bicycle, and pedestrian traffic.', 'Landmark', 'Sydney Harbour Bridge, Sydney NSW, Australia', '-33.85230000', '151.21090000', '0.00', 'Open 24 hours (BridgeClimb tours operate from 6:00 AM - 10:00 PM)', 'attractions/sydney_harbour_bridge.jpg', '9.3', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(57, 27, 'Whitehaven Beach', 'A 7 km stretch of pristine white silica sand and turquoise water on Whitsunday Island.', 'Beach', 'Whitsunday Island, Queensland, Australia', '-20.28960000', '149.03640000', '0.00', 'Daily: 8:00 AM - 5:00 PM (accessible by tour only)', 'attractions/whitehaven_beach.jpg', '9.6', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(58, 28, 'Mitre Peak', 'The iconic peak rising 1,692 meters from the shores of Milford Sound, one of the most photographed mountains in New Zealand.', 'Natural Landmark', 'Fiordland National Park, South Island, New Zealand', '-44.64125700', '167.85671800', '0.00', 'Viewable 24 hours (best seen on Milford Sound cruises)', 'attractions/mitre_peak.jpg', '9.4', '2025-03-26 15:24:42', '2025-03-26 15:24:42'),
(59, 29, 'Matira Beach', 'A stunning public beach with powder-white sand and crystal-clear turquoise water, considered one of the most beautiful beaches in the world.', 'Beach', 'Matira Point, Bora Bora, French Polynesia', '-16.55072600', '-151.74640300', '0.00', 'Open 24 hours', 'attractions/matira_beach.jpg', '9.7', '2025-03-26 15:24:42', '2025-03-26 15:24:42');

-- --------------------------------------------------------

--
-- Table structure for table `destinations`
--

CREATE TABLE `destinations` (
  `destination_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `climate` varchar(50) DEFAULT NULL,
  `best_time_to_visit` varchar(100) DEFAULT NULL,
  `popularity_score` decimal(3,1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `destinations`
--

INSERT INTO `destinations` (`destination_id`, `name`, `country`, `city`, `description`, `image_url`, `climate`, `best_time_to_visit`, `popularity_score`, `created_at`, `updated_at`) VALUES
(1, 'Eiffel Tower', 'France', 'Paris', 'Iconic iron lattice tower on the Champ de Mars, one of the world\'s most recognizable landmarks.', 'destinations/eiffel_tower.jpg', 'Temperate', 'April to June, September to October', '9.8', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(2, 'Colosseum', 'Italy', 'Rome', 'Ancient amphitheater in the center of Rome, the largest ever built in the Roman Empire.', 'destinations/colosseum.jpg', 'Mediterranean', 'April to May, September to October', '9.5', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(3, 'Sagrada Familia', 'Spain', 'Barcelona', 'Unfinished basilica designed by Antoni Gaudí, combining Gothic and Art Nouveau elements.', 'destinations/sagrada_familia.jpg', 'Mediterranean', 'May to June, September', '9.3', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(4, 'Acropolis', 'Greece', 'Athens', 'Ancient citadel located on a rocky outcrop above the city of Athens.', 'destinations/acropolis.jpg', 'Mediterranean', 'March to May, September to November', '9.4', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(5, 'Santorini', 'Greece', 'Santorini', 'Stunning island known for white buildings with blue domes overlooking the Aegean Sea.', 'destinations/santorini.jpg', 'Mediterranean', 'April to June, September to October', '9.7', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(6, 'London Eye', 'United Kingdom', 'London', 'Giant Ferris wheel offering panoramic views of the city from the South Bank of the Thames.', 'destinations/london_eye.jpg', 'Temperate Maritime', 'May to September', '8.9', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(7, 'Neuschwanstein Castle', 'Germany', 'Bavaria', 'Nineteenth-century Romanesque Revival palace that inspired Disney\'s Sleeping Beauty Castle.', 'destinations/neuschwanstein.jpg', 'Alpine', 'June to September', '9.2', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(8, 'Venice Canals', 'Italy', 'Venice', 'Historic city built on a group of 118 small islands connected by canals and bridges.', 'destinations/venice.jpg', 'Mediterranean', 'April to May, September to October', '9.6', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(9, 'Great Wall of China', 'China', 'Beijing', 'Ancient defensive wall built along the northern borders of ancient Chinese states.', 'destinations/great_wall.jpg', 'Continental', 'April to May, September to October', '9.9', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(10, 'Taj Mahal', 'India', 'Agra', 'Ivory-white marble mausoleum commissioned by Mughal emperor Shah Jahan for his wife.', 'destinations/taj_mahal.jpg', 'Tropical', 'November to February', '9.8', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(11, 'Angkor Wat', 'Cambodia', 'Siem Reap', 'Largest religious monument in the world, originally constructed as a Hindu temple.', 'destinations/angkor_wat.jpg', 'Tropical', 'November to March', '9.5', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(12, 'Mount Fuji', 'Japan', 'Fuji', 'Japan\'s highest mountain and an active volcano, revered as a sacred symbol.', 'destinations/mount_fuji.jpg', 'Temperate', 'July to August for climbing, November to May for viewing', '9.4', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(13, 'Bali', 'Indonesia', 'Bali', 'Island paradise known for beaches, volcanic mountains, rice paddies, and yoga retreats.', 'destinations/bali.jpg', 'Tropical', 'April to October', '9.6', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(14, 'Marina Bay Sands', 'Singapore', 'Singapore', 'Iconic integrated resort with a hotel, casino, and the famous rooftop infinity pool.', 'destinations/marina_bay_sands.jpg', 'Tropical', 'February to April', '9.0', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(15, 'Grand Canyon', 'United States', 'Arizona', 'Steep-sided canyon carved by the Colorado River, known for its overwhelming size and colorful landscape.', 'destinations/grand_canyon.jpg', 'Desert/Semi-arid', 'March to May, September to November', '9.7', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(16, 'Statue of Liberty', 'United States', 'New York', 'Colossal neoclassical sculpture on Liberty Island, a symbol of freedom and democracy.', 'destinations/statue_liberty.jpg', 'Continental', 'April to June, September to November', '9.3', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(17, 'Niagara Falls', 'Canada/United States', 'Ontario/New York', 'Three magnificent waterfalls located on the border between the United States and Canada.', 'destinations/niagara_falls.jpg', 'Continental', 'June to August', '9.4', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(18, 'Banff National Park', 'Canada', 'Alberta', 'Canada\'s oldest national park, featuring glaciers, forests, alpine landscapes, and the Rocky Mountains.', 'destinations/banff.jpg', 'Subarctic', 'June to August, December to March', '9.2', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(19, 'Chichen Itza', 'Mexico', 'Yucatan', 'Large Mayan archaeological site featuring the famous step pyramid El Castillo.', 'destinations/chichen_itza.jpg', 'Tropical', 'November to March', '9.1', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(20, 'Machu Picchu', 'Peru', 'Cusco', 'Incan citadel set high in the Andes Mountains, known for its sophisticated dry-stone walls.', 'destinations/machu_picchu.jpg', 'Subtropical Highland', 'May to September', '9.8', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(21, 'Christ the Redeemer', 'Brazil', 'Rio de Janeiro', 'Art Deco statue of Jesus Christ at the summit of Mount Corcovado.', 'destinations/christ_redeemer.jpg', 'Tropical', 'May to October', '9.3', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(22, 'Salar de Uyuni', 'Bolivia', 'Uyuni', 'World\'s largest salt flat, creating a mirror effect when covered with a thin layer of water.', 'destinations/salt_flats.jpg', 'Desert', 'July to October, January to March', '9.0', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(23, 'Pyramids of Giza', 'Egypt', 'Giza', 'Ancient pyramid complex including the Great Pyramid, the only surviving monument of the Seven Wonders of the Ancient World.', 'destinations/pyramids.jpg', 'Desert', 'October to April', '9.6', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(24, 'Victoria Falls', 'Zimbabwe/Zambia', 'Livingstone/Victoria Falls', 'Waterfall on the Zambezi River, creating the largest curtain of falling water in the world.', 'destinations/victoria_falls.jpg', 'Subtropical', 'February to May', '9.1', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(25, 'Serengeti National Park', 'Tanzania', 'Serengeti', 'Famous for its annual migration of wildebeest and zebra, offering incredible safari opportunities.', 'destinations/serengeti.jpg', 'Tropical Savanna', 'June to October', '9.5', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(26, 'Sydney Opera House', 'Australia', 'Sydney', 'Multi-venue performing arts center featuring distinctive sail-shaped shells.', 'destinations/sydney_opera.jpg', 'Temperate', 'September to November, March to May', '9.4', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(27, 'Great Barrier Reef', 'Australia', 'Queensland', 'World\'s largest coral reef system composed of over 2,900 individual reefs and 900 islands.', 'destinations/great_barrier_reef.jpg', 'Tropical', 'June to October', '9.7', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(28, 'Milford Sound', 'New Zealand', 'South Island', 'Fjord known for towering Mitre Peak, rainforests, and waterfalls like Stirling and Bowen falls.', 'destinations/milford_sound.jpg', 'Temperate Maritime', 'November to April', '9.3', '2025-03-26 15:11:19', '2025-03-26 15:11:19'),
(29, 'Bora Bora', 'French Polynesia', 'Bora Bora', 'Small South Pacific island surrounded by sand-fringed motus and a turquoise lagoon.', 'destinations/bora_bora.jpg', 'Tropical', 'May to October', '9.8', '2025-03-26 15:11:19', '2025-03-26 15:11:19');

-- --------------------------------------------------------

--
-- Table structure for table `flights`
--

CREATE TABLE `flights` (
  `flight_id` int(11) NOT NULL,
  `airline` varchar(100) NOT NULL,
  `flight_number` varchar(20) NOT NULL,
  `departure_airport` varchar(100) NOT NULL,
  `departure_city` varchar(100) NOT NULL,
  `arrival_airport` varchar(100) NOT NULL,
  `arrival_city` varchar(100) NOT NULL,
  `departure_time` datetime NOT NULL,
  `arrival_time` datetime NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `available_seats` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flights`
--

INSERT INTO `flights` (`flight_id`, `airline`, `flight_number`, `departure_airport`, `departure_city`, `arrival_airport`, `arrival_city`, `departure_time`, `arrival_time`, `price`, `available_seats`, `created_at`, `updated_at`) VALUES
(1, 'Aegean Airlines', 'A3 1450', 'ATH', 'Athens', 'JTR', 'Santorini', '2025-06-15 08:00:00', '2025-06-15 08:45:00', '149.99', 32, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(2, 'Aegean Airlines', 'A3 1452', 'ATH', 'Athens', 'JTR', 'Santorini', '2025-06-15 15:30:00', '2025-06-15 16:15:00', '169.99', 24, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(3, 'Ryanair', 'FR 2451', 'ATH', 'Athens', 'FCO', 'Rome', '2025-06-16 07:15:00', '2025-06-16 08:45:00', '89.99', 45, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(4, 'Air France', 'AF 1232', 'CDG', 'Paris', 'FCO', 'Rome', '2025-06-16 10:20:00', '2025-06-16 12:10:00', '219.99', 28, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(5, 'British Airways', 'BA 484', 'LHR', 'London', 'CDG', 'Paris', '2025-06-17 09:15:00', '2025-06-17 11:30:00', '179.99', 35, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(6, 'easyJet', 'U2 8765', 'LGW', 'London', 'BCN', 'Barcelona', '2025-06-17 13:45:00', '2025-06-17 16:50:00', '95.50', 52, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(7, 'Lufthansa', 'LH 1829', 'MUC', 'Munich', 'ATH', 'Athens', '2025-06-18 07:30:00', '2025-06-18 11:05:00', '245.00', 18, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(8, 'Iberia', 'IB 3445', 'MAD', 'Madrid', 'FCO', 'Rome', '2025-06-18 14:25:00', '2025-06-18 16:55:00', '199.99', 27, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(9, 'Alitalia', 'AZ 611', 'FCO', 'Rome', 'VCE', 'Venice', '2025-06-19 09:00:00', '2025-06-19 10:15:00', '129.50', 38, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(10, 'Swiss Air', 'LX 1821', 'ZRH', 'Zurich', 'ATH', 'Athens', '2025-06-19 11:45:00', '2025-06-19 15:20:00', '258.75', 24, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(11, 'Singapore Airlines', 'SQ 321', 'SIN', 'Singapore', 'HKG', 'Hong Kong', '2025-06-15 14:30:00', '2025-06-15 18:15:00', '485.00', 42, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(12, 'Cathay Pacific', 'CX 712', 'HKG', 'Hong Kong', 'BKK', 'Bangkok', '2025-06-16 09:20:00', '2025-06-16 11:30:00', '375.50', 26, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(13, 'Air China', 'CA 932', 'PEK', 'Beijing', 'NRT', 'Tokyo', '2025-06-16 17:05:00', '2025-06-16 21:30:00', '429.99', 31, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(14, 'ANA', 'NH 861', 'NRT', 'Tokyo', 'ICN', 'Seoul', '2025-06-17 08:15:00', '2025-06-17 10:40:00', '349.50', 37, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(15, 'Thai Airways', 'TG 623', 'BKK', 'Bangkok', 'SIN', 'Singapore', '2025-06-17 12:50:00', '2025-06-17 16:15:00', '310.25', 45, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(16, 'Malaysia Airlines', 'MH 783', 'KUL', 'Kuala Lumpur', 'DPS', 'Bali', '2025-06-18 09:35:00', '2025-06-18 12:40:00', '265.75', 39, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(17, 'Emirates', 'EK 342', 'DXB', 'Dubai', 'DEL', 'New Delhi', '2025-06-18 22:30:00', '2025-06-19 04:15:00', '615.50', 28, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(18, 'IndiGo', 'IG 732', 'DEL', 'New Delhi', 'BOM', 'Mumbai', '2025-06-19 06:15:00', '2025-06-19 08:30:00', '89.99', 56, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(19, 'Vietnam Airlines', 'VN 502', 'HAN', 'Hanoi', 'SGN', 'Ho Chi Minh City', '2025-06-19 14:20:00', '2025-06-19 16:25:00', '135.00', 47, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(20, 'Garuda Indonesia', 'GA 824', 'CGK', 'Jakarta', 'DPS', 'Bali', '2025-06-20 07:50:00', '2025-06-20 10:45:00', '189.75', 41, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(21, 'American Airlines', 'AA 1532', 'JFK', 'New York', 'LAX', 'Los Angeles', '2025-06-15 10:30:00', '2025-06-15 13:45:00', '559.99', 23, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(22, 'Delta Air Lines', 'DL 2734', 'ATL', 'Atlanta', 'ORD', 'Chicago', '2025-06-15 15:45:00', '2025-06-15 16:50:00', '325.00', 37, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(23, 'United Airlines', 'UA 857', 'SFO', 'San Francisco', 'SEA', 'Seattle', '2025-06-16 08:20:00', '2025-06-16 10:45:00', '289.99', 42, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(24, 'Southwest Airlines', 'WN 1423', 'LAS', 'Las Vegas', 'PHX', 'Phoenix', '2025-06-16 13:10:00', '2025-06-16 14:25:00', '179.50', 58, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(25, 'JetBlue', 'B6 1789', 'BOS', 'Boston', 'MCO', 'Orlando', '2025-06-17 07:15:00', '2025-06-17 10:30:00', '249.99', 35, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(26, 'Air Canada', 'AC 865', 'YYZ', 'Toronto', 'YVR', 'Vancouver', '2025-06-17 11:40:00', '2025-06-17 14:15:00', '465.25', 26, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(27, 'Alaska Airlines', 'AS 329', 'SEA', 'Seattle', 'ANC', 'Anchorage', '2025-06-18 09:25:00', '2025-06-18 12:00:00', '399.50', 31, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(28, 'WestJet', 'WS 652', 'YYC', 'Calgary', 'YYZ', 'Toronto', '2025-06-18 14:30:00', '2025-06-18 20:15:00', '385.75', 28, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(29, 'Aeromexico', 'AM 489', 'MEX', 'Mexico City', 'CUN', 'Cancun', '2025-06-19 08:00:00', '2025-06-19 10:45:00', '210.00', 44, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(30, 'Spirit Airlines', 'NK 345', 'FLL', 'Fort Lauderdale', 'LGA', 'New York', '2025-06-19 16:20:00', '2025-06-19 19:05:00', '149.99', 52, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(31, 'LATAM Airlines', 'LA 932', 'GRU', 'Sao Paulo', 'SCL', 'Santiago', '2025-06-15 09:40:00', '2025-06-15 13:15:00', '479.99', 33, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(32, 'Avianca', 'AV 521', 'BOG', 'Bogota', 'LIM', 'Lima', '2025-06-16 11:30:00', '2025-06-16 14:45:00', '389.50', 37, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(33, 'Copa Airlines', 'CM 278', 'PTY', 'Panama City', 'GYE', 'Guayaquil', '2025-06-17 07:55:00', '2025-06-17 10:20:00', '345.75', 41, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(34, 'GOL Airlines', 'G3 1463', 'GIG', 'Rio de Janeiro', 'EZE', 'Buenos Aires', '2025-06-18 10:15:00', '2025-06-18 13:30:00', '405.25', 28, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(35, 'Aerolineas Argentinas', 'AR 1378', 'EZE', 'Buenos Aires', 'CUZ', 'Cusco', '2025-06-19 08:30:00', '2025-06-19 12:45:00', '510.00', 32, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(36, 'Ethiopian Airlines', 'ET 506', 'ADD', 'Addis Ababa', 'JNB', 'Johannesburg', '2025-06-15 23:45:00', '2025-06-16 04:15:00', '575.50', 29, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(37, 'Egypt Air', 'MS 843', 'CAI', 'Cairo', 'CPT', 'Cape Town', '2025-06-16 22:15:00', '2025-06-17 06:30:00', '725.75', 24, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(38, 'Kenya Airways', 'KQ 432', 'NBO', 'Nairobi', 'LOS', 'Lagos', '2025-06-17 14:10:00', '2025-06-17 17:45:00', '495.00', 35, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(39, 'Royal Air Maroc', 'AT 587', 'CMN', 'Casablanca', 'ACC', 'Accra', '2025-06-18 21:25:00', '2025-06-19 01:15:00', '610.25', 30, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(40, 'South African Airways', 'SA 264', 'JNB', 'Johannesburg', 'MRU', 'Mauritius', '2025-06-19 10:40:00', '2025-06-19 15:55:00', '645.99', 27, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(41, 'Qantas', 'QF 123', 'SYD', 'Sydney', 'MEL', 'Melbourne', '2025-06-15 08:45:00', '2025-06-15 10:20:00', '225.50', 46, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(42, 'Air New Zealand', 'NZ 103', 'AKL', 'Auckland', 'WLG', 'Wellington', '2025-06-16 07:30:00', '2025-06-16 08:35:00', '179.99', 38, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(43, 'Jetstar', 'JQ 527', 'MEL', 'Melbourne', 'BNE', 'Brisbane', '2025-06-17 15:15:00', '2025-06-17 17:30:00', '165.25', 53, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(44, 'Virgin Australia', 'VA 835', 'SYD', 'Sydney', 'PER', 'Perth', '2025-06-18 19:20:00', '2025-06-19 00:15:00', '429.75', 32, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(45, 'Fiji Airways', 'FJ 910', 'NAN', 'Nadi', 'SYD', 'Sydney', '2025-06-19 13:45:00', '2025-06-19 16:35:00', '510.00', 29, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(46, 'British Airways', 'BA 172', 'LHR', 'London', 'JFK', 'New York', '2025-06-15 11:05:00', '2025-06-15 14:25:00', '1250.00', 18, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(47, 'Emirates', 'EK 202', 'DXB', 'Dubai', 'JFK', 'New York', '2025-06-16 02:50:00', '2025-06-16 09:15:00', '1575.50', 23, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(48, 'Singapore Airlines', 'SQ 1', 'SIN', 'Singapore', 'SFO', 'San Francisco', '2025-06-17 09:25:00', '2025-06-17 22:40:00', '1350.75', 26, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(49, 'Qantas', 'QF 8', 'SYD', 'Sydney', 'DFW', 'Dallas', '2025-06-18 13:35:00', '2025-06-19 10:25:00', '1850.00', 15, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(50, 'Lufthansa', 'LH 430', 'FRA', 'Frankfurt', 'ORD', 'Chicago', '2025-06-19 10:55:00', '2025-06-19 13:20:00', '1150.25', 31, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(51, 'Air France', 'AF 84', 'CDG', 'Paris', 'SFO', 'San Francisco', '2025-06-20 10:30:00', '2025-06-20 13:15:00', '1325.99', 28, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(52, 'Qatar Airways', 'QR 701', 'DOH', 'Doha', 'SYD', 'Sydney', '2025-06-21 02:15:00', '2025-06-21 22:05:00', '1775.50', 19, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(53, 'Air Canada', 'AC 33', 'YYZ', 'Toronto', 'HKG', 'Hong Kong', '2025-06-22 00:45:00', '2025-06-23 05:30:00', '1650.25', 22, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(54, 'Turkish Airlines', 'TK 11', 'IST', 'Istanbul', 'SIN', 'Singapore', '2025-06-23 13:20:00', '2025-06-24 05:35:00', '890.00', 33, '2025-03-26 15:20:08', '2025-03-26 15:20:08'),
(55, 'Etihad Airways', 'EY 130', 'AUH', 'Abu Dhabi', 'JFK', 'New York', '2025-06-24 03:10:00', '2025-06-24 09:25:00', '1395.75', 25, '2025-03-26 15:20:08', '2025-03-26 15:20:08');

-- --------------------------------------------------------

--
-- Table structure for table `hotels`
--

CREATE TABLE `hotels` (
  `hotel_id` int(11) NOT NULL,
  `destination_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(255) NOT NULL,
  `rating` decimal(2,1) DEFAULT NULL,
  `price_range` varchar(20) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `amenities` text DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `website_url` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hotels`
--

INSERT INTO `hotels` (`hotel_id`, `destination_id`, `name`, `address`, `rating`, `price_range`, `description`, `amenities`, `image_url`, `latitude`, `longitude`, `website_url`, `contact_phone`, `created_at`, `updated_at`) VALUES
(1, 1, 'Le Meurice', '228 Rue de Rivoli, 75001 Paris, France', '4.9', '€€€€€', 'Luxury hotel with Eiffel Tower views and classic French elegance', 'Spa, Fine Dining Restaurant, Concierge, Free WiFi, Room Service, Fitness Center, Valet Parking', 'hotels/le_meurice.jpg', '48.86522920', '2.32881970', 'https://www.lemeurice.com', '+33 1 44 58 10 10', '2025-03-26 15:17:11', '2025-03-26 15:17:11'),
(2, 1, 'Hotel Pullman Paris Tour Eiffel', '18 Avenue De Suffren, 75015 Paris, France', '4.5', '€€€€', 'Modern hotel located steps away from the Eiffel Tower', 'Restaurant, Bar, Fitness Center, Free WiFi, Meeting Rooms, Terrace', 'hotels/pullman_paris.jpg', '48.85630300', '2.29358300', 'https://www.accorhotels.com/pullman-paris', '+33 1 44 38 56 00', '2025-03-26 15:17:11', '2025-03-26 15:17:11'),
(3, 2, 'Hotel Palazzo Manfredi', 'Via Labicana 125, 00184 Rome, Italy', '4.8', '€€€€€', 'Luxury hotel with direct views of the Colosseum', 'Rooftop Restaurant, Bar, Concierge, Free WiFi, Airport Shuttle, Room Service', 'hotels/palazzo_manfredi.jpg', '41.89052540', '12.49555320', 'https://www.palazzomanfredi.com', '+39 06 7759 1380', '2025-03-26 15:17:11', '2025-03-26 15:17:11'),
(4, 2, 'Hotel Capo d\'Africa', 'Via Capo d\'Africa 54, 00184 Rome, Italy', '4.3', '€€€€', 'Elegant hotel just a short walk from the Colosseum', 'Rooftop Terrace, Restaurant, Bar, Fitness Center, Meeting Rooms, Free WiFi', 'hotels/capo_africa.jpg', '41.88815900', '12.49599200', 'https://www.hotelcapodafrica.com', '+39 06 772801', '2025-03-26 15:17:11', '2025-03-26 15:17:11'),
(5, 3, 'Hotel Ayre Rosellón', 'Carrer del Roselló 390, 08025 Barcelona, Spain', '4.4', '€€€', 'Modern hotel with rooftop terrace offering direct views of the Sagrada Familia', 'Rooftop Terrace, Restaurant, Bar, Free WiFi, Meeting Rooms, Fitness Center', 'hotels/ayre_rosellon.jpg', '41.40412770', '2.17529860', 'https://www.ayrehoteles.com/rosellon', '+34 932 08 09 80', '2025-03-26 15:17:11', '2025-03-26 15:17:11'),
(6, 3, 'Ibis Barcelona Centro', 'Calle Laietana 23, 08003 Barcelona, Spain', '3.8', '€€', 'Budget-friendly hotel in central Barcelona, close to major attractions', 'Restaurant, Bar, Free WiFi, 24-hour Reception, Pet Friendly', 'hotels/ibis_barcelona.jpg', '41.38505200', '2.17787000', 'https://www.accorhotels.com/ibis-barcelona', '+34 932 20 30 40', '2025-03-26 15:17:11', '2025-03-26 15:17:11'),
(7, 4, 'Hotel Grande Bretagne', '1 Vasileos Georgiou A, Athens 105 64, Greece', '4.9', '€€€€€', 'Historic luxury hotel with views of the Acropolis and Syntagma Square', 'Rooftop Restaurant, Spa, Indoor and Outdoor Pools, Fitness Center, Multiple Restaurants, Butler Service', 'hotels/grande_bretagne.jpg', '37.97642200', '23.73512900', 'https://www.grandebretagne.gr', '+30 21 0333 0000', '2025-03-26 15:17:11', '2025-03-26 15:17:11'),
(8, 4, 'The Athens Gate Hotel', '10 Syngrou Avenue, Athens 117 42, Greece', '4.5', '€€€', 'Contemporary hotel with Acropolis views from its rooftop restaurant', 'Rooftop Restaurant, Bar, Free WiFi, Airport Shuttle, Meeting Rooms', 'hotels/athens_gate.jpg', '37.96894100', '23.72990800', 'https://www.athensgate.gr', '+30 21 0923 8302', '2025-03-26 15:17:11', '2025-03-26 15:17:11'),
(9, 5, 'Katikies Hotel', 'Oia, Santorini 847 02, Greece', '4.9', '€€€€€', 'Luxury clifftop hotel with infinity pools and stunning caldera views', 'Multiple Infinity Pools, Fine Dining Restaurant, Spa Services, Concierge, Airport Transfers', 'hotels/katikies.jpg', '36.46220800', '25.37554600', 'https://www.katikies.com', '+30 2286 071401', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(10, 5, 'Astra Suites', 'Imerovigli, Santorini 847 00, Greece', '4.8', '€€€€', 'All-suite hotel perched on the caldera cliff with panoramic views', 'Infinity Pool, Restaurant, Bar, Spa Services, Free WiFi, Airport Transfers', 'hotels/astra_suites.jpg', '36.43155100', '25.42754700', 'https://www.astrasuites.com', '+30 2286 024763', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(11, 6, 'The Savoy', 'Strand, London WC2R 0EZ, United Kingdom', '4.8', '€€€€€', 'Iconic luxury hotel on the River Thames with views of the London Eye', 'Multiple Restaurants, Bars, Spa, Indoor Pool, Fitness Center, Butler Service, Afternoon Tea', 'hotels/the_savoy.jpg', '51.51053400', '-0.12053400', 'https://www.thesavoylondon.com', '+44 20 7836 4343', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(12, 6, 'Park Plaza Westminster Bridge', 'Westminster Bridge Rd, London SE1 7UT, UK', '4.4', '€€€€', 'Modern hotel with direct views of Westminster and the London Eye', 'Multiple Restaurants, Bar, Spa, Indoor Pool, Fitness Center, Free WiFi', 'hotels/park_plaza.jpg', '51.50097500', '-0.11691700', 'https://www.parkplaza.com/westminster', '+44 20 7620 7282', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(13, 7, 'Hotel Müller', 'Alpseestraße 16, 87645 Hohenschwangau, Germany', '4.6', '€€€€', 'Family-run hotel with castle views and traditional Bavarian charm', 'Restaurant, Bar, Spa, Free WiFi, Terrace, Castle Views, Free Parking', 'hotels/hotel_muller.jpg', '47.55750300', '10.73877600', 'https://www.hotel-mueller.de', '+49 8362 93050', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(14, 7, 'Villa Ludwig Suite Hotel', 'Colomanstraße 20, 87645 Schwangau, Germany', '4.7', '€€€€', 'Boutique suite hotel with panoramic views of the castle and mountains', 'Spa, Sauna, Free Breakfast, Free WiFi, Terrace, Mountain Views', 'hotels/villa_ludwig.jpg', '47.55705600', '10.73670800', 'https://www.villa-ludwig.de', '+49 8362 9304040', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(15, 8, 'The Gritti Palace', 'Campo Santa Maria del Giglio, 30124 Venice, Italy', '4.9', '€€€€€', 'Historic luxury hotel on the Grand Canal with breathtaking views', 'Fine Dining Restaurant, Bar, Spa, Fitness Center, Private Boat Dock, Concierge', 'hotels/gritti_palace.jpg', '45.43125100', '12.33286900', 'https://www.thegrittipalace.com', '+39 041 794611', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(16, 8, 'Hotel Rialto', 'Riva del Ferro, 5149, 30124 Venice, Italy', '4.3', '€€€€', 'Historic hotel located next to the famous Rialto Bridge', 'Restaurant, Bar, Free WiFi, Concierge, Canal Views, Water Taxi Service', 'hotels/hotel_rialto.jpg', '45.43793900', '12.33567400', 'https://www.rialtohotel.com', '+39 041 5209166', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(17, 9, 'Brickyard Retreat at Mutianyu Great Wall', 'Beigou Village, Huairou District, Beijing, China', '4.7', '€€€€', 'Boutique retreat with direct views of the Great Wall', 'Restaurant, Spa Services, Free Breakfast, Free WiFi, Terrace, Great Wall Views', 'hotels/brickyard_retreat.jpg', '40.43083500', '116.55756600', 'https://www.brickyardatmutianyu.com', '+86 10 6162 6506', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(18, 9, 'Commune by the Great Wall', 'Shuiguan Great Wall, Badaling, Beijing, China', '4.5', '€€€€', 'Architectural marvel nestled in the valleys near the Great Wall', 'Multiple Restaurants, Bar, Spa, Indoor Pool, Fitness Center, Great Wall Access', 'hotels/commune_wall.jpg', '40.32657300', '116.02148300', 'https://www.communebythegreatwall.com', '+86 10 8118 1888', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(19, 10, 'The Oberoi Amarvilas', 'Taj East Gate Road, Agra 282001, India', '4.9', '€€€€€', 'Luxury hotel with every room offering uninterrupted views of the Taj Mahal', 'Multiple Restaurants, Bar, Spa, Outdoor Pool, Fitness Center, Taj Mahal Views', 'hotels/oberoi_amarvilas.jpg', '27.16853600', '78.04260700', 'https://www.oberoihotels.com/amarvilas-agra', '+91 562 223 1515', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(20, 10, 'Radisson Hotel Agra', 'Taj East Gate Road, Agra 282001, India', '4.2', '€€€', 'Contemporary hotel with rooftop pool and partial Taj Mahal views', 'Restaurant, Bar, Outdoor Pool, Fitness Center, Free WiFi, Meeting Rooms', 'hotels/radisson_agra.jpg', '27.16640000', '78.04150000', 'https://www.radissonhotels.com/agra', '+91 562 233 4400', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(21, 11, 'Raffles Grand Hotel d\'Angkor', '1 Vithei Charles de Gaulle, Siem Reap, Cambodia', '4.8', '€€€€€', 'Historic luxury hotel set amidst lush gardens, close to Angkor Wat', 'Multiple Restaurants, Bar, Outdoor Pool, Spa, Fitness Center, Tennis Courts, Free WiFi', 'hotels/raffles_angkor.jpg', '13.36566800', '103.85969300', 'https://www.raffles.com/siem-reap', '+855 23 982 598', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(22, 11, 'Park Hyatt Siem Reap', 'Sivutha Blvd, Siem Reap, Cambodia', '4.7', '€€€€', 'Luxury hotel blending Khmer architecture with contemporary design', 'Multiple Restaurants, Bar, Two Swimming Pools, Spa, Fitness Center, Free WiFi', 'hotels/park_hyatt_siemreap.jpg', '13.35473400', '103.85453100', 'https://www.hyatt.com/siemreap', '+855 63 211 234', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(23, 12, 'Hoshinoya Fuji', '1408 Oishi, Fujikawaguchiko, Yamanashi, Japan', '4.8', '€€€€€', 'Japan\'s first luxury glamping resort with panoramic views of Mt. Fuji and Lake Kawaguchi', 'Private Cabins, Restaurant, Bar, Outdoor Activities, Cloud Terrace, Forest Walks', 'hotels/hoshinoya_fuji.jpg', '35.49082500', '138.75583300', 'https://www.hoshinoya.com/fuji', '+81 570 073 066', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(24, 13, 'Four Seasons Resort Bali at Sayan', 'Sayan, Ubud, Bali 80571, Indonesia', '4.9', '€€€€€', 'Luxury resort nestled in a lush river valley with private villas', 'Spa, Multiple Restaurants, Infinity Pool, Yoga Classes, River Rafting, Cultural Activities', 'hotels/four_seasons_bali.jpg', '-8.50233000', '115.23778200', 'https://www.fourseasons.com/sayan', '+62 361 977577', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(25, 13, 'Potato Head Beach Club & Studios', 'Jl. Petitenget No.51B, Seminyak, Bali 80361, Indonesia', '4.7', '€€€€', 'Hip beachfront resort featuring modern design and sustainability', 'Beach Club, Multiple Restaurants, Infinity Pool, Spa, Fitness Center, Sustainable Programs', 'hotels/potato_head_bali.jpg', '-8.67807100', '115.15130400', 'https://www.potatohead.co/bali', '+62 361 4737979', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(26, 14, 'Marina Bay Sands', '10 Bayfront Avenue, Singapore 018956', '4.8', '€€€€€', 'Iconic integrated resort with the world\'s largest rooftop infinity pool', 'Rooftop Infinity Pool, Multiple Restaurants, Casino, Shopping Mall, Museum, Theaters, Fitness Center', 'hotels/marina_bay_sands.jpg', '1.28369500', '103.85990400', 'https://www.marinabaysands.com', '+65 6688 8888', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(27, 14, 'Raffles Singapore', '1 Beach Road, Singapore 189673', '4.9', '€€€€€', 'Historic luxury hotel known for its colonial architecture and Singapore Sling cocktail', 'Multiple Restaurants, Bar, Spa, Outdoor Pool, Butler Service, Afternoon Tea', 'hotels/raffles_singapore.jpg', '1.29484700', '103.85411400', 'https://www.raffles.com/singapore', '+65 6337 1886', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(28, 15, 'El Tovar Hotel', 'Grand Canyon Village, AZ 86023, USA', '4.6', '€€€€', 'Historic lodge located directly on the South Rim of the Grand Canyon', 'Restaurant, Bar, Gift Shop, Free WiFi, Concierge, Canyon Views', 'hotels/el_tovar.jpg', '36.05748700', '-112.13840500', 'https://www.grandcanyonlodges.com/el-tovar', '+1 928-638-2631', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(29, 15, 'The Grand Hotel at the Grand Canyon', 'Highway 64, Tusayan, AZ 86023, USA', '4.2', '€€€€', 'Rustic-elegant hotel just one mile from the South Rim entrance', 'Restaurant, Bar, Indoor Pool, Hot Tub, Fitness Center, Free WiFi', 'hotels/grand_hotel_canyon.jpg', '35.97280000', '-112.12930000', 'https://www.grandcanyongrandhotel.com', '+1 928-638-3333', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(30, 16, 'The Wagner at the Battery', '2 West Street, New York, NY 10004, USA', '4.7', '€€€€', 'Luxury hotel with stunning views of the Statue of Liberty and New York Harbor', 'Restaurant, Bar, Fitness Center, Concierge, Business Center, Liberty Views', 'hotels/wagner_battery.jpg', '40.70426500', '-74.01728500', 'https://www.thewagnerhotel.com', '+1 212-344-0800', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(31, 16, 'Conrad New York Downtown', '102 North End Avenue, New York, NY 10282, USA', '4.6', '€€€€', 'All-suite luxury hotel near Battery Park with views of the Hudson River', 'Restaurant, Bar, Fitness Center, Concierge, Business Center, Free WiFi', 'hotels/conrad_ny.jpg', '40.71434400', '-74.01589100', 'https://www.conradnewyork.com', '+1 212-945-0100', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(32, 17, 'Niagara Falls Marriott Fallsview Hotel & Spa', '6740 Fallsview Boulevard, Niagara Falls, ON L2G 3W6, Canada', '4.4', '€€€€', 'Hotel with panoramic views of Horseshoe Falls and American Falls', 'Restaurant, Bar, Spa, Indoor Pool, Fitness Center, Falls Views', 'hotels/marriott_fallsview.jpg', '43.07791300', '-79.07916700', 'https://www.marriott.com/niagara-falls', '+1 905-357-7300', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(33, 17, 'The Red Coach Inn', '2 Buffalo Avenue, Niagara Falls, NY 14303, USA', '4.5', '€€€', 'Historic Tudor-style inn overlooking the Upper Rapids of Niagara Falls', 'Restaurant, Free Breakfast, Free WiFi, Free Parking, Rapids Views', 'hotels/red_coach_inn.jpg', '43.08334100', '-79.06698500', 'https://www.redcoach.com', '+1 716-282-1459', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(34, 18, 'Fairmont Banff Springs', '405 Spray Avenue, Banff, AB T1L 1J4, Canada', '4.7', '€€€€€', 'Iconic \"Castle in the Rockies\" luxury hotel with mountain views', 'Multiple Restaurants, Bars, Spa, Indoor and Outdoor Pools, Golf Course, Ski Access', 'hotels/fairmont_banff.jpg', '51.16424700', '-115.56431200', 'https://www.fairmont.com/banff-springs', '+1 403-762-2211', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(35, 18, 'Moose Hotel & Suites', '345 Banff Avenue, Banff, AB T1L 1H8, Canada', '4.5', '€€€€', 'Contemporary mountain lodge with rooftop hot pools', 'Restaurant, Rooftop Hot Pools, Spa, Indoor Pool, Fitness Center, Mountain Views', 'hotels/moose_hotel.jpg', '51.17752300', '-115.57141500', 'https://www.moosehotelandsuites.com', '+1 403-760-8570', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(36, 19, 'The Lodge at Chichen Itza', 'Km 120 Carretera Merida-Cancun, Chichen Itza, Yucatan, Mexico', '4.6', '€€€€', 'Lodge located within walking distance of the ancient Mayan ruins', 'Restaurant, Bar, Outdoor Pool, Gardens, Free WiFi, Tour Desk, Early Ruins Access', 'hotels/lodge_chichenitza.jpg', '20.68277600', '-88.56864700', 'https://www.mayaland.com', '+52 985 851 0100', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(37, 19, 'Hotel Okaan', 'Km 12 Carretera Kantunil, Chichen Itza, Yucatan, Mexico', '4.4', '€€€', 'Eco-friendly hotel with traditional Mayan bungalows', 'Restaurant, Outdoor Pool, Free WiFi, Tour Desk, Garden, Mayan-style Accommodations', 'hotels/hotel_okaan.jpg', '20.69254400', '-88.59012100', 'https://www.hotelokaan.com', '+52 999 193 0350', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(38, 20, 'Belmond Sanctuary Lodge', 'Machu Picchu, Aguas Calientes, Peru', '4.8', '€€€€€', 'The only hotel located at the entrance to Machu Picchu', 'Restaurant, Bar, Spa Services, Gardens, Guided Tours, Mountain Views', 'hotels/belmond_sanctuary.jpg', '-13.16369600', '-72.54566900', 'https://www.belmond.com/sanctuary-lodge', '+51 84 211 038', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(39, 20, 'Inkaterra Machu Picchu Pueblo Hotel', 'Machu Picchu Pueblo, Aguas Calientes, Peru', '4.7', '€€€€', 'Eco-friendly hotel set in a cloud forest below Machu Picchu', 'Restaurant, Bar, Spa, Nature Trails, Bird Watching, Orchid Garden', 'hotels/inkaterra_machu.jpg', '-13.15532800', '-72.52507300', 'https://www.inkaterra.com/machu-picchu', '+51 1 610 0400', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(40, 21, 'Belmond Copacabana Palace', 'Avenida Atlântica 1702, Rio de Janeiro, Brazil', '4.9', '€€€€€', 'Iconic beachfront hotel with views of Copacabana Beach and Christ the Redeemer', 'Multiple Restaurants, Bar, Outdoor Pool, Spa, Fitness Center, Beach Service', 'hotels/copacabana_palace.jpg', '-22.96700400', '-43.17986900', 'https://www.belmond.com/copacabana-palace', '+55 21 2548 7070', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(41, 21, 'Hotel Santa Teresa Rio MGallery', 'Rua Almirante Alexandrino 660, Rio de Janeiro, Brazil', '4.6', '€€€€', 'Boutique hotel in the historic Santa Teresa district with views of the city', 'Restaurant, Bar, Outdoor Pool, Spa, Free WiFi, City Views', 'hotels/santa_teresa_rio.jpg', '-22.91553200', '-43.18774300', 'https://www.mgallery.com/santateresa', '+55 21 3380 0200', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(42, 22, 'Palacio de Sal', 'Orillas Salar de Uyuni, Uyuni, Bolivia', '4.3', '€€€', 'Hotel constructed entirely with salt blocks from the Salar de Uyuni', 'Restaurant, Bar, Game Room, Gift Shop, Salt Spa, Tour Desk', 'hotels/palacio_de_sal.jpg', '-20.32508100', '-66.97070200', 'https://www.palaciodesal.com', '+591 2 6226100', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(43, 22, 'Luna Salada Hotel', 'Orillas Salar de Uyuni, Uyuni, Bolivia', '4.2', '€€€', 'Salt hotel with panoramic views of the Uyuni Salt Flats', 'Restaurant, Bar, Spa, Tour Desk, Salt Flats Views', 'hotels/luna_salada.jpg', '-20.32338000', '-66.96881600', 'https://www.lunasaladahotel.com', '+591 2 6226410', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(44, 23, 'Marriott Mena House Cairo', 'Pyramids Road, Giza, Egypt', '4.8', '€€€€', 'Historic hotel with direct views of the Great Pyramids and lush gardens', 'Multiple Restaurants, Bar, Outdoor Pool, Spa, Fitness Center, Pyramid Views', 'hotels/mena_house.jpg', '29.98546100', '31.12968400', 'https://www.marriott.com/menahouse', '+20 2 33773222', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(45, 23, 'Steigenberger Pyramids Cairo', 'Alexandria Desert Road, Giza, Egypt', '4.5', '€€€', 'Modern hotel with views of the Pyramids and the Sphinx', 'Multiple Restaurants, Bar, Outdoor Pool, Spa, Fitness Center, Free WiFi', 'hotels/steigenberger_pyramids.jpg', '29.99088200', '31.13577500', 'https://www.steigenberger.com/pyramids', '+20 2 33772555', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(46, 24, 'The Victoria Falls Hotel', '1 Mallet Drive, Victoria Falls, Zimbabwe', '4.7', '€€€€', 'Historic colonial-style hotel with views of the Victoria Falls Bridge', 'Multiple Restaurants, Bar, Outdoor Pool, Gardens, Afternoon Tea, Falls Views', 'hotels/victoria_falls_hotel.jpg', '-17.93147100', '25.83075600', 'https://www.victoriasfallshotel.com', '+263 83 2844751', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(47, 24, 'Royal Livingstone Hotel', 'Mosi-oa-Tunya Road, Livingstone, Zambia', '4.8', '€€€€€', 'Luxury hotel on the banks of the Zambezi River with walking access to Victoria Falls', 'Restaurant, Bar, Outdoor Pool, Spa, Butler Service, River Views, Falls Access', 'hotels/royal_livingstone.jpg', '-17.92449700', '25.85669700', 'https://www.anantara.com/royal-livingstone', '+260 21 3321122', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(48, 25, 'Four Seasons Safari Lodge Serengeti', 'Central Serengeti, Tanzania', '4.9', '€€€€€', 'Luxury safari lodge with elevated rooms overlooking a watering hole', 'Restaurant, Bar, Infinity Pool, Spa, Game Drives, Walking Safaris, Wildlife Viewing', 'hotels/four_seasons_serengeti.jpg', '-2.39845600', '34.82631600', 'https://www.fourseasons.com/serengeti', '+255 768 981 981', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(49, 25, 'andBeyond Serengeti Under Canvas', 'Serengeti National Park, Tanzania', '4.8', '€€€€€', 'Mobile luxury tented camp that follows the Great Migration', 'Fine Dining, Bar, Game Drives, Bush Dinners, Star Gazing, Migration Views', 'hotels/andbeyond_serengeti.jpg', '-2.32553000', '34.83421000', 'https://www.andbeyond.com/serengeti-under-canvas', '+27 11 809 4300', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(50, 26, 'Park Hyatt Sydney', '7 Hickson Road, The Rocks, Sydney, Australia', '4.9', '€€€€€', 'Luxury harbourfront hotel with stunning views of the Sydney Opera House', 'Restaurant, Bar, Rooftop Pool, Spa, Fitness Center, Opera House Views', 'hotels/park_hyatt_sydney.jpg', '-33.85656200', '151.20975200', 'https://www.hyatt.com/park-hyatt-sydney', '+61 2 9256 1234', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(51, 26, 'Four Seasons Hotel Sydney', '199 George Street, Sydney, Australia', '4.7', '€€€€', 'Sophisticated hotel with panoramic views of Sydney Harbour', 'Restaurant, Bar, Outdoor Pool, Spa, Fitness Center, Harbour Views', 'hotels/four_seasons_sydney.jpg', '-33.86175100', '151.20933500', 'https://www.fourseasons.com/sydney', '+61 2 9250 3100', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(52, 27, 'Lizard Island Resort', 'Lizard Island, Great Barrier Reef, Queensland, Australia', '4.9', '€€€€€', 'Exclusive island resort with direct access to the Great Barrier Reef', 'Restaurant, Bar, Spa, Beach Access, Snorkeling, Diving, Reef Tours', 'hotels/lizard_island.jpg', '-14.66745300', '145.45354800', 'https://www.lizardisland.com.au', '+61 3 9426 7550', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(53, 27, 'Qualia', 'Hamilton Island, Whitsundays, Queensland, Australia', '4.9', '€€€€€', 'Luxury resort on Hamilton Island with Great Barrier Reef views', 'Multiple Restaurants, Bar, Infinity Pools, Spa, Private Beach, Reef Tours', 'hotels/qualia.jpg', '-20.35669600', '148.95706300', 'https://www.qualia.com.au', '+61 1300 780 959', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(54, 28, 'Milford Sound Lodge', 'State Highway 94, Milford Sound, New Zealand', '4.6', '€€€€', 'The only accommodation option at Milford Sound with river and mountain views', 'Restaurant, Bar, Free WiFi, Tour Desk, Hiking Trails, Fiord Views', 'hotels/milford_sound_lodge.jpg', '-44.66872500', '167.92648600', 'https://www.milfordlodge.com', '+64 3 249 8071', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(55, 28, 'Fiordland Lodge', 'Te Anau-Milford Highway, Te Anau, New Zealand', '4.7', '€€€€', 'Luxury lodge near Te Anau with views of Lake Te Anau and mountains', 'Restaurant, Bar, Lounge, Tour Desk, Lake Views, Helicopter Tours', 'hotels/fiordland_lodge.jpg', '-45.41694600', '167.71862800', 'https://www.fiordlandlodge.co.nz', '+64 3 249 7832', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(56, 29, 'Four Seasons Resort Bora Bora', 'Motu Tehotu, Bora Bora, French Polynesia', '4.9', '€€€€€', 'Luxury resort with overwater bungalows and Mount Otemanu views', 'Multiple Restaurants, Bar, Infinity Pool, Spa, Private Beaches, Snorkeling, Diving', 'hotels/four_seasons_borabora.jpg', '-16.47222500', '-151.69055000', 'https://www.fourseasons.com/borabora', '+689 40 603 130', '2025-03-26 15:17:12', '2025-03-26 15:17:12'),
(57, 29, 'The St. Regis Bora Bora Resort', 'Motu Ome\'e, Bora Bora, French Polynesia', '4.9', '€€€€€', 'Expansive luxury resort with the largest overwater villas in the South Pacific', 'Multiple Restaurants, Bar, Outdoor Pool, Spa, Private Lagoon, Water Sports', 'hotels/st_regis_borabora.jpg', '-16.50111200', '-151.71722400', 'https://www.marriott.com/st-regis-bora-bora', '+689 40 607 888', '2025-03-26 15:17:12', '2025-03-26 15:17:12');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `review_type` enum('destination','hotel','attraction') NOT NULL,
  `reference_id` int(11) NOT NULL,
  `rating` decimal(2,1) NOT NULL,
  `review_text` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `user_id`, `review_type`, `reference_id`, `rating`, `review_text`, `created_at`, `updated_at`) VALUES
(1, 1, 'destination', 1, '4.5', 'Paris is truly magical! The architecture, food, and culture exceeded my expectations. Walking along the Seine at sunset was unforgettable. Only downside was the crowds at major attractions.', '2024-09-15 11:30:22', '2025-03-26 15:35:21'),
(2, 2, 'destination', 5, '5.0', 'Santorini is absolute paradise! The white buildings against the blue sea created picture-perfect views everywhere we looked. Watching the sunset in Oia was a life-changing experience.', '2024-10-22 15:45:33', '2025-03-26 15:35:21'),
(3, 3, 'destination', 20, '4.8', 'Machu Picchu was breathtaking! The ancient ruins perched on the mountaintop with clouds floating by created an almost mystical experience. The hike was challenging but entirely worth it.', '2024-08-30 06:15:42', '2025-03-26 15:35:21'),
(4, 4, 'destination', 25, '5.0', 'The Serengeti exceeded all expectations! Witnessing the Great Migration was awe-inspiring. We saw all of the Big Five animals and our guide was incredibly knowledgeable about wildlife.', '2024-07-12 13:20:18', '2025-03-26 15:35:21'),
(5, 5, 'destination', 15, '4.7', 'The Grand Canyon is even more impressive in person than in photos. The vastness and colors are simply stunning. Great family destination with activities for all ages.', '2024-11-05 09:30:55', '2025-03-26 15:35:21'),
(6, 6, 'destination', 28, '4.9', 'Milford Sound\'s beauty is otherworldly. The fjords, waterfalls, and mountains create perfect photo opportunities at every turn. Try to visit on a rainy day - the waterfalls multiply!', '2024-06-18 12:10:25', '2025-03-26 15:35:21'),
(7, 7, 'destination', 13, '4.6', 'Bali offered the perfect balance of relaxation, culture, and adventure. The temples, rice terraces, and beaches are all stunning. The local people were incredibly welcoming.', '2024-10-10 09:35:40', '2025-03-26 15:35:21'),
(8, 8, 'destination', 1, '4.8', 'Paris truly is the city of love! Every street feels romantic and charming. The food was amazing and even ordinary moments felt special with the beautiful architecture everywhere.', '2024-07-25 16:22:15', '2025-03-26 15:35:21'),
(9, 1, 'hotel', 1, '4.7', 'Le Meurice exceeded our expectations. The service was impeccable, the room was luxurious with an amazing view of the Tuileries Garden, and the location couldn\'t be more perfect for exploring Paris.', '2024-09-18 07:15:30', '2025-03-26 15:35:21'),
(10, 2, 'hotel', 9, '5.0', 'Katikies Hotel in Santorini is absolute perfection! Our suite had a private terrace with infinity pool overlooking the caldera. The staff anticipated our every need and the breakfast was incredible.', '2024-10-25 06:30:45', '2025-03-26 15:35:21'),
(11, 3, 'hotel', 39, '4.5', 'Inkaterra Machu Picchu Pueblo Hotel was a wonderful retreat after hiking. The rooms are spread throughout a cloud forest with beautiful vegetation. The guided nature walks were excellent.', '2024-09-02 14:22:18', '2025-03-26 15:35:21'),
(12, 4, 'hotel', 49, '4.9', 'Four Seasons Safari Lodge provided luxury in the heart of the wilderness. Watching elephants at the watering hole from our room was surreal. The guides were exceptional and the food was outstanding.', '2024-07-15 11:40:22', '2025-03-26 15:35:21'),
(13, 5, 'hotel', 29, '4.3', 'The Grand Hotel at the Grand Canyon offered comfortable rooms with rustic charm. Great location for accessing the park, though it gets quite busy during peak times. Solid restaurant options on-site.', '2024-11-08 16:25:15', '2025-03-26 15:35:21'),
(14, 6, 'hotel', 55, '4.8', 'Milford Sound Lodge\'s location cannot be beat - you\'re right in the heart of the stunning landscape. The chalets were comfortable and well-equipped, with huge windows showcasing the mountains.', '2024-06-21 05:15:33', '2025-03-26 15:35:21'),
(15, 7, 'hotel', 25, '4.6', 'Four Seasons Resort Bali offered an exceptional experience. The villa with private pool was beautiful, staff were attentive without being intrusive, and the property gardens were immaculate.', '2024-10-13 13:30:42', '2025-03-26 15:35:21'),
(16, 8, 'hotel', 1, '5.0', 'Le Meurice made our honeymoon truly special! The room was upgraded to a suite with Eiffel Tower views, the concierge arranged perfect dinner reservations, and the hotel itself is a work of art.', '2024-07-28 17:15:18', '2025-03-26 15:35:21'),
(17, 1, 'attraction', 1, '4.6', 'The Louvre is overwhelming in the best possible way. Plan multiple visits if you can - seeing the Mona Lisa was special but there are countless other treasures to discover in quieter sections.', '2024-09-20 10:45:22', '2025-03-26 15:35:21'),
(18, 2, 'attraction', 5, '4.9', 'Oia Sunset Point offers the most magical sunset views I\'ve ever experienced. Get there early to secure a good spot, and stay after the sun sets to see the lights come on across the caldera.', '2024-10-27 17:10:33', '2025-03-26 15:35:21'),
(19, 3, 'attraction', 20, '4.7', 'The Sacred Valley was a highlight of our Peru trip. The terraced landscapes are stunning and the traditional markets offer authentic crafts. Our guide shared fascinating Incan history throughout.', '2024-09-05 08:30:18', '2025-03-26 15:35:21'),
(20, 4, 'attraction', 16, '4.8', 'Great Migration Viewing was the wildlife experience of a lifetime! Seeing thousands of wildebeest crossing the river with crocodiles waiting was both terrifying and amazing. Worth every penny.', '2024-07-18 12:55:42', '2025-03-26 15:35:21'),
(21, 5, 'attraction', 15, '4.4', 'The Grand Canyon Skywalk offers unique views, though it\'s quite expensive for what it is. The glass floor experience is thrilling, but prepare for crowds and strict rules about photography.', '2024-11-10 10:20:15', '2025-03-26 15:35:21'),
(22, 6, 'attraction', 22, '5.0', 'Mitre Peak is even more impressive in person than in photos. The way it rises dramatically from the water creates perfect compositions for photography, especially on clear days with reflections.', '2024-06-23 04:45:33', '2025-03-26 15:35:21'),
(23, 7, 'attraction', 13, '4.5', 'Ubud Monkey Forest was a fun experience, though the monkeys can be quite bold! The forest itself is beautiful and peaceful, with ancient temples adding cultural interest to the natural setting.', '2024-10-15 07:25:42', '2025-03-26 15:35:21'),
(24, 8, 'attraction', 1, '4.8', 'The Louvre deserves its reputation as one of the world\'s greatest museums. Beyond the famous works, we loved discovering the Egyptian antiquities and Napoleon\'s apartments. Audio guide was excellent.', '2024-07-30 11:10:18', '2025-03-26 15:35:21');

-- --------------------------------------------------------

--
-- Table structure for table `tripdestinations`
--

CREATE TABLE `tripdestinations` (
  `trip_destination_id` int(11) NOT NULL,
  `trip_id` int(11) DEFAULT NULL,
  `destination_id` int(11) DEFAULT NULL,
  `arrival_date` date DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tripdestinations`
--

INSERT INTO `tripdestinations` (`trip_destination_id`, `trip_id`, `destination_id`, `arrival_date`, `departure_date`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-06-10', '2025-06-14', 'Staying near the Eiffel Tower. Want to visit Louvre and take a Seine river cruise.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(2, 1, 2, '2025-06-14', '2025-06-19', 'Interested in ancient history and Italian cuisine. Book a Colosseum night tour.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(3, 1, 3, '2025-06-19', '2025-06-24', 'Must see Sagrada Familia and Park Güell. Try local tapas.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(4, 2, 12, '2025-09-05', '2025-09-10', 'Hope to see Mt. Fuji and explore Tokyo. Try authentic sushi.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(5, 2, 13, '2025-09-10', '2025-09-15', 'Book a private tour of temples in Ubud. Interested in local cooking class.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(6, 2, 14, '2025-09-15', '2025-09-20', 'Visit Gardens by the Bay and Marina Bay Sands. Try hawker center food.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(7, 3, 29, '2025-12-15', '2025-12-22', 'Overwater bungalow booked. Schedule snorkeling trip and romantic dinner on the beach.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(8, 4, 4, '2025-07-12', '2025-07-16', 'Visit the Acropolis and try authentic Greek food at local tavernas.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(9, 4, 5, '2025-07-16', '2025-07-21', 'Watch sunset in Oia. Book a caldera cruise and wine tasting.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(10, 4, 8, '2025-07-21', '2025-07-26', 'Gondola ride and visit St. Mark\'s Basilica. Try authentic cicchetti.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(11, 5, 16, '2025-05-05', '2025-05-08', 'Meetings in Midtown. Evening free for Empire State Building visit and Broadway show.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(12, 6, 21, '2025-08-01', '2025-08-09', 'Hostel booked in Copacabana. Visit Christ the Redeemer and try caipirinha.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(13, 6, 20, '2025-08-09', '2025-08-18', 'Hike Machu Picchu with guided tour. Try local Peruvian cuisine.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(14, 6, 22, '2025-08-18', '2025-08-28', 'Book 3-day salt flats tour. Bring proper gear for cold nights.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(15, 7, 17, '2025-11-10', '2025-11-12', 'Book Maid of the Mist tour and romantic dinner overlooking the falls.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(16, 8, 25, '2025-06-15', '2025-06-25', 'Luxury safari lodge booked. Early morning game drives to see the Big Five.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(17, 9, 10, '2025-10-02', '2025-10-09', 'Sunrise visit to Taj Mahal. Visit Agra Fort and local markets.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(18, 9, 11, '2025-10-09', '2025-10-17', 'Full day tour of Angkor Wat temples. Try local Khmer cuisine.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(19, 10, 15, '2025-07-05', '2025-07-10', 'South Rim visit with ranger-led programs for kids. Book Grand Canyon Skywalk.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(20, 10, 19, '2025-07-10', '2025-07-15', 'Guided tour of ruins and swimming in cenote. Kid-friendly accommodations.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(21, 11, 18, '2025-01-15', '2025-01-22', 'Ski lessons booked for beginners. Visit Lake Louise and try ice skating.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(22, 12, 28, '2025-05-20', '2025-05-28', 'Scenic cruise booked. Hiking trails for best photography spots identified.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(23, 12, 27, '2025-05-28', '2025-06-05', 'Snorkeling tour of reef. Helicopter tour for aerial shots.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(24, 13, 23, '2025-11-10', '2025-11-24', 'Private guide booked for Pyramids and Sphinx. Visit Egyptian Museum.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(25, 14, 13, '2025-09-10', '2025-09-25', 'Yoga retreat in Ubud booked. Rice terrace hike and temple visits planned.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(26, 15, 14, '2025-03-15', '2025-03-20', 'Conference at Marina Bay Sands. Evening free for Gardens by the Bay light show.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(27, 16, 5, '2025-06-01', '2025-06-08', 'Luxury villa with private pool. Sunset cruise and wine tasting booked.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(28, 16, 1, '2025-06-08', '2025-06-15', 'Romantic hotel near Seine. Dinner at Eiffel Tower restaurant.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(29, 17, 6, '2025-10-05', '2025-10-08', 'Hotel near Oxford Street. Book afternoon tea and London Eye tickets.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(30, 18, 1, '2025-04-10', '2025-04-17', 'Luxury hotel in Latin Quarter. Visit all major museums and take day trip to Versailles.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(31, 18, 7, '2025-04-17', '2025-04-24', 'Visit Neuschwanstein Castle and explore Bavarian countryside.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(32, 18, 2, '2025-04-24', '2025-05-01', 'Book guided tour of Ancient Rome. Try authentic pasta making class.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(33, 18, 4, '2025-05-01', '2025-05-10', 'Visit Acropolis and take day trip to nearby islands.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(34, 19, 15, '2025-08-01', '2025-08-10', 'Family-friendly lodge. Junior Ranger program for kids and age-appropriate hikes.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(35, 20, 12, '2025-07-15', '2025-07-22', 'Traditional ryokan experience. Tea ceremony and sushi making class booked.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(36, 20, 9, '2025-07-22', '2025-07-29', 'Visit Great Wall and Forbidden City. Try authentic Peking duck.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(37, 20, 11, '2025-07-29', '2025-08-05', 'Sunrise tour of Angkor Wat. Cambodian cooking class booked.', '2025-03-26 15:28:51', '2025-03-26 15:28:51'),
(38, 21, 8, '2025-05-22', '2025-05-25', 'Boutique hotel on canal. Book opera tickets and gondola ride.', '2025-03-26 15:28:51', '2025-03-26 15:28:51');

-- --------------------------------------------------------

--
-- Table structure for table `tripflights`
--

CREATE TABLE `tripflights` (
  `trip_flight_id` int(11) NOT NULL,
  `trip_id` int(11) DEFAULT NULL,
  `flight_id` int(11) DEFAULT NULL,
  `booking_reference` varchar(100) DEFAULT NULL,
  `booking_status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tripflights`
--

INSERT INTO `tripflights` (`trip_flight_id`, `trip_id`, `flight_id`, `booking_reference`, `booking_status`, `created_at`, `updated_at`) VALUES
(33, 1, 4, 'AF1232-JD125', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(34, 1, 8, 'IB3445-JD126', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(35, 2, 13, 'AC933-JD230', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(36, 2, 16, 'MH783-JD231', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(37, 2, 11, 'SQ321-JD232', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(38, 3, 41, 'QR701-JD301', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(39, 1, 1, 'A31450-JD401', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(40, 4, 9, 'AZ611-JD402', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(41, 5, 40, 'BA172-JD501', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(42, 6, 31, 'LA932-MS601', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(43, 6, 32, 'AV521-MS602', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(44, 7, 6, 'AC865-MS701', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(45, 8, 36, 'ET506-SJ801', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(46, 9, 17, 'EK342-SJ901', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(47, 9, 11, 'SQ321-SJ902', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(48, 10, 21, 'AA1532-DB101', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(49, 10, 28, 'AM489-DB102', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(50, 11, 24, 'WS652-DB111', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(51, 12, 46, 'NZ103-EW121', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(52, 12, 49, 'FJ910-EW122', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(53, 13, 37, 'MS843-EW131', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(54, 14, 16, 'MH783-AT141', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(55, 15, 11, 'SQ321-AT151', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(56, 16, 1, 'A31450-OL161', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(57, 16, 3, 'FR2451-OL162', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(58, 17, 5, 'BA484-OL171', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(59, 18, 7, 'LH1829-WT181', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(60, 18, 4, 'AF1232-WT182', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(61, 19, 21, 'AA1532-WT191', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(62, 20, 13, 'AC933-SM201', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(63, 20, 17, 'EK342-SM202', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35'),
(64, 21, 9, 'AZ611-SM211', 'Confirmed', '2025-03-26 15:31:35', '2025-03-26 15:31:35');

-- --------------------------------------------------------

--
-- Table structure for table `triphotels`
--

CREATE TABLE `triphotels` (
  `trip_hotel_id` int(11) NOT NULL,
  `trip_destination_id` int(11) DEFAULT NULL,
  `hotel_id` int(11) DEFAULT NULL,
  `check_in_date` date DEFAULT NULL,
  `check_out_date` date DEFAULT NULL,
  `room_type` varchar(50) DEFAULT NULL,
  `booking_reference` varchar(100) DEFAULT NULL,
  `booking_status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `triphotels`
--

INSERT INTO `triphotels` (`trip_hotel_id`, `trip_destination_id`, `hotel_id`, `check_in_date`, `check_out_date`, `room_type`, `booking_reference`, `booking_status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-06-10', '2025-06-14', 'Deluxe Double', 'LE2506-JD1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(2, 2, 3, '2025-06-14', '2025-06-19', 'Superior King', 'PM2506-JD2', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(3, 3, 5, '2025-06-19', '2025-06-24', 'Junior Suite', 'AR2506-JD3', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(4, 4, 23, '2025-09-05', '2025-09-10', 'Mountain View Room', 'KU2509-JD1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(5, 5, 25, '2025-09-10', '2025-09-15', 'Garden Villa', 'FS2509-JD2', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(6, 6, 27, '2025-09-15', '2025-09-20', 'Deluxe Room', 'MBS2509-JD3', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(7, 7, 57, '2025-12-15', '2025-12-22', 'Overwater Bungalow', 'FS2512-JD1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(8, 8, 7, '2025-07-12', '2025-07-16', 'Acropolis View Suite', 'GB2507-JD1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(9, 9, 9, '2025-07-16', '2025-07-21', 'Caldera View Suite', 'KT2507-JD2', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(10, 10, 15, '2025-07-21', '2025-07-26', 'Grand Canal Suite', 'GP2507-JD3', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(11, 11, 31, '2025-05-05', '2025-05-08', 'Business King', 'WB2505-JD1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(12, 12, 41, '2025-08-01', '2025-08-09', 'Ocean View Room', 'CP2508-MS1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(13, 13, 39, '2025-08-09', '2025-08-18', 'Mountain View Room', 'IT2508-MS2', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(14, 14, 43, '2025-08-18', '2025-08-28', 'Salt View Room', 'PS2508-MS3', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(15, 15, 33, '2025-11-10', '2025-11-12', 'Falls View Suite', 'MF2511-MS1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(16, 16, 49, '2025-06-15', '2025-06-25', 'Luxury Safari Tent', 'FS2506-SJ1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(17, 17, 19, '2025-10-02', '2025-10-09', 'Taj View Suite', 'OA2510-SJ1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(18, 18, 21, '2025-10-09', '2025-10-17', 'Garden Suite', 'RG2510-SJ2', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(19, 19, 30, '2025-07-05', '2025-07-10', 'Family Suite', 'ET2507-DB1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(20, 20, 37, '2025-07-10', '2025-07-15', 'Junior Suite', 'LC2507-DB2', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(21, 21, 35, '2025-01-15', '2025-01-22', 'Mountain View Suite', 'FB2501-DB1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(22, 22, 55, '2025-05-20', '2025-05-28', 'Premium Chalet', 'MS2505-EW1', 'Pending', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(23, 23, 53, '2025-05-28', '2025-06-05', 'Reef View Room', 'LI2505-EW2', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(24, 24, 45, '2025-11-10', '2025-11-24', 'Pyramid View Suite', 'MH2511-EW1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(25, 25, 25, '2025-09-10', '2025-09-25', 'Garden Villa', 'FS2509-AT1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(26, 26, 27, '2025-03-15', '2025-03-20', 'Club Room', 'MBS2503-AT1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(27, 27, 9, '2025-06-01', '2025-06-08', 'Honeymoon Suite', 'KT2506-OL1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(28, 28, 1, '2025-06-08', '2025-06-15', 'Eiffel Tower Suite', 'LM2506-OL2', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(29, 29, 11, '2025-10-05', '2025-10-08', 'Deluxe Twin', 'SV2510-OL1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(30, 30, 2, '2025-04-10', '2025-04-17', 'Executive Suite', 'PP2504-WT1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(31, 31, 13, '2025-04-17', '2025-04-24', 'Castle View Suite', 'HM2504-WT2', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(32, 32, 4, '2025-04-24', '2025-05-01', 'Deluxe Suite', 'CA2504-WT3', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(33, 33, 8, '2025-05-01', '2025-05-10', 'Acropolis View Room', 'AG2505-WT4', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(34, 34, 29, '2025-08-01', '2025-08-10', 'Family Suite', 'GH2508-WT1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(35, 35, 24, '2025-07-15', '2025-07-22', 'Traditional Room', 'HF2507-SM1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(36, 36, 17, '2025-07-22', '2025-07-29', 'Deluxe Room', 'BR2507-SM2', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(37, 37, 22, '2025-07-29', '2025-08-05', 'Garden Suite', 'PH2507-SM3', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59'),
(38, 38, 16, '2025-05-22', '2025-05-25', 'Canal View Room', 'HR2505-SM1', 'Confirmed', '2025-03-26 15:29:59', '2025-03-26 15:29:59');

-- --------------------------------------------------------

--
-- Table structure for table `trips`
--

CREATE TABLE `trips` (
  `trip_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `trip_name` varchar(100) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trips`
--

INSERT INTO `trips` (`trip_id`, `user_id`, `trip_name`, `start_date`, `end_date`, `description`, `is_public`, `created_at`, `updated_at`) VALUES
(1, 1, 'European Adventure', '2025-06-10', '2025-06-24', 'Two-week journey through Paris, Rome, and Barcelona with cultural highlights and local cuisine experiences.', 1, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(2, 1, 'Asian Exploration', '2025-09-05', '2025-09-20', 'Exploring temples, street food, and city life in Tokyo, Bangkok, and Singapore.', 0, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(3, 1, 'Winter Getaway', '2025-12-15', '2025-12-22', 'Relaxing beach vacation in Bora Bora to escape the winter cold.', 1, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(4, 2, 'Mediterranean Cruise', '2025-07-12', '2025-07-26', 'Sailing adventure starting in Athens, visiting Santorini, and ending in Venice.', 1, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(5, 2, 'Business Trip to NYC', '2025-05-05', '2025-05-08', 'Short business trip with some time to see the Statue of Liberty and Empire State Building.', 0, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(6, 3, 'Backpacking South America', '2025-08-01', '2025-08-28', 'Budget-friendly adventure through Rio de Janeiro, Machu Picchu, and Salar de Uyuni.', 1, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(7, 3, 'Anniversary Weekend', '2025-11-10', '2025-11-12', 'Romantic weekend at Niagara Falls to celebrate our anniversary.', 0, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(8, 4, 'Safari Adventure', '2025-06-15', '2025-06-25', 'Wildlife exploration in the Serengeti with guided tours and luxury accommodations.', 1, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(9, 4, 'Spiritual Journey', '2025-10-02', '2025-10-17', 'Visiting temples and historical sites in India and Cambodia, including Taj Mahal and Angkor Wat.', 1, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(10, 5, 'Family Vacation', '2025-07-05', '2025-07-15', 'Creating memories with the kids at the Grand Canyon and Chichen Itza.', 1, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(11, 5, 'Snow Adventure', '2025-01-15', '2025-01-22', 'Skiing and winter activities in Banff National Park.', 0, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(12, 6, 'Photography Tour', '2025-05-20', '2025-06-05', 'Capturing stunning landscapes in New Zealand\'s Milford Sound and Australia\'s Great Barrier Reef.', 1, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(13, 6, 'Historical Exploration', '2025-11-10', '2025-11-24', 'Discovering ancient wonders at the Pyramids of Giza and other historical sites.', 1, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(14, 7, 'Solo Adventure', '2025-09-10', '2025-09-25', 'Self-discovery journey through Bali with yoga retreats and cultural experiences.', 1, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(15, 7, 'Business Conference', '2025-03-15', '2025-03-20', 'Tech conference in Singapore with side trips to explore Marina Bay Sands and Gardens by the Bay.', 0, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(16, 8, 'Honeymoon', '2025-06-01', '2025-06-15', 'Romantic getaway in Santorini and Paris after our wedding.', 1, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(17, 8, 'Girls Weekend', '2025-10-05', '2025-10-08', 'Fun weekend with friends exploring London shopping and sightseeing.', 1, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(18, 9, 'Retirement Celebration', '2025-04-10', '2025-05-10', 'Month-long dream vacation through Europe celebrating retirement.', 1, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(19, 9, 'Grandkids Adventure', '2025-08-01', '2025-08-10', 'Taking the grandchildren to see the wonders at the Grand Canyon.', 0, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(20, 10, 'Cultural Immersion', '2025-07-15', '2025-08-05', 'Deep exploration of Asian cultures in Tokyo, Beijing, and Siem Reap.', 1, '2025-03-26 15:27:47', '2025-03-26 15:27:47'),
(21, 10, 'Weekend Escape', '2025-05-22', '2025-05-25', 'Quick getaway to Venice for art and relaxation.', 0, '2025-03-26 15:27:47', '2025-03-26 15:27:47');

-- --------------------------------------------------------

--
-- Table structure for table `userfavorites`
--

CREATE TABLE `userfavorites` (
  `favorite_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `destination_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `userfavorites`
--

INSERT INTO `userfavorites` (`favorite_id`, `user_id`, `destination_id`, `created_at`) VALUES
(1, 1, 1, '2025-03-26 15:32:11'),
(2, 1, 5, '2025-03-26 15:32:11'),
(3, 1, 13, '2025-03-26 15:32:11'),
(4, 1, 29, '2025-03-26 15:32:11'),
(5, 1, 16, '2025-03-26 15:32:11'),
(6, 2, 4, '2025-03-26 15:32:11'),
(7, 2, 5, '2025-03-26 15:32:11'),
(8, 2, 8, '2025-03-26 15:32:11'),
(9, 2, 27, '2025-03-26 15:32:11'),
(10, 2, 21, '2025-03-26 15:32:11'),
(11, 3, 20, '2025-03-26 15:32:11'),
(12, 3, 21, '2025-03-26 15:32:11'),
(13, 3, 22, '2025-03-26 15:32:11'),
(14, 3, 17, '2025-03-26 15:32:11'),
(15, 3, 15, '2025-03-26 15:32:11'),
(16, 4, 10, '2025-03-26 15:32:11'),
(17, 4, 11, '2025-03-26 15:32:11'),
(18, 4, 25, '2025-03-26 15:32:11'),
(19, 4, 4, '2025-03-26 15:32:11'),
(20, 4, 23, '2025-03-26 15:32:11'),
(21, 5, 15, '2025-03-26 15:32:11'),
(22, 5, 18, '2025-03-26 15:32:11'),
(23, 5, 19, '2025-03-26 15:32:11'),
(24, 5, 13, '2025-03-26 15:32:11'),
(25, 5, 12, '2025-03-26 15:32:11'),
(26, 6, 28, '2025-03-26 15:32:11'),
(27, 6, 27, '2025-03-26 15:32:11'),
(28, 6, 23, '2025-03-26 15:32:11'),
(29, 6, 8, '2025-03-26 15:32:11'),
(30, 6, 29, '2025-03-26 15:32:11'),
(31, 7, 13, '2025-03-26 15:32:11'),
(32, 7, 14, '2025-03-26 15:32:11'),
(33, 7, 12, '2025-03-26 15:32:11'),
(34, 7, 9, '2025-03-26 15:32:11'),
(35, 7, 27, '2025-03-26 15:32:11'),
(36, 8, 5, '2025-03-26 15:32:11'),
(37, 8, 1, '2025-03-26 15:32:11'),
(38, 8, 6, '2025-03-26 15:32:11'),
(39, 8, 29, '2025-03-26 15:32:11'),
(40, 8, 16, '2025-03-26 15:32:11'),
(41, 9, 1, '2025-03-26 15:32:11'),
(42, 9, 2, '2025-03-26 15:32:11'),
(43, 9, 4, '2025-03-26 15:32:11'),
(44, 9, 7, '2025-03-26 15:32:11'),
(45, 9, 15, '2025-03-26 15:32:11'),
(46, 10, 9, '2025-03-26 15:32:11'),
(47, 10, 11, '2025-03-26 15:32:11'),
(48, 10, 12, '2025-03-26 15:32:11'),
(49, 10, 8, '2025-03-26 15:32:11'),
(50, 10, 10, '2025-03-26 15:32:11');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `first_name`, `last_name`, `date_of_birth`, `profile_picture`, `created_at`, `updated_at`) VALUES
(1, 'johndoe', 'john.doe@example.com', '$2a$12$1234567890abcdefghijk.uvwxyz1234567890abcdefghijklmnopqrstuv', 'John', 'Doe', '1985-05-15', 'profiles/johndoe.jpg', '2025-03-26 15:09:05', '2025-03-26 15:09:05'),
(2, 'janedoe', 'jane.doe@example.com', '$2a$12$0987654321zyxwvutsrqp.onmlkjihgfedcba0987654321zyxwvutsrqp', 'Jane', 'Doe', '1990-08-22', 'profiles/janedoe.jpg', '2025-03-26 15:09:05', '2025-03-26 15:09:05'),
(3, 'mikesmith', 'mike.smith@example.com', '$2a$12$abcdef1234567890ghijk.lmnopq1234567890rstuvwxyzabcdefghij', 'Mike', 'Smith', '1982-12-10', 'profiles/mikesmith.jpg', '2025-03-26 15:09:05', '2025-03-26 15:09:05'),
(4, 'sarahjones', 'sarah.jones@example.com', '$2a$12$qponmlkjihgfedcba9876.54321zyxwvutsrqponmlkjihgfedcba98', 'Sarah', 'Jones', '1995-03-28', 'profiles/sarahjones.jpg', '2025-03-26 15:09:05', '2025-03-26 15:09:05'),
(5, 'davidbrown', 'david.brown@example.com', '$2a$12$abcdefghijklmnopqrstu.vwxyz1234567890abcdefghijklmnopqrs', 'David', 'Brown', '1988-07-04', 'profiles/davidbrown.jpg', '2025-03-26 15:09:05', '2025-03-26 15:09:05'),
(6, 'emmawilson', 'emma.wilson@example.com', '$2a$12$uvwxyz1234567890abcde.fghijklmnopqrstuvwxyz1234567890abc', 'Emma', 'Wilson', '1992-11-19', 'profiles/emmawilson.jpg', '2025-03-26 15:09:05', '2025-03-26 15:09:05'),
(7, 'alexthomas', 'alex.thomas@example.com', '$2a$12$defghijklmnopqrstuv12.34567890abcdefghijklmnopqrstuvwxyz', 'Alex', 'Thomas', '1980-02-14', 'profiles/alexthomas.jpg', '2025-03-26 15:09:05', '2025-03-26 15:09:05'),
(8, 'olivialee', 'olivia.lee@example.com', '$2a$12$pqrstuvwxyz1234567890.abcdefghijklmnopqrstuvwxyz123456789', 'Olivia', 'Lee', '1997-09-08', 'profiles/olivialee.jpg', '2025-03-26 15:09:05', '2025-03-26 15:09:05'),
(9, 'williamtaylor', 'william.taylor@example.com', '$2a$12$0abcdefghijklmnopqrst.uvwxyz1234567890abcdefghijklmnop', 'William', 'Taylor', '1975-06-30', 'profiles/williamtaylor.jpg', '2025-03-26 15:09:05', '2025-03-26 15:09:05'),
(10, 'sophiamiller', 'sophia.miller@example.com', '$2a$12$9876543210zyxwvutsrqp.onmlkjihgfedcba9876543210zyxwvut', 'Sophia', 'Miller', '1993-01-25', 'profiles/sophiamiller.jpg', '2025-03-26 15:09:05', '2025-03-26 15:09:05');

-- --------------------------------------------------------

--
-- Table structure for table `usersearchhistory`
--

CREATE TABLE `usersearchhistory` (
  `search_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `search_query` text DEFAULT NULL,
  `search_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `usersearchhistory`
--

INSERT INTO `usersearchhistory` (`search_id`, `user_id`, `search_query`, `search_timestamp`) VALUES
(1, 1, 'beaches in Santorini', '2025-02-10 07:15:22'),
(2, 1, 'Paris restaurants near Eiffel Tower', '2025-02-15 17:30:45'),
(3, 1, 'best time to visit Bali', '2025-02-20 12:22:18'),
(4, 1, 'overwater bungalows Bora Bora', '2025-03-05 19:12:33'),
(5, 1, 'cheap flights to Paris summer 2025', '2025-03-10 06:45:12'),
(6, 2, 'Santorini sunset views', '2025-02-12 14:18:42'),
(7, 2, 'Mediterranean cruise options', '2025-02-18 09:05:30'),
(8, 2, 'Athens historical sites', '2025-02-26 13:40:22'),
(9, 2, 'best Venice canal tours', '2025-03-08 15:55:14'),
(10, 2, 'business hotels in Manhattan', '2025-03-15 07:10:27'),
(11, 3, 'Machu Picchu hiking permits', '2025-02-05 05:30:18'),
(12, 3, 'backpacking South America budget', '2025-02-16 10:20:45'),
(13, 3, 'best time to visit Salt Flats Bolivia', '2025-02-24 12:35:22'),
(14, 3, 'romantic restaurants Niagara Falls', '2025-03-07 17:42:15'),
(15, 3, 'Rio de Janeiro carnival 2025 dates', '2025-03-18 09:05:33'),
(16, 4, 'Serengeti safari packages', '2025-02-08 08:12:44'),
(17, 4, 'best view of Taj Mahal', '2025-02-19 14:28:33'),
(18, 4, 'Angkor Wat photography tips', '2025-02-27 07:45:21'),
(19, 4, 'Egyptian pyramids tour guides', '2025-03-09 11:33:52'),
(20, 4, 'spiritual retreats in India', '2025-03-17 18:15:18'),
(21, 5, 'family activities Grand Canyon', '2025-02-03 13:25:18'),
(22, 5, 'kid-friendly hotels Chichen Itza', '2025-02-21 16:12:43'),
(23, 5, 'Banff skiing lessons beginners', '2025-03-01 07:30:22'),
(24, 5, 'best time to visit Mount Fuji with family', '2025-03-11 12:20:35'),
(25, 5, 'vacation rentals Bali for families', '2025-03-16 14:40:12'),
(26, 6, 'best photography spots Milford Sound', '2025-02-07 06:15:23'),
(27, 6, 'Great Barrier Reef diving tours', '2025-02-17 09:42:38'),
(28, 6, 'sunrise at Pyramids of Giza', '2025-02-25 14:30:19'),
(29, 6, 'Venice carnival 2025 dates', '2025-03-06 17:22:45'),
(30, 6, 'Bora Bora aerial photography tours', '2025-03-14 10:18:33'),
(31, 7, 'Bali yoga retreats', '2025-02-09 05:30:42'),
(32, 7, 'Singapore business district hotels', '2025-02-22 07:25:18'),
(33, 7, 'Mount Fuji hiking trails', '2025-03-02 13:42:21'),
(34, 7, 'tech conferences Asia 2025', '2025-03-12 09:30:45'),
(35, 7, 'Great Wall of China less crowded sections', '2025-03-19 14:20:33'),
(36, 8, 'honeymoon packages Santorini', '2025-02-11 16:22:15'),
(37, 8, 'romantic restaurants Paris', '2025-02-23 18:15:42'),
(38, 8, 'London shopping districts', '2025-03-03 12:30:18'),
(39, 8, 'best Bora Bora resorts for couples', '2025-03-13 17:45:22'),
(40, 8, 'New York Broadway show tickets', '2025-03-20 08:12:36'),
(41, 9, 'European train passes for seniors', '2025-02-04 07:20:15'),
(42, 9, 'Rome historical walking tours', '2025-02-14 11:45:32'),
(43, 9, 'Athens museums guide', '2025-03-04 08:30:22'),
(44, 9, 'Neuschwanstein Castle tickets', '2025-03-15 13:18:44'),
(45, 9, 'Grand Canyon accessible trails', '2025-03-21 09:25:18'),
(46, 10, 'Great Wall of China tours', '2025-02-06 10:40:22'),
(47, 10, 'Angkor Wat guided tours', '2025-02-13 12:15:38'),
(48, 10, 'traditional ryokan Mount Fuji', '2025-02-28 07:33:21'),
(49, 10, 'Venice gondola rides', '2025-03-09 14:42:15'),
(50, 10, 'Taj Mahal photography tips', '2025-03-18 08:25:42');

-- --------------------------------------------------------

--
-- Table structure for table `weather`
--

CREATE TABLE `weather` (
  `weather_id` int(11) NOT NULL,
  `destination_id` int(11) DEFAULT NULL,
  `forecast_date` date NOT NULL,
  `temperature_high` decimal(5,2) DEFAULT NULL,
  `temperature_low` decimal(5,2) DEFAULT NULL,
  `condition1` varchar(50) DEFAULT NULL,
  `precipitation_chance` decimal(5,2) DEFAULT NULL,
  `humidity` decimal(5,2) DEFAULT NULL,
  `wind_speed` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `weather`
--

INSERT INTO `weather` (`weather_id`, `destination_id`, `forecast_date`, `temperature_high`, `temperature_low`, `condition1`, `precipitation_chance`, `humidity`, `wind_speed`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-04-15', '18.50', '9.75', 'Partly Cloudy', '20.00', '65.00', '12.50', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(2, 2, '2025-04-15', '22.25', '12.50', 'Sunny', '5.00', '55.00', '8.75', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(3, 3, '2025-04-15', '21.75', '14.25', 'Clear', '10.00', '60.00', '10.25', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(4, 4, '2025-04-15', '24.50', '15.75', 'Sunny', '5.00', '50.00', '15.50', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(5, 5, '2025-04-15', '22.00', '16.50', 'Clear', '0.00', '60.00', '18.75', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(6, 6, '2025-04-15', '15.25', '8.50', 'Overcast', '45.00', '75.00', '14.50', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(7, 7, '2025-04-15', '14.75', '5.25', 'Light Rain', '60.00', '80.00', '8.25', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(8, 8, '2025-04-15', '19.50', '11.25', 'Sunny', '15.00', '65.00', '5.75', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(9, 9, '2025-04-15', '20.75', '9.50', 'Clear', '5.00', '40.00', '12.00', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(10, 10, '2025-04-15', '36.25', '24.50', 'Hot and Humid', '10.00', '45.00', '9.50', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(11, 11, '2025-04-15', '35.50', '25.75', 'Hot', '30.00', '70.00', '7.25', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(12, 12, '2025-04-15', '15.25', '3.50', 'Partly Cloudy', '20.00', '55.00', '25.75', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(13, 13, '2025-04-15', '32.75', '25.50', 'Scattered Showers', '40.00', '80.00', '8.50', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(14, 14, '2025-04-15', '33.25', '26.75', 'Thunderstorms', '60.00', '85.00', '7.75', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(15, 15, '2025-04-15', '22.50', '5.25', 'Sunny', '0.00', '25.00', '15.25', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(16, 16, '2025-04-15', '17.75', '9.25', 'Partly Cloudy', '25.00', '60.00', '18.50', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(17, 17, '2025-04-15', '14.50', '6.75', 'Light Rain', '55.00', '70.00', '14.25', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(18, 18, '2025-04-15', '9.75', '-2.50', 'Snow Showers', '50.00', '65.00', '10.75', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(19, 19, '2025-04-15', '31.50', '22.75', 'Partly Cloudy', '15.00', '75.00', '9.25', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(20, 20, '2025-04-15', '18.25', '7.50', 'Scattered Showers', '65.00', '80.00', '6.25', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(21, 21, '2025-04-15', '29.75', '23.25', 'Sunny', '10.00', '70.00', '8.00', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(22, 22, '2025-04-15', '15.50', '2.25', 'Clear', '5.00', '30.00', '20.50', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(23, 23, '2025-04-15', '30.25', '18.50', 'Hot and Dry', '0.00', '25.00', '17.75', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(24, 24, '2025-04-15', '28.75', '16.25', 'Partly Cloudy', '20.00', '65.00', '7.50', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(25, 25, '2025-04-15', '27.50', '15.75', 'Clear', '15.00', '55.00', '12.25', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(26, 26, '2025-04-15', '25.25', '17.50', 'Sunny', '5.00', '60.00', '14.75', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(27, 27, '2025-04-15', '29.00', '22.25', 'Partly Cloudy', '25.00', '70.00', '12.00', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(28, 28, '2025-04-15', '16.75', '8.25', 'Light Rain', '70.00', '85.00', '9.50', '2025-03-26 15:26:57', '2025-03-26 15:26:57'),
(29, 29, '2025-04-15', '30.50', '24.75', 'Scattered Showers', '35.00', '75.00', '11.25', '2025-03-26 15:26:57', '2025-03-26 15:26:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attractions`
--
ALTER TABLE `attractions`
  ADD PRIMARY KEY (`attraction_id`),
  ADD KEY `destination_id` (`destination_id`);

--
-- Indexes for table `destinations`
--
ALTER TABLE `destinations`
  ADD PRIMARY KEY (`destination_id`);

--
-- Indexes for table `flights`
--
ALTER TABLE `flights`
  ADD PRIMARY KEY (`flight_id`);

--
-- Indexes for table `hotels`
--
ALTER TABLE `hotels`
  ADD PRIMARY KEY (`hotel_id`),
  ADD KEY `destination_id` (`destination_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tripdestinations`
--
ALTER TABLE `tripdestinations`
  ADD PRIMARY KEY (`trip_destination_id`),
  ADD KEY `trip_id` (`trip_id`),
  ADD KEY `destination_id` (`destination_id`);

--
-- Indexes for table `tripflights`
--
ALTER TABLE `tripflights`
  ADD PRIMARY KEY (`trip_flight_id`),
  ADD KEY `trip_id` (`trip_id`),
  ADD KEY `flight_id` (`flight_id`);

--
-- Indexes for table `triphotels`
--
ALTER TABLE `triphotels`
  ADD PRIMARY KEY (`trip_hotel_id`),
  ADD KEY `trip_destination_id` (`trip_destination_id`),
  ADD KEY `hotel_id` (`hotel_id`);

--
-- Indexes for table `trips`
--
ALTER TABLE `trips`
  ADD PRIMARY KEY (`trip_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `userfavorites`
--
ALTER TABLE `userfavorites`
  ADD PRIMARY KEY (`favorite_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `destination_id` (`destination_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `usersearchhistory`
--
ALTER TABLE `usersearchhistory`
  ADD PRIMARY KEY (`search_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `weather`
--
ALTER TABLE `weather`
  ADD PRIMARY KEY (`weather_id`),
  ADD KEY `destination_id` (`destination_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attractions`
--
ALTER TABLE `attractions`
  MODIFY `attraction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `destinations`
--
ALTER TABLE `destinations`
  MODIFY `destination_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `flights`
--
ALTER TABLE `flights`
  MODIFY `flight_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `hotels`
--
ALTER TABLE `hotels`
  MODIFY `hotel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `tripdestinations`
--
ALTER TABLE `tripdestinations`
  MODIFY `trip_destination_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `tripflights`
--
ALTER TABLE `tripflights`
  MODIFY `trip_flight_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `triphotels`
--
ALTER TABLE `triphotels`
  MODIFY `trip_hotel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `trips`
--
ALTER TABLE `trips`
  MODIFY `trip_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `userfavorites`
--
ALTER TABLE `userfavorites`
  MODIFY `favorite_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `usersearchhistory`
--
ALTER TABLE `usersearchhistory`
  MODIFY `search_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `weather`
--
ALTER TABLE `weather`
  MODIFY `weather_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attractions`
--
ALTER TABLE `attractions`
  ADD CONSTRAINT `attractions_ibfk_1` FOREIGN KEY (`destination_id`) REFERENCES `destinations` (`destination_id`);

--
-- Constraints for table `hotels`
--
ALTER TABLE `hotels`
  ADD CONSTRAINT `hotels_ibfk_1` FOREIGN KEY (`destination_id`) REFERENCES `destinations` (`destination_id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `tripdestinations`
--
ALTER TABLE `tripdestinations`
  ADD CONSTRAINT `tripdestinations_ibfk_1` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`trip_id`),
  ADD CONSTRAINT `tripdestinations_ibfk_2` FOREIGN KEY (`destination_id`) REFERENCES `destinations` (`destination_id`);

--
-- Constraints for table `tripflights`
--
ALTER TABLE `tripflights`
  ADD CONSTRAINT `tripflights_ibfk_1` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`trip_id`),
  ADD CONSTRAINT `tripflights_ibfk_2` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`);

--
-- Constraints for table `triphotels`
--
ALTER TABLE `triphotels`
  ADD CONSTRAINT `triphotels_ibfk_1` FOREIGN KEY (`trip_destination_id`) REFERENCES `tripdestinations` (`trip_destination_id`),
  ADD CONSTRAINT `triphotels_ibfk_2` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`);

--
-- Constraints for table `trips`
--
ALTER TABLE `trips`
  ADD CONSTRAINT `trips_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `userfavorites`
--
ALTER TABLE `userfavorites`
  ADD CONSTRAINT `userfavorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `userfavorites_ibfk_2` FOREIGN KEY (`destination_id`) REFERENCES `destinations` (`destination_id`);

--
-- Constraints for table `usersearchhistory`
--
ALTER TABLE `usersearchhistory`
  ADD CONSTRAINT `usersearchhistory_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `weather`
--
ALTER TABLE `weather`
  ADD CONSTRAINT `weather_ibfk_1` FOREIGN KEY (`destination_id`) REFERENCES `destinations` (`destination_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
