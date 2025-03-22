-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 22, 2025 at 04:55 PM
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
-- Table structure for table `admin_stats`
--

CREATE TABLE `admin_stats` (
  `stat_id` bigint(20) UNSIGNED NOT NULL,
  `total_users` int(11) DEFAULT NULL,
  `total_trips` int(11) DEFAULT NULL,
  `total_reviews` int(11) DEFAULT NULL,
  `report_date` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `city_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `country_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`city_id`, `name`, `country_id`) VALUES
(1, 'New York', 1),
(2, 'Los Angeles', 1),
(3, 'Toronto', 2),
(4, 'Vancouver', 2),
(5, 'Mexico City', 3),
(6, 'Cancun', 3),
(7, 'Sao Paulo', 4),
(8, 'Rio de Janeiro', 4),
(9, 'Buenos Aires', 5),
(10, 'London', 6),
(11, 'Paris', 7),
(12, 'Berlin', 8),
(13, 'Rome', 9),
(14, 'Madrid', 10),
(15, 'Amsterdam', 11),
(16, 'Brussels', 12),
(17, 'Stockholm', 13),
(18, 'Oslo', 14),
(19, 'Copenhagen', 15),
(20, 'Helsinki', 16),
(21, 'Moscow', 17),
(22, 'Beijing', 18),
(23, 'Shanghai', 18),
(24, 'Tokyo', 19),
(25, 'Seoul', 20),
(26, 'Mumbai', 21),
(27, 'Sydney', 22),
(28, 'Melbourne', 22),
(29, 'Auckland', 23),
(30, 'Cape Town', 24),
(31, 'Cairo', 25),
(32, 'Istanbul', 26),
(33, 'Athens', 27),
(34, 'Bangkok', 28),
(35, 'Jakarta', 29),
(36, 'Kuala Lumpur', 30),
(37, 'Manila', 31),
(38, 'Ho Chi Minh City', 32),
(39, 'Riyadh', 33),
(40, 'Dubai', 34),
(41, 'Tel Aviv', 35),
(42, 'Lisbon', 36),
(43, 'Zurich', 37),
(44, 'Vienna', 38),
(45, 'Warsaw', 39),
(46, 'Prague', 40),
(47, 'Budapest', 41),
(48, 'Bucharest', 42),
(49, 'Kyiv', 43),
(50, 'Dublin', 44),
(51, 'Singapore', 45),
(52, 'Karachi', 46),
(53, 'Dhaka', 47),
(54, 'Santiago', 48),
(55, 'Bogota', 49),
(56, 'Lima', 50),
(57, 'Brasilia', 4),
(58, 'Belo Horizonte', 4),
(59, 'Porto Alegre', 4),
(60, 'Marseille', 7),
(61, 'Lyon', 7),
(62, 'Hamburg', 8),
(63, 'Munich', 8),
(64, 'Naples', 9),
(65, 'Milan', 9),
(66, 'Barcelona', 10),
(67, 'Valencia', 10),
(68, 'Rotterdam', 11),
(69, 'Ghent', 12),
(70, 'Gothenburg', 13),
(71, 'Bergen', 14),
(72, 'Aarhus', 15),
(73, 'Espoo', 16),
(74, 'Saint Petersburg', 17),
(75, 'Shenzhen', 18),
(76, 'Guangzhou', 18),
(77, 'Osaka', 19),
(78, 'Nagoya', 19),
(79, 'Busan', 20),
(80, 'Chennai', 21),
(81, 'Perth', 22),
(82, 'Brisbane', 22),
(83, 'Wellington', 23),
(84, 'Durban', 24),
(85, 'Alexandria', 25),
(86, 'Ankara', 26),
(87, 'Patras', 27),
(88, 'Chiang Mai', 28),
(89, 'Surabaya', 29),
(90, 'Penang', 30),
(91, 'Cebu', 31),
(92, 'Hanoi', 32),
(93, 'Jeddah', 33),
(94, 'Abu Dhabi', 34),
(95, 'Haifa', 35),
(96, 'Porto', 36),
(97, 'Geneva', 37),
(98, 'Salzburg', 38),
(99, 'Krakow', 39),
(100, 'Brno', 40),
(101, 'Debrecen', 41),
(102, 'Cluj-Napoca', 42),
(103, 'Lviv', 43),
(104, 'Cork', 44),
(105, 'Lahore', 46),
(106, 'Chittagong', 47),
(107, 'Valparaiso', 48),
(108, 'Medellin', 49),
(109, 'Arequipa', 50);

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `country_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`country_id`, `name`) VALUES
(5, 'Argentina'),
(22, 'Australia'),
(38, 'Austria'),
(47, 'Bangladesh'),
(12, 'Belgium'),
(4, 'Brazil'),
(2, 'Canada'),
(48, 'Chile'),
(18, 'China'),
(49, 'Colombia'),
(40, 'Czech Republic'),
(15, 'Denmark'),
(25, 'Egypt'),
(16, 'Finland'),
(7, 'France'),
(8, 'Germany'),
(27, 'Greece'),
(41, 'Hungary'),
(21, 'India'),
(29, 'Indonesia'),
(44, 'Ireland'),
(35, 'Israel'),
(9, 'Italy'),
(19, 'Japan'),
(30, 'Malaysia'),
(3, 'Mexico'),
(11, 'Netherlands'),
(23, 'New Zealand'),
(14, 'Norway'),
(46, 'Pakistan'),
(50, 'Peru'),
(31, 'Philippines'),
(39, 'Poland'),
(36, 'Portugal'),
(42, 'Romania'),
(17, 'Russia'),
(33, 'Saudi Arabia'),
(45, 'Singapore'),
(24, 'South Africa'),
(20, 'South Korea'),
(10, 'Spain'),
(13, 'Sweden'),
(37, 'Switzerland'),
(28, 'Thailand'),
(26, 'Turkey'),
(43, 'Ukraine'),
(34, 'United Arab Emirates'),
(6, 'United Kingdom'),
(1, 'United States'),
(32, 'Vietnam');

-- --------------------------------------------------------

--
-- Table structure for table `destinations`
--

CREATE TABLE `destinations` (
  `destination_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `bot_response` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `destination_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` between 1 and 5),
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trips`
--

CREATE TABLE `trips` (
  `trip_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `destination_id` int(11) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` varchar(50) DEFAULT NULL CHECK (`status` in ('Planned','Completed'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` text NOT NULL,
  `role` varchar(20) DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `role`, `created_at`) VALUES
(1, 'user1', 'user1@example.com', 'hashed_password', 'user', '2025-03-22 15:27:06'),
(2, 'user2', 'user2@example.com', 'hashed_password', 'user', '2025-03-22 15:27:06'),
(3, 'user3', 'user3@example.com', 'hashed_password', 'user', '2025-03-22 15:27:06'),
(4, 'user4', 'user4@example.com', 'hashed_password', 'user', '2025-03-22 15:27:06'),
(5, 'user5', 'user5@example.com', 'hashed_password', 'user', '2025-03-22 15:27:06'),
(6, 'user6', 'user6@example.com', 'hashed_password', 'user', '2025-03-22 15:27:06'),
(7, 'user7', 'user7@example.com', 'hashed_password', 'user', '2025-03-22 15:27:06'),
(8, 'user8', 'user8@example.com', 'hashed_password', 'user', '2025-03-22 15:27:06'),
(9, 'user9', 'user9@example.com', 'hashed_password', 'user', '2025-03-22 15:27:06'),
(10, 'user10', 'user10@example.com', 'hashed_password', 'user', '2025-03-22 15:27:06'),
(11, 'admin', 'admin@example.com', 'hashed_password', 'admin', '2025-03-22 15:27:06');

-- --------------------------------------------------------

--
-- Table structure for table `user_favorites`
--

CREATE TABLE `user_favorites` (
  `user_id` int(11) NOT NULL,
  `destination_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `weather`
--

CREATE TABLE `weather` (
  `weather_id` bigint(20) UNSIGNED NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `temperature` decimal(5,2) DEFAULT NULL,
  `conditions` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_stats`
--
ALTER TABLE `admin_stats`
  ADD PRIMARY KEY (`stat_id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`city_id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`country_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `destinations`
--
ALTER TABLE `destinations`
  ADD PRIMARY KEY (`destination_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`);

--
-- Indexes for table `trips`
--
ALTER TABLE `trips`
  ADD PRIMARY KEY (`trip_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_favorites`
--
ALTER TABLE `user_favorites`
  ADD PRIMARY KEY (`user_id`,`destination_id`);

--
-- Indexes for table `weather`
--
ALTER TABLE `weather`
  ADD PRIMARY KEY (`weather_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_stats`
--
ALTER TABLE `admin_stats`
  MODIFY `stat_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `city_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `country_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `destinations`
--
ALTER TABLE `destinations`
  MODIFY `destination_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trips`
--
ALTER TABLE `trips`
  MODIFY `trip_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `weather`
--
ALTER TABLE `weather`
  MODIFY `weather_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
