-- phpMyAdmin SQL Dump
-- version 4.4.15.9
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 05, 2019 at 01:26 AM
-- Server version: 5.6.37
-- PHP Version: 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fooflight`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE IF NOT EXISTS `booking` (
  `booking_id` int(11) NOT NULL,
  `booking_user_id` int(11) DEFAULT NULL,
  `booking_passangers` int(11) NOT NULL,
  `booking_flight_id` int(11) NOT NULL,
  `booking_credit_id` int(11) DEFAULT NULL,
  `booking_price` int(55) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `booking_user_id`, `booking_passangers`, `booking_flight_id`, `booking_credit_id`, `booking_price`) VALUES
(1, 1, 1, 5, NULL, 150);

-- --------------------------------------------------------

--
-- Table structure for table `credit`
--

CREATE TABLE IF NOT EXISTS `credit` (
  `credit_id` int(11) NOT NULL,
  `credit_number` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `credit_holder` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `credit_ccv` int(5) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `credit`
--

INSERT INTO `credit` (`credit_id`, `credit_number`, `credit_holder`, `credit_ccv`) VALUES
(1, '0003584521684', 'tester', 345);

-- --------------------------------------------------------

--
-- Table structure for table `flight`
--

CREATE TABLE IF NOT EXISTS `flight` (
  `flight_id` int(11) NOT NULL,
  `flight_carrier` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `flight_from_id` int(11) NOT NULL,
  `flight_departure` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flight_to_id` int(11) NOT NULL,
  `flight_return` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `flight_duration` double NOT NULL,
  `flight_transit` int(11) NOT NULL,
  `flight_price` int(55) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `flight`
--

INSERT INTO `flight` (`flight_id`, `flight_carrier`, `flight_from_id`, `flight_departure`, `flight_to_id`, `flight_return`, `flight_duration`, `flight_transit`, `flight_price`) VALUES
(5, 'Vietnam Airline', 1, '2019-02-27 16:35:22', 2, '0000-00-00 00:00:00', 2, 0, 150000),
(6, 'Air France', 1, '2019-02-27 16:35:28', 2, '0000-00-00 00:00:00', 1.5, 0, 700000),
(7, 'Turkish Airlines', 1, '2019-02-27 16:35:33', 4, '0000-00-00 00:00:00', 5, 1, 80000);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(82, '2014_10_12_000000_create_users_table', 1),
(83, '2014_10_12_100000_create_password_resets_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `passanger`
--

CREATE TABLE IF NOT EXISTS `passanger` (
  `passanger_id` int(11) NOT NULL,
  `passanger_title` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `passanger_firstname` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `passanger_lastname` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `passanger_user_id` int(11) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `passanger`
--

INSERT INTO `passanger` (`passanger_id`, `passanger_title`, `passanger_firstname`, `passanger_lastname`, `passanger_user_id`) VALUES
(8, 'mr', 'aa', 'bb', 1),
(7, 'mr', 'aa', 'bb', 1),
(9, 'mr', 'aa', 'bb', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `province`
--

CREATE TABLE IF NOT EXISTS `province` (
  `province_id` int(11) NOT NULL,
  `province_code` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `province_name` varchar(55) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `province`
--

INSERT INTO `province` (`province_id`, `province_code`, `province_name`) VALUES
(1, 'SGN', 'TP Ho Chi Minh'),
(2, 'CDG', 'Paris'),
(3, 'PEK', 'Beijing Capital'),
(4, 'IST', 'Istanbul Ataturk');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_access` timestamp NULL DEFAULT NULL,
  `attempt` int(11) DEFAULT '0',
  `active` int(11) NOT NULL DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `password`, `last_access`, `attempt`, `active`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'cuong', 'huynhchicuong1@gmail.com', '123', '$2y$10$WHDYAydAw0xXfwffs1d/reGw63kJ1jJ8p08rnAlRjgOW4AzkSqTfS', NULL, 0, 1, 'OlHt2TFDf3MO4YIpUfkYU4xAD0heJmZospm28jzwfY5CqyqjlSvvCNX50aZA', '2019-02-26 13:18:37', '2019-02-26 17:11:14'),
(2, 'cuong', 'huynhchicuongz1@gmail.com', '123', '$2y$10$sUPLcoF5vm1REvwXRokupOtBAw2b8gx0ZEvmMcXt4v6QYFmnnzcJm', NULL, 0, 1, 'nVQEY5WXClRvfGmWyjQXlIhEkWC2vs1t5SXHx1tJCrmGUvPiTShDcv1ZeYEB', '2019-02-26 13:32:39', '2019-02-26 17:11:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`);

--
-- Indexes for table `credit`
--
ALTER TABLE `credit`
  ADD PRIMARY KEY (`credit_id`),
  ADD UNIQUE KEY `credit_number` (`credit_number`);

--
-- Indexes for table `flight`
--
ALTER TABLE `flight`
  ADD PRIMARY KEY (`flight_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `passanger`
--
ALTER TABLE `passanger`
  ADD PRIMARY KEY (`passanger_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indexes for table `province`
--
ALTER TABLE `province`
  ADD PRIMARY KEY (`province_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `credit`
--
ALTER TABLE `credit`
  MODIFY `credit_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `flight`
--
ALTER TABLE `flight`
  MODIFY `flight_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=88;
--
-- AUTO_INCREMENT for table `passanger`
--
ALTER TABLE `passanger`
  MODIFY `passanger_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `province`
--
ALTER TABLE `province`
  MODIFY `province_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
