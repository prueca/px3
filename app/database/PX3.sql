-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 01, 2019 at 05:13 PM
-- Server version: 10.1.29-MariaDB
-- PHP Version: 7.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `PX3`
--

-- --------------------------------------------------------

--
-- Table structure for table `Accounts`
--

CREATE TABLE `Accounts` (
  `account_id` int(10) UNSIGNED NOT NULL,
  `email_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `middle_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthdate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reward_points` int(11) NOT NULL DEFAULT '0',
  `access_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `Accounts`
--

INSERT INTO `Accounts` (`account_id`, `email_address`, `password`, `first_name`, `middle_name`, `last_name`, `gender`, `address`, `contact_number`, `birthdate`, `photo`, `reward_points`, `access_token`) VALUES
(1, 'peterrueca@yahoo.com', '$2y$10$OX6Z6Nf80NEUJhxNXBsyMuroJkXZ1YyM/8zuH2kZOp5wE.taLDt0e', 'Peter John', 'Resoles', 'Rueca', 'M', 'C5-Quirino, Nova., Quezon City', '0916-872-8941', '1993-06-21', 'storage/account/ZPe1Yeyo/420e390f458b732f5164277d392bd2c7.png', 7, 'i5RUgO93kETIFUmjpAhkw3YrMmI4aFcwb0pwbjlQdHZrcS9heDlma0d6eXNCelNXL2kxbkRoajh3YTQ9'),
(2, 'dummy@yahoo.com', '$2y$10$OX6Z6Nf80NEUJhxNXBsyMuroJkXZ1YyM/8zuH2kZOp5wE.taLDt0e', 'Dummy', '', 'Account', 'M', NULL, NULL, NULL, NULL, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `Appointments`
--

CREATE TABLE `Appointments` (
  `appointment_id` int(11) NOT NULL,
  `clinic_id` int(11) NOT NULL,
  `schedule` varchar(30) NOT NULL,
  `purpose` text NOT NULL,
  `for_other` varchar(1) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) NOT NULL DEFAULT '',
  `last_name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `birthdate` varchar(50) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `email_address` varchar(255) NOT NULL,
  `booked_by` int(11) NOT NULL,
  `date_booked` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(30) NOT NULL DEFAULT 'Booked'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Appointments`
--

INSERT INTO `Appointments` (`appointment_id`, `clinic_id`, `schedule`, `purpose`, `for_other`, `first_name`, `middle_name`, `last_name`, `address`, `birthdate`, `gender`, `email_address`, `booked_by`, `date_booked`, `status`) VALUES
(6, 1, '2019-01-23', 'test', '0', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-22 19:44:27', 'Booked'),
(8, 13, '2019-01-30', 'Testing lang &#039;to', '0', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-23 22:00:43', 'Booked'),
(9, 97, '2019-01-30', 'Test', '0', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:29', 'Booked'),
(10, 51, '2019-02-06', 'Test', '0', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:52', 'Booked'),
(11, 28, '2019-02-13', 'Test', '0', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:12:53', 'Booked'),
(12, 3, '2019-02-13', 'Test', '0', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:20', 'Booked'),
(13, 11, '2019-02-20', 'Test', '0', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:51', 'Booked'),
(14, 49, '2019-01-30', 'Test', '0', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:14:32', 'Booked'),
(15, 27, '2019-02-20', 'Test', '0', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:04', 'Booked'),
(16, 119, '2019-02-27', 'Test', '0', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:55', 'Booked'),
(17, 75, '2019-03-06', 'Test', '0', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:17', 'Booked'),
(18, 34, '2019-03-13', 'Test', '0', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:49', 'Booked'),
(19, 41, '2019-02-20', 'Test', '0', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:18:17', 'Booked'),
(20, 1, '2019-01-23', 'test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-22 19:44:27', 'Settled'),
(21, 13, '2019-01-30', 'Testing lang &#039;to', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-23 22:00:43', 'Settled'),
(22, 97, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:29', 'Settled'),
(23, 51, '2019-02-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:52', 'Settled'),
(24, 28, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:12:53', 'Settled'),
(25, 3, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:20', 'Settled'),
(27, 49, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:14:32', 'Settled'),
(28, 27, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:04', 'Settled'),
(29, 119, '2019-02-27', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:55', 'Settled'),
(30, 75, '2019-03-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:17', 'Settled'),
(31, 34, '2019-03-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:49', 'Settled'),
(32, 41, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:18:17', 'Settled'),
(35, 1, '2019-01-23', 'test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-22 19:44:27', 'Settled'),
(36, 13, '2019-01-30', 'Testing lang &#039;to', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-23 22:00:43', 'Settled'),
(37, 97, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:29', 'Settled'),
(38, 51, '2019-02-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:52', 'Settled'),
(39, 28, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:12:53', 'Settled'),
(40, 3, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:20', 'Settled'),
(41, 11, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:51', 'Settled'),
(42, 49, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:14:32', 'Settled'),
(43, 27, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:04', 'Settled'),
(44, 119, '2019-02-27', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:55', 'Settled'),
(45, 75, '2019-03-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:17', 'Settled'),
(46, 34, '2019-03-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:49', 'Settled'),
(47, 41, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:18:17', 'Settled'),
(50, 1, '2019-01-23', 'test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-22 19:44:27', 'Settled'),
(51, 13, '2019-01-30', 'Testing lang &#039;to', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-23 22:00:43', 'Settled'),
(52, 97, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:29', 'Settled'),
(53, 51, '2019-02-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:52', 'Settled'),
(55, 3, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:20', 'Settled'),
(56, 11, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:51', 'Settled'),
(57, 49, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:14:32', 'Settled'),
(58, 27, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:04', 'Settled'),
(59, 119, '2019-02-27', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:55', 'Settled'),
(61, 34, '2019-03-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:49', 'Settled'),
(62, 41, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:18:17', 'Settled'),
(66, 13, '2019-01-30', 'Testing lang &#039;to', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-23 22:00:43', 'Settled'),
(67, 97, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:29', 'Settled'),
(68, 51, '2019-02-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:52', 'Settled'),
(69, 28, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:12:53', 'Settled'),
(70, 3, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:20', 'Settled'),
(71, 11, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:51', 'Settled'),
(72, 49, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:14:32', 'Settled'),
(73, 27, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:04', 'Settled'),
(74, 119, '2019-02-27', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:55', 'Settled'),
(75, 75, '2019-03-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:17', 'Settled'),
(76, 34, '2019-03-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:49', 'Settled'),
(77, 41, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:18:17', 'Settled'),
(80, 1, '2019-01-23', 'test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-22 19:44:27', 'Settled'),
(81, 13, '2019-01-30', 'Testing lang &#039;to', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-23 22:00:43', 'Settled'),
(82, 97, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:29', 'Settled'),
(83, 51, '2019-02-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:52', 'Settled'),
(84, 28, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:12:53', 'Settled'),
(85, 3, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:20', 'Settled'),
(86, 11, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:51', 'Settled'),
(87, 49, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:14:32', 'Settled'),
(88, 27, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:04', 'Settled'),
(89, 119, '2019-02-27', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:55', 'Settled'),
(90, 75, '2019-03-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:17', 'Settled'),
(91, 34, '2019-03-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:49', 'Settled'),
(92, 41, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:18:17', 'Settled'),
(95, 1, '2019-01-23', 'test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-22 19:44:27', 'Settled'),
(96, 13, '2019-01-30', 'Testing lang &#039;to', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-23 22:00:43', 'Settled'),
(97, 97, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:29', 'Settled'),
(98, 51, '2019-02-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:52', 'Settled'),
(99, 28, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:12:53', 'Settled'),
(100, 3, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:20', 'Settled'),
(101, 11, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:51', 'Settled'),
(102, 49, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:14:32', 'Settled'),
(103, 27, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:04', 'Settled'),
(104, 119, '2019-02-27', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:55', 'Settled'),
(105, 75, '2019-03-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:17', 'Settled'),
(106, 34, '2019-03-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:49', 'Settled'),
(107, 41, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:18:17', 'Settled'),
(110, 1, '2019-01-23', 'test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-22 19:44:27', 'Settled'),
(111, 13, '2019-01-30', 'Testing lang &#039;to', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-23 22:00:43', 'Settled'),
(112, 97, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:29', 'Settled'),
(113, 51, '2019-02-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:52', 'Settled'),
(114, 28, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:12:53', 'Settled'),
(115, 3, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:20', 'Settled'),
(116, 11, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:51', 'Settled'),
(117, 49, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:14:32', 'Settled'),
(118, 27, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:04', 'Settled'),
(119, 119, '2019-02-27', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:55', 'Settled'),
(120, 75, '2019-03-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:17', 'Settled'),
(121, 34, '2019-03-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:49', 'Settled'),
(122, 41, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:18:17', 'Settled'),
(125, 1, '2019-01-23', 'test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-22 19:44:27', 'Settled'),
(126, 13, '2019-01-30', 'Testing lang &#039;to', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-23 22:00:43', 'Settled'),
(127, 97, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:29', 'Settled'),
(128, 51, '2019-02-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:52', 'Settled'),
(129, 28, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:12:53', 'Settled'),
(130, 3, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:20', 'Settled'),
(131, 11, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:51', 'Settled'),
(132, 49, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:14:32', 'Settled'),
(133, 27, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:04', 'Settled'),
(134, 119, '2019-02-27', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:55', 'Settled'),
(135, 75, '2019-03-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:17', 'Settled'),
(136, 34, '2019-03-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:49', 'Settled'),
(137, 41, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:18:17', 'Settled'),
(140, 1, '2019-01-23', 'test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-22 19:44:27', 'Settled'),
(141, 13, '2019-01-30', 'Testing lang &#039;to', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-23 22:00:43', 'Settled'),
(142, 97, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:29', 'Settled'),
(143, 51, '2019-02-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:52', 'Settled'),
(144, 28, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:12:53', 'Settled'),
(145, 3, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:20', 'Settled'),
(146, 11, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:51', 'Settled'),
(147, 49, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:14:32', 'Settled'),
(148, 27, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:04', 'Settled'),
(149, 119, '2019-02-27', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:55', 'Settled'),
(150, 75, '2019-03-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:17', 'Settled'),
(151, 34, '2019-03-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:49', 'Settled'),
(152, 41, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:18:17', 'Settled'),
(155, 1, '2019-01-23', 'test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-22 19:44:27', 'Settled'),
(156, 13, '2019-01-30', 'Testing lang &#039;to', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-23 22:00:43', 'Settled'),
(157, 97, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:29', 'Settled'),
(158, 51, '2019-02-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:52', 'Settled'),
(159, 28, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:12:53', 'Settled'),
(160, 3, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:20', 'Settled'),
(161, 11, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:51', 'Settled'),
(162, 49, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:14:32', 'Settled'),
(163, 27, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:04', 'Settled'),
(164, 119, '2019-02-27', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:55', 'Settled'),
(165, 75, '2019-03-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:17', 'Settled'),
(166, 34, '2019-03-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:49', 'Settled'),
(167, 41, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:18:17', 'Settled'),
(170, 1, '2019-01-23', 'test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-22 19:44:27', 'Settled'),
(171, 13, '2019-01-30', 'Testing lang &#039;to', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-23 22:00:43', 'Settled'),
(172, 97, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:29', 'Settled'),
(173, 51, '2019-02-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:52', 'Settled'),
(174, 28, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:12:53', 'Settled'),
(175, 3, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:20', 'Settled'),
(176, 11, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:51', 'Settled'),
(177, 49, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:14:32', 'Settled'),
(178, 27, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:04', 'Settled'),
(179, 119, '2019-02-27', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:55', 'Settled'),
(180, 75, '2019-03-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:17', 'Settled'),
(181, 34, '2019-03-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:49', 'Settled'),
(182, 41, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:18:17', 'Settled'),
(185, 1, '2019-01-23', 'test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-22 19:44:27', 'Settled'),
(186, 13, '2019-01-30', 'Testing lang &#039;to', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-23 22:00:43', 'Settled'),
(187, 97, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:29', 'Settled'),
(188, 51, '2019-02-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:11:52', 'Settled'),
(189, 28, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:12:53', 'Settled'),
(190, 3, '2019-02-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:20', 'Settled'),
(191, 11, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:13:51', 'Settled'),
(192, 49, '2019-01-30', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:14:32', 'Settled'),
(193, 27, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:04', 'Settled'),
(194, 119, '2019-02-27', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:15:55', 'Settled'),
(195, 75, '2019-03-06', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:17', 'Settled'),
(196, 34, '2019-03-13', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:17:49', 'Settled'),
(197, 41, '2019-02-20', 'Test', '', 'Peter John', 'Resoles', 'Rueca', 'C5-Quirino, Nova., Quezon City', '1993-06-21', 'M', 'peterrueca@yahoo.com', 1, '2019-01-25 09:18:17', 'Settled');

-- --------------------------------------------------------

--
-- Table structure for table `Clinics`
--

CREATE TABLE `Clinics` (
  `clinic_id` int(11) NOT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `street_address` varchar(255) DEFAULT '',
  `schedule` varchar(255) DEFAULT NULL,
  `barangay` varchar(255) DEFAULT '',
  `city` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Clinics`
--

INSERT INTO `Clinics` (`clinic_id`, `doctor_id`, `name`, `street_address`, `schedule`, `barangay`, `city`) VALUES
(1, 1, 'Kamuning Clinic', 'GMA 7,  Kamuning', '[{\"day\":\"Tue\",\"opening\":\"2:00 PM\",\"closing\":\"3:00 PM\"}]', 'Talipapa', 'Quezon City'),
(2, 1, 'Hi-Precision', 'Sangandaan', '[{\"day\":\"Thu\",\"opening\":\"08:00 AM\",\"closing\":\"09:00 AM\"}]', '', 'Caloocan City'),
(3, 2, 'Lung Center of the Philippines', 'Room 1113', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', 'Pulang Bato', 'Quezon City'),
(4, 3, 'Enormo Clinic', '71 Williams Avenue,  Paang Bundok', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(5, 3, 'Comtrak Medical Clinic', '68 Howard Place,  Bahay Toro', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(6, 4, 'Zensure Clinic', '4 Narrows Avenue,  Marcelo Green', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'ParaÃ±aque'),
(7, 4, 'Netropic Medical Clinic', '44 Tampa Court,  Pilar Village', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Las PiÃ±as'),
(8, 4, 'Neocent Medical Clinic', '79 Willow Street,  Central Bicutan', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Taguig'),
(9, 5, 'Cosmetex Clinic', '75 Sharon Street,  Nichols', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasay'),
(10, 5, 'Izzby Clinic', '74 Madeline Court,  Bayan-bayanan', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Malabon'),
(11, 6, 'Megall Clinic', '74 Bayview Avenue,  Marikina Heights', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Marikina'),
(12, 6, 'Isoternia Clinic', '57 Village Road,  Bagong Silang', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Caloocan'),
(13, 7, 'Bezal Clinic', '78 Matthews Court,  Palasan', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Valenzuela'),
(14, 7, 'Boilcat Clinic', '6 Gain Court,  Santa Cruz', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Makati'),
(15, 7, 'Mixers Clinic', '60 Gem Street,  Balingasa', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(16, 8, 'Zytrek Clinic', '42 Henry Street,  Santa Mesa', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'City of Manila'),
(17, 8, 'Concility Clinic', '40 Lefferts Place,  San Nicolas', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasig'),
(18, 8, 'Isologix Clinic', '49 Heyward Street,  DoÃ±a Josefa', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(19, 9, 'Apex Clinic', '46 Dwight Street,  Pag-asa', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Mandaluyong'),
(20, 9, 'Biflex Medical Clinic', '79 Tapscott Avenue,  Pildera Uno', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasay'),
(21, 9, 'Vitricomp Clinic', '20 Florence Avenue,  San Andres', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'City of Manila'),
(22, 10, 'Applidec Clinic', '42 Harbor Court,  Pasong Putik', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(23, 10, 'Bolax Clinic', '96 School Lane,  Barangka Itaas', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Mandaluyong'),
(24, 10, 'Austex Clinic', '14 Duryea Court,  Salapan', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'San Juan'),
(25, 11, 'Stralum Medical Clinic', '23 Jerome Avenue,  Sampaloc', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'City of Manila'),
(26, 12, 'Ecolight Clinic', '59 Cypress Avenue,  Maypajo', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Caloocan'),
(27, 12, 'Daisu Clinic', '81 Furman Street,  Old ZaÃ±iga', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Mandaluyong'),
(28, 13, 'Nikuda Clinic', '4 Bayard Street,  Daniel Fajardo', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Las PiÃ±as'),
(29, 13, 'Eweville Clinic', '65 Dover Street,  San Roque', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasay'),
(30, 14, 'Magnafone Clinic', '53 Evergreen Avenue,  Buayang Bato', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Mandaluyong'),
(31, 14, 'Grok Clinic', '42 Ide Court,  San Rafael', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasay'),
(32, 14, 'Jamnation Medical Clinic', '19 Kansas Place,  Forbes Park', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Makati'),
(33, 15, 'Enjola Clinic', '24 Aurelia Court,  San Jose', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Navotas'),
(34, 15, 'Filodyne Medical Clinic', '63 Foster Avenue,  Gulod', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(35, 16, 'Assistix Medical Clinic', '62 Jodie Court,  Bagong Pag-asa', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(36, 17, 'Vidto Clinic', '98 Madison Street,  Jesus de la PeÃ±a', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Marikina'),
(37, 18, 'Xth Clinic', '80 Elizabeth Place,  Paligsahan', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(38, 19, 'Omnigog Medical Clinic', '89 Lester Court,  Moonwalk', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'ParaÃ±aque'),
(39, 19, 'Metroz Clinic', '96 Jefferson Street,  Milagrosa', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(40, 20, 'Escenta Clinic', '54 Ditmars Street,  Katipunan', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(41, 20, 'Tropoli Medical Clinic', '11 Fanchon Place,  San Roque', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pateros'),
(42, 21, 'Zaggle Clinic', '94 McDonald Avenue,  Pinagbuhatan', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasig'),
(43, 22, 'Pyrami Clinic', '14 Broadway ,  Merville', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'ParaÃ±aque'),
(44, 22, 'Conferia Clinic', '71 Micieli Place,  Maysilo', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Malabon'),
(45, 22, 'Brainclip Clinic', '78 Church Avenue,  Del Monte', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(46, 23, 'Blanet Clinic', '33 Voorhies Avenue,  San Agustin', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Malabon'),
(47, 23, 'Keengen Clinic', '83 Whitty Lane,  Bagong Silang', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Mandaluyong'),
(48, 23, 'Anacho Clinic', '74 Monaco Place,  Santa Lucia', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(49, 24, 'Senmao Clinic', '26 Herbert Street,  Balut', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'City of Manila'),
(50, 25, 'Futurity Medical Clinic', '16 High Street,  Malinao', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasig'),
(51, 25, 'Lunchpod Clinic', '89 Laurel Avenue,  Santa Cruz', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasig'),
(52, 26, 'Evidends Clinic', '13 Dank Court,  Katuparan', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Taguig'),
(53, 26, 'Aeora Clinic', '25 Cove Lane,  La Huerta', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'ParaÃ±aque'),
(54, 26, 'Rubadub Clinic', '18 Hendrickson Place,  Don Bosco', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'ParaÃ±aque'),
(55, 27, 'Phormula Clinic', '89 Raleigh Place,  Bay City', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasay'),
(56, 27, 'Kiosk Clinic', '58 McClancy Place,  Cartimar', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasay'),
(57, 27, 'Geoforma Clinic', '2 Herkimer Place,  Bambang', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Taguig'),
(58, 28, 'Koffee Clinic', '99 Tiffany Place,  General T. de Leon', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Valenzuela'),
(59, 29, 'Proflex Clinic', '31 Hampton Avenue,  Gagalangin', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'City of Manila'),
(60, 29, 'Comvene Clinic', '1 Granite Street,  Oranbo', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasig'),
(61, 29, 'Globoil Clinic', '93 Quincy Street,  Santo Rosario Kanluran', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pateros'),
(62, 30, 'Zaphire Medical Clinic', '21 Milford Street,  San Nicolas', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'City of Manila'),
(63, 30, 'Bicol Medical Clinic', '47 Sullivan Street,  Ayala Alabang', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Muntinlupa'),
(64, 30, 'Qimonk Medical Clinic', '47 Bush Street,  Polo', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Valenzuela'),
(65, 31, 'Comverges Clinic', '76 Joralemon Street,  Pildera Uno', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasay'),
(66, 31, 'Aquoavo Clinic', '82 Essex Street,  Cuyegkeng', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasay'),
(67, 31, 'Manufact Medical Clinic', '18 Underhill Avenue,  Llano', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Caloocan'),
(68, 32, 'Multron Clinic', '51 Kosciusko Street,  Hagdan Bato Itaas', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Mandaluyong'),
(69, 33, 'Comveyer Clinic', '67 Dearborn Court,  San Roque', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasay'),
(70, 34, 'Zosis Medical Clinic', '86 Ditmars Street,  Guadalupe Viejo', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Makati'),
(71, 34, 'Zytrex Clinic', '2 Schenck Street,  Cembo', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Makati'),
(72, 35, 'Squish Medical Clinic', '64 Vanderbilt Avenue,  Sagad', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasig'),
(73, 35, 'Menbrain Clinic', '96 Bragg Street,  Ibayo Tipas', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Taguig'),
(74, 36, 'Exoblue Clinic', '73 Emerson Place,  Concepcion', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Malabon'),
(75, 36, 'Retrotex Clinic', '39 Schenck Avenue,  Onse', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'San Juan'),
(76, 37, 'Centice Clinic', '49 Remsen Avenue,  Calumpang', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Marikina'),
(77, 38, 'Scenty Medical Clinic', '42 Calder Place,  Heroes del 96', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Caloocan'),
(78, 38, 'Tubesys Clinic', '23 Fuller Place,  Malanday', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Marikina'),
(79, 38, 'Stralum Clinic', '46 Grattan Street,  DoÃ±a Imelda', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(80, 39, 'Grupoli Clinic', '1 Canda Avenue,  Arkong Bato', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Valenzuela'),
(81, 39, 'Zensus Clinic', '97 Baughman Place,  Santa Lucia', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(82, 39, 'Jetsilk Clinic', '22 Kingsland Avenue,  Santa Lucia', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasig'),
(83, 40, 'Qiao Clinic', '88 Tampa Court,  Hulo', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Mandaluyong'),
(84, 40, 'Eclipto Clinic', '81 Brown Street,  Harapin ang Bukas', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Mandaluyong'),
(85, 41, 'Geeketron Clinic', '10 Sumner Place,  Salvacion', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(86, 42, 'Quordate Clinic', '24 Gatling Place,  Balut', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'City of Manila'),
(87, 43, 'Uni Clinic', '77 Haring Street,  Batao', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasay'),
(88, 43, 'Beadzza Medical Clinic', '38 Hanover Place,  Forbes Park', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Makati'),
(89, 43, 'Liquicom Clinic', '4 Huron Street,  Manila Bay Reclamation', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasay'),
(90, 44, 'Exotechno Clinic', '41 Jodie Court,  Santa Cruz', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasig'),
(91, 44, 'Balooba Clinic', '89 Thames Street,  Isabelita', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'San Juan'),
(92, 45, 'Prismatic Clinic', '37 Sharon Street,  Pulang Lupa Dos', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Las PiÃ±as'),
(93, 46, 'Zidox Clinic', '60 Seabring Street,  Santa Quiteria', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Caloocan'),
(94, 46, 'Izzby Medical Clinic', '96 Midwood Street,  Malate', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'City of Manila'),
(95, 47, 'Zilidium Clinic', '67 Hudson Avenue,  Barangka Ilaya', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Mandaluyong'),
(96, 47, 'Ontagene Clinic', '34 Cumberland Walk,  Ilaya', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Las PiÃ±as'),
(97, 48, 'Zaggle Clinic', '22 Pulaski Street,  Mabolo', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Valenzuela'),
(98, 49, 'Canopoly Medical Clinic', '62 Norwood Avenue,  Payatas', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(99, 49, 'Oceanica Clinic', '65 National Drive,  San Dionisio', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'ParaÃ±aque'),
(100, 49, 'Techmania Medical Clinic', '92 Green Street,  DoÃ±a Josefa', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(101, 50, 'Applidec Clinic', '88 Madeline Court,  Paraiso', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(102, 51, 'Metroz Medical Clinic', '70 McKinley Avenue,  Fairview', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(103, 52, 'Vantage Clinic', '93 Division Avenue,  Palanan', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Makati'),
(104, 52, 'Netagy Clinic', '61 Wogan Terrace,  Bagong Silang', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Mandaluyong'),
(105, 52, 'Homelux Medical Clinic', '17 Beayer Place,  San Miguel', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasig'),
(106, 53, 'Zounds Medical Clinic', '98 Kay Court,  Manuyo Uno', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Las PiÃ±as'),
(107, 53, 'Comvey Clinic', '19 Baycliff Terrace,  Bayan-bayanan', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Malabon'),
(108, 54, 'Jamnation Medical Clinic', '82 Seigel Court,  Little Baguio', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'San Juan'),
(109, 54, 'Kineticut Clinic', '4 Madison Street,  San Antonio', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(110, 55, 'Extragen Clinic', '71 Auburn Place,  San Antonio', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Makati'),
(111, 55, 'Octocore Clinic', '41 Olive Street,  Dela Paz', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasig'),
(112, 56, 'Geekol Clinic', '49 Farragut Road,  Commonwealth', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(113, 57, 'Comveyer Clinic', '64 Apollo Street,  Paang Bundok', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(114, 58, 'Zogak Medical Clinic', '61 Dahl Court,  San Pablo', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Pasay'),
(115, 59, 'Nurplex Clinic', '22 Montauk Court,  La Paz', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Makati'),
(116, 60, 'Verbus Clinic', '46 Perry Place,  Marulas', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Caloocan'),
(117, 60, 'Cogentry Medical Clinic', '7 Downing Street,  Bayan-bayanan', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Malabon'),
(118, 61, 'Everest Clinic', '12 Fillmore Place,  Pulang Lupa Dos', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Las PiÃ±as'),
(119, 62, 'Kyaguru Medical Clinic', '10 Garden Street,  Amparo', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Caloocan'),
(120, 63, 'Bolax Clinic', '3 Preston Court,  Rizal', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Makati'),
(121, 64, 'Tsunamia Medical Clinic', '30 Woodhull Street,  San Antonio', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(122, 64, 'Geoform Medical Clinic', '66 Gates Avenue,  Central', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Quezon City'),
(123, 64, 'Sealoud Clinic', '88 Orange Street,  Baritan', '[{\"day\":\"Wed\",\"opening\":\"9:00 AM\",\"closing\":\"10:00 AM\"}]', '', 'Malabon');

-- --------------------------------------------------------

--
-- Table structure for table `DoctorMeta`
--

CREATE TABLE `DoctorMeta` (
  `meta_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `meta_key` varchar(255) NOT NULL,
  `meta_value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DoctorMeta`
--

INSERT INTO `DoctorMeta` (`meta_id`, `doctor_id`, `meta_key`, `meta_value`) VALUES
(1, 1, 'service', 'Diagnosis'),
(2, 1, 'service', 'Tooth Removal'),
(3, 2, 'service', 'Diagnosis'),
(4, 3, 'service', 'Acupuncture'),
(5, 3, 'service', 'Knee replacement'),
(6, 3, 'service', 'Physical therapy'),
(7, 3, 'service', 'Surgery'),
(8, 4, 'service', 'Acupuncture'),
(9, 4, 'service', 'Knee replacement'),
(10, 4, 'service', 'Physical therapy'),
(11, 4, 'service', 'Surgery'),
(12, 5, 'service', 'Acupuncture'),
(13, 5, 'service', 'Knee replacement'),
(14, 5, 'service', 'Physical therapy'),
(15, 5, 'service', 'Surgery'),
(16, 6, 'service', 'Acupuncture'),
(17, 6, 'service', 'Knee replacement'),
(18, 6, 'service', 'Physical therapy'),
(19, 6, 'service', 'Surgery'),
(20, 7, 'service', 'Acupuncture'),
(21, 7, 'service', 'Knee replacement'),
(22, 7, 'service', 'Physical therapy'),
(23, 7, 'service', 'Surgery'),
(24, 8, 'service', 'Acupuncture'),
(25, 8, 'service', 'Knee replacement'),
(26, 8, 'service', 'Physical therapy'),
(27, 8, 'service', 'Surgery'),
(28, 9, 'service', 'Acupuncture'),
(29, 9, 'service', 'Knee replacement'),
(30, 9, 'service', 'Physical therapy'),
(31, 9, 'service', 'Surgery'),
(32, 10, 'service', 'Acupuncture'),
(33, 10, 'service', 'Knee replacement'),
(34, 10, 'service', 'Physical therapy'),
(35, 10, 'service', 'Surgery'),
(36, 11, 'service', 'Acupuncture'),
(37, 11, 'service', 'Knee replacement'),
(38, 11, 'service', 'Physical therapy'),
(39, 11, 'service', 'Surgery'),
(40, 12, 'service', 'Acupuncture'),
(41, 12, 'service', 'Knee replacement'),
(42, 12, 'service', 'Physical therapy'),
(43, 12, 'service', 'Surgery'),
(44, 13, 'service', 'Acupuncture'),
(45, 13, 'service', 'Knee replacement'),
(46, 13, 'service', 'Physical therapy'),
(47, 13, 'service', 'Surgery'),
(48, 14, 'service', 'Acupuncture'),
(49, 14, 'service', 'Knee replacement'),
(50, 14, 'service', 'Physical therapy'),
(51, 14, 'service', 'Surgery'),
(52, 15, 'service', 'Acupuncture'),
(53, 15, 'service', 'Knee replacement'),
(54, 15, 'service', 'Physical therapy'),
(55, 15, 'service', 'Surgery'),
(56, 16, 'service', 'Acupuncture'),
(57, 16, 'service', 'Knee replacement'),
(58, 16, 'service', 'Physical therapy'),
(59, 16, 'service', 'Surgery'),
(60, 17, 'service', 'Acupuncture'),
(61, 17, 'service', 'Knee replacement'),
(62, 17, 'service', 'Physical therapy'),
(63, 17, 'service', 'Surgery'),
(64, 18, 'service', 'Acupuncture'),
(65, 18, 'service', 'Knee replacement'),
(66, 18, 'service', 'Physical therapy'),
(67, 18, 'service', 'Surgery'),
(68, 19, 'service', 'Acupuncture'),
(69, 19, 'service', 'Knee replacement'),
(70, 19, 'service', 'Physical therapy'),
(71, 19, 'service', 'Surgery'),
(72, 20, 'service', 'Acupuncture'),
(73, 20, 'service', 'Knee replacement'),
(74, 20, 'service', 'Physical therapy'),
(75, 20, 'service', 'Surgery'),
(76, 21, 'service', 'Acupuncture'),
(77, 21, 'service', 'Knee replacement'),
(78, 21, 'service', 'Physical therapy'),
(79, 21, 'service', 'Surgery'),
(80, 22, 'service', 'Acupuncture'),
(81, 22, 'service', 'Knee replacement'),
(82, 22, 'service', 'Physical therapy'),
(83, 22, 'service', 'Surgery'),
(84, 23, 'service', 'Acupuncture'),
(85, 23, 'service', 'Knee replacement'),
(86, 23, 'service', 'Physical therapy'),
(87, 23, 'service', 'Surgery'),
(88, 24, 'service', 'Acupuncture'),
(89, 24, 'service', 'Knee replacement'),
(90, 24, 'service', 'Physical therapy'),
(91, 24, 'service', 'Surgery'),
(92, 25, 'service', 'Acupuncture'),
(93, 25, 'service', 'Knee replacement'),
(94, 25, 'service', 'Physical therapy'),
(95, 25, 'service', 'Surgery'),
(96, 26, 'service', 'Acupuncture'),
(97, 26, 'service', 'Knee replacement'),
(98, 26, 'service', 'Physical therapy'),
(99, 26, 'service', 'Surgery'),
(100, 27, 'service', 'Acupuncture'),
(101, 27, 'service', 'Knee replacement'),
(102, 27, 'service', 'Physical therapy'),
(103, 27, 'service', 'Surgery'),
(104, 28, 'service', 'Acupuncture'),
(105, 28, 'service', 'Knee replacement'),
(106, 28, 'service', 'Physical therapy'),
(107, 28, 'service', 'Surgery'),
(108, 29, 'service', 'Acupuncture'),
(109, 29, 'service', 'Knee replacement'),
(110, 29, 'service', 'Physical therapy'),
(111, 29, 'service', 'Surgery'),
(112, 30, 'service', 'Acupuncture'),
(113, 30, 'service', 'Knee replacement'),
(114, 30, 'service', 'Physical therapy'),
(115, 30, 'service', 'Surgery'),
(116, 31, 'service', 'Acupuncture'),
(117, 31, 'service', 'Knee replacement'),
(118, 31, 'service', 'Physical therapy'),
(119, 31, 'service', 'Surgery'),
(120, 32, 'service', 'Acupuncture'),
(121, 32, 'service', 'Knee replacement'),
(122, 32, 'service', 'Physical therapy'),
(123, 32, 'service', 'Surgery'),
(124, 33, 'service', 'Acupuncture'),
(125, 33, 'service', 'Knee replacement'),
(126, 33, 'service', 'Physical therapy'),
(127, 33, 'service', 'Surgery'),
(128, 34, 'service', 'Acupuncture'),
(129, 34, 'service', 'Knee replacement'),
(130, 34, 'service', 'Physical therapy'),
(131, 34, 'service', 'Surgery'),
(132, 35, 'service', 'Acupuncture'),
(133, 35, 'service', 'Knee replacement'),
(134, 35, 'service', 'Physical therapy'),
(135, 35, 'service', 'Surgery'),
(136, 36, 'service', 'Acupuncture'),
(137, 36, 'service', 'Knee replacement'),
(138, 36, 'service', 'Physical therapy'),
(139, 36, 'service', 'Surgery'),
(140, 37, 'service', 'Acupuncture'),
(141, 37, 'service', 'Knee replacement'),
(142, 37, 'service', 'Physical therapy'),
(143, 37, 'service', 'Surgery'),
(144, 38, 'service', 'Acupuncture'),
(145, 38, 'service', 'Knee replacement'),
(146, 38, 'service', 'Physical therapy'),
(147, 38, 'service', 'Surgery'),
(148, 39, 'service', 'Acupuncture'),
(149, 39, 'service', 'Knee replacement'),
(150, 39, 'service', 'Physical therapy'),
(151, 39, 'service', 'Surgery'),
(152, 40, 'service', 'Acupuncture'),
(153, 40, 'service', 'Knee replacement'),
(154, 40, 'service', 'Physical therapy'),
(155, 40, 'service', 'Surgery'),
(156, 41, 'service', 'Acupuncture'),
(157, 41, 'service', 'Knee replacement'),
(158, 41, 'service', 'Physical therapy'),
(159, 41, 'service', 'Surgery'),
(160, 42, 'service', 'Acupuncture'),
(161, 42, 'service', 'Knee replacement'),
(162, 42, 'service', 'Physical therapy'),
(163, 42, 'service', 'Surgery'),
(164, 43, 'service', 'Acupuncture'),
(165, 43, 'service', 'Knee replacement'),
(166, 43, 'service', 'Physical therapy'),
(167, 43, 'service', 'Surgery'),
(168, 44, 'service', 'Acupuncture'),
(169, 44, 'service', 'Knee replacement'),
(170, 44, 'service', 'Physical therapy'),
(171, 44, 'service', 'Surgery'),
(172, 45, 'service', 'Acupuncture'),
(173, 45, 'service', 'Knee replacement'),
(174, 45, 'service', 'Physical therapy'),
(175, 45, 'service', 'Surgery'),
(176, 46, 'service', 'Acupuncture'),
(177, 46, 'service', 'Knee replacement'),
(178, 46, 'service', 'Physical therapy'),
(179, 46, 'service', 'Surgery'),
(180, 47, 'service', 'Acupuncture'),
(181, 47, 'service', 'Knee replacement'),
(182, 47, 'service', 'Physical therapy'),
(183, 47, 'service', 'Surgery'),
(184, 48, 'service', 'Acupuncture'),
(185, 48, 'service', 'Knee replacement'),
(186, 48, 'service', 'Physical therapy'),
(187, 48, 'service', 'Surgery'),
(188, 49, 'service', 'Acupuncture'),
(189, 49, 'service', 'Knee replacement'),
(190, 49, 'service', 'Physical therapy'),
(191, 49, 'service', 'Surgery'),
(192, 50, 'service', 'Acupuncture'),
(193, 50, 'service', 'Knee replacement'),
(194, 50, 'service', 'Physical therapy'),
(195, 50, 'service', 'Surgery'),
(196, 51, 'service', 'Acupuncture'),
(197, 51, 'service', 'Knee replacement'),
(198, 51, 'service', 'Physical therapy'),
(199, 51, 'service', 'Surgery'),
(200, 52, 'service', 'Acupuncture'),
(201, 52, 'service', 'Knee replacement'),
(202, 52, 'service', 'Physical therapy'),
(203, 52, 'service', 'Surgery'),
(204, 53, 'service', 'Acupuncture'),
(205, 53, 'service', 'Knee replacement'),
(206, 53, 'service', 'Physical therapy'),
(207, 53, 'service', 'Surgery'),
(208, 54, 'service', 'Acupuncture'),
(209, 54, 'service', 'Knee replacement'),
(210, 54, 'service', 'Physical therapy'),
(211, 54, 'service', 'Surgery'),
(212, 55, 'service', 'Acupuncture'),
(213, 55, 'service', 'Knee replacement'),
(214, 55, 'service', 'Physical therapy'),
(215, 55, 'service', 'Surgery'),
(216, 56, 'service', 'Acupuncture'),
(217, 56, 'service', 'Knee replacement'),
(218, 56, 'service', 'Physical therapy'),
(219, 56, 'service', 'Surgery'),
(220, 57, 'service', 'Acupuncture'),
(221, 57, 'service', 'Knee replacement'),
(222, 57, 'service', 'Physical therapy'),
(223, 57, 'service', 'Surgery'),
(224, 58, 'service', 'Acupuncture'),
(225, 58, 'service', 'Knee replacement'),
(226, 58, 'service', 'Physical therapy'),
(227, 58, 'service', 'Surgery'),
(228, 59, 'service', 'Acupuncture'),
(229, 59, 'service', 'Knee replacement'),
(230, 59, 'service', 'Physical therapy'),
(231, 59, 'service', 'Surgery'),
(232, 60, 'service', 'Acupuncture'),
(233, 60, 'service', 'Knee replacement'),
(234, 60, 'service', 'Physical therapy'),
(235, 60, 'service', 'Surgery'),
(236, 61, 'service', 'Acupuncture'),
(237, 61, 'service', 'Knee replacement'),
(238, 61, 'service', 'Physical therapy'),
(239, 61, 'service', 'Surgery'),
(240, 62, 'service', 'Acupuncture'),
(241, 62, 'service', 'Knee replacement'),
(242, 62, 'service', 'Physical therapy'),
(243, 62, 'service', 'Surgery'),
(244, 63, 'service', 'Acupuncture'),
(245, 63, 'service', 'Knee replacement'),
(246, 63, 'service', 'Physical therapy'),
(247, 63, 'service', 'Surgery'),
(248, 64, 'service', 'Acupuncture'),
(249, 64, 'service', 'Knee replacement'),
(250, 64, 'service', 'Physical therapy'),
(251, 64, 'service', 'Surgery'),
(260, 1, 'affiliate', 'Bernardino General Hospital');

-- --------------------------------------------------------

--
-- Table structure for table `Doctors`
--

CREATE TABLE `Doctors` (
  `doctor_id` int(10) UNSIGNED NOT NULL,
  `email_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `middle_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthdate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `specialization` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `complete` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `access_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `Doctors`
--

INSERT INTO `Doctors` (`doctor_id`, `email_address`, `password`, `first_name`, `middle_name`, `last_name`, `gender`, `address`, `contact_number`, `birthdate`, `photo`, `specialization`, `complete`, `access_token`) VALUES
(1, 'rogel@gmail.com', '$2y$10$OX6Z6Nf80NEUJhxNXBsyMuroJkXZ1YyM/8zuH2kZOp5wE.taLDt0e', 'Rogel', 'E', 'Del Rosario', 'M', 'GMA Kamuning, Quezon City', '0906-338-8702', '1976-02-11', NULL, 'General Medical Practice', '1', NULL),
(2, 'noni@gmail.com', '', 'Nullinon', '', 'Vergara', 'M', NULL, '', '09-02-1976', NULL, 'Oncology', '1', NULL),
(3, 'jewelmarquez@yahoo.com', '', 'Jewel Bea', '', 'Marquez', 'F', NULL, '', '03-28-1976', NULL, 'General Medical Practice', '1', NULL),
(4, 'krystalperez@gmail.com', '', 'Krystal', 'A', 'Perez', 'F', NULL, '', '09-29-1980', NULL, 'Anesthesia', '1', NULL),
(5, 'alissacannon@yahoo.com', '', 'Alissa Wanda', '', 'Cannon', 'F', NULL, '', '03-17-1983', NULL, 'Cardiology', '1', NULL),
(6, 'rowenabuchanan@yahoo.com', '', 'Rowena', 'B', 'Buchanan', 'F', NULL, '', '03-16-1972', NULL, 'Dermatology', '1', NULL),
(7, 'valerialopez@gmail.com', '', 'Valeria Candace', '', 'Lopez', 'F', NULL, '', '10-19-1987', NULL, 'Emergency Medicine', '1', NULL),
(8, 'brenttiu@yahoo.com', '', 'Brent', 'C', 'Tiu', 'M', NULL, '', '11-27-1970', NULL, 'Endocrinology', '1', NULL),
(9, 'lucindasapangpalay@gmail.com', '', 'Lucinda', '', 'Sapangpalay', 'F', NULL, '', '06-13-1971', NULL, 'Family Medicine', '1', NULL),
(10, 'goldiejuarez@outlook.com', '', 'Goldie', 'D', 'Juarez', 'F', NULL, '', '09-10-1973', NULL, 'Gastroenterology', '1', NULL),
(11, 'petersontobias@gmail.com', '', 'Peterson', '', 'Tobias', 'M', NULL, '', '03-05-1985', NULL, 'Geatrics', '1', NULL),
(12, 'josesuarez@yahoo.com', '', 'Jose', 'E', 'Suarez', 'M', NULL, '', '05-03-1974', NULL, 'General Surgery', '1', NULL),
(13, 'wayneamar@gmail.com', '', 'Wayne Kyle', '', 'Amar', 'M', NULL, '', '03-13-1983', NULL, 'Hermatology', '1', NULL),
(14, 'leonardopineda@yahoo.com', '', 'Leonardo', ' F', 'Pineda', 'M', NULL, '', '07-25-1985', NULL, 'Infectious Disease', '1', NULL),
(15, 'esmeraldaestrella@yahoo.com', '', 'Esmeralda', 'Y', 'Estrella', 'F', NULL, '', '02-27-1974', NULL, 'Immunology', '1', NULL),
(16, 'markandrew@gmail.com', '', 'Mark Kieran', 'G', 'Andrew', 'M', NULL, '', '08-10-1977', NULL, 'Nephrology', '1', NULL),
(17, 'bartholomealba@outlook.com', '', 'Bartholome', '', 'Alba', 'M', NULL, '', '09-30-1971', NULL, 'Neurology', '1', NULL),
(18, 'mejiawilkins@outlook.com', '', 'Mejia', 'H', 'Wilkins', 'M', NULL, '', '06-02-1986', NULL, 'Nuclear Medicine', '1', NULL),
(19, 'roxiepatrick@outlook.com', '', 'Roxie', 'w', 'Patrick', 'F', NULL, '', '05-01-1980', NULL, 'Obstetrics And Gynecology', '1', NULL),
(20, 'leepark@gmail.com', '', 'Lee', '', 'Park', 'M', NULL, '', '11-07-1981', NULL, 'Occupational Medicine', '1', NULL),
(21, 'susanmercado@gmail.com', '', 'Susan', 'V', 'Mercado', 'F', NULL, '', '09-27-1981', NULL, 'Oncology', '1', NULL),
(22, 'veronicayamamoto@outlook.com', '', 'Veronica', 'J', 'Yamamoto', 'F', NULL, '', '08-13-1979', NULL, 'Ophthalmology', '1', NULL),
(23, 'gretalupita@yahoo.com', '', 'Greta', 'U', 'Lupita', 'F', NULL, '', '10-12-1987', NULL, 'Orthopedics', '1', NULL),
(24, 'suzettedelima@outlook.com', '', 'Suzette', 'K', 'De Lima', 'F', NULL, '', '09-16-1972', NULL, 'Otorhinolaryngology', '1', NULL),
(25, 'connerallen@outlook.com', '', 'Conner', 'T', 'Allen', 'M', NULL, '', '08-09-1984', NULL, 'Pathology', '1', NULL),
(26, 'davidayala@yahoo.com', '', 'David', 'L', 'Ayala', 'M', NULL, '', '11-27-1988', NULL, 'Pediatrics', '1', NULL),
(27, 'conchitagonzales@gmail.com', '', 'Conchita', 'S', 'Gonzales', 'F', NULL, '', '06-09-1972', NULL, 'Physical And Rehabilitation Medicine', '1', NULL),
(28, 'milesdimaano@outlook.com', '', 'Miles', 'M', 'Dimaano', 'M', NULL, '', '05-02-1979', NULL, 'Psychiatry', '1', NULL),
(29, 'kainsalangsang@outlook.com', '', 'Kian', 'R', 'Salangsang', 'M', NULL, '', '02-22-1988', NULL, 'Pulmonology', '1', NULL),
(30, 'annatolentino@yahoo.com', '', 'Annalise', 'N', 'Tolentino', 'F', NULL, '', '05-03-1982', NULL, 'Radiology', '1', NULL),
(31, 'christiandaniel@yahoo.com', '', 'Christian', '', 'Daniel', 'M', NULL, '', '08-10-1973', NULL, 'Rheumatology', '1', NULL),
(32, 'nimrodtorres@outlook.com', '', 'Nimrod', 'O', 'Torres', 'M', NULL, '', '01-17-1987', NULL, 'Urology', '1', NULL),
(33, 'orlandnilooban@outlook.com', '', 'Orland', 'P', 'Nilooban', 'M', NULL, '', '10-11-1970', NULL, 'Dentistry', '1', NULL),
(34, 'jewelmarquez@yahoo.com', '', 'Jewel', 'A', 'Marquez', 'F', NULL, '', '05-05-1983', NULL, 'General Medical Practice', '1', NULL),
(35, 'valenzuelacash@gmail.com', '', 'Valenzuela', 'B', 'Cash', 'M', NULL, '', '01-17-1980', NULL, 'Anesthesia', '1', NULL),
(36, 'housebooker@yahoo.com', '', 'House', 'M', 'Booker', 'M', NULL, '', '09-30-1989', NULL, 'Cardiology', '1', NULL),
(37, 'gretchenchavez@outlook.com', '', 'Gretchen', 'C', 'Chavez', 'F', NULL, '', '11-14-1985', NULL, 'Dermatology', '1', NULL),
(38, 'peggyalvarez@outlook.com', '', 'Peggy Kate', '', 'Alvarez', 'F', NULL, '', '09-21-1973', NULL, 'Emergency Medicine', '1', NULL),
(39, 'christinasexton@yahoo.com', '', 'Christina', 'E', 'Sexton', 'F', NULL, '', '03-22-1988', NULL, 'Endocrinology', '1', NULL),
(40, 'kathiecastro@yahoo.com', '', 'Kathie Jess', '', 'Castro', 'F', NULL, '', '01-31-1981', NULL, 'Family Medicine', '1', NULL),
(41, 'mccormickaguilar@outlook.com', '', 'Mccormick', 'L', 'Aguilar', 'M', NULL, '', '09-15-1988', NULL, 'Gastroenterology', '1', NULL),
(42, 'potterbennett@gmail.com', '', 'Potter', 'F', 'Bennett', 'M', NULL, '', '11-08-1972', NULL, 'Geatrics', '1', NULL),
(43, 'enidstevens@outlook.com', '', 'Enid Carlen', '', 'Stevens', 'F', NULL, '', '08-31-1989', NULL, 'General Surgery', '1', NULL),
(44, 'terrybarker@gmail.com', '', 'Terry Ma', '', 'Barker', 'M', NULL, '', '06-08-1988', NULL, 'Hermatology', '1', NULL),
(45, 'lizzieramos@outlook.com', '', 'Lizzie', 'P', 'Ramos', 'F', NULL, '', '02-10-1975', NULL, 'Infectious Disease', '1', NULL),
(46, 'dorothybray@outlook.com', '', 'Dorothy', 'O', 'Bray', 'F', NULL, '', '07-14-1987', NULL, 'Immunology', '1', NULL),
(47, 'lydiafranklin@outlook.com', '', 'Lydia', 'G', 'Franklin', 'F', NULL, '', '12-01-1981', NULL, 'Nephrology', '1', NULL),
(48, 'bernardball@yahoo.com', '', 'Bernard Arthu', '', 'Ball', 'M', NULL, '', '02-04-1974', NULL, 'Neurology', '1', NULL),
(49, 'mauraweaver@gmail.com', '', 'Maura', 'H', 'Weaver', 'F', NULL, '', '09-05-1977', NULL, 'Nuclear Medicine', '1', NULL),
(50, 'nolaedwards@gmail.com', '', 'Nola Sally', '', 'Edwards', 'F', NULL, '', '02-24-1981', NULL, 'Obstetrics And Gynecology', '1', NULL),
(51, 'thorntonmooney@yahoo.com', '', 'Thornton', 'I', 'Mooney', 'M', NULL, '', '01-05-1982', NULL, 'Occupational Medicine', '1', NULL),
(52, 'jacquelineswanson@gmail.com', '', 'Jacqueline', 'R', 'Swanson', 'F', NULL, '', '04-17-1986', NULL, 'Oncology', '1', NULL),
(53, 'melisapace@gmail.com', '', 'Melisa Hay', '', 'Pace', 'F', NULL, '', '09-23-1988', NULL, 'Ophthalmology', '1', NULL),
(54, 'porterlancaster@gmail.com', '', 'Porter Bill', '', 'Lancaster', 'M', NULL, '', '12-30-1981', NULL, 'Orthopedics', '1', NULL),
(55, 'christieunderwood@gmail.com', '', 'Christie', 'K', 'Underwood', 'F', NULL, '', '12-04-1989', NULL, 'Otorhinolaryngology', '1', NULL),
(56, 'jewellrussell@outlook.com', '', 'Jewell Natasha', '', 'Russell', 'F', NULL, '', '11-23-1986', NULL, 'Pathology', '1', NULL),
(57, 'allysonmendoza@yahoo.com', '', 'Allyson', 'S', 'Mendoza', 'F', NULL, '', '04-20-1972', NULL, 'Pediatrics', '1', NULL),
(58, 'carverhatfield@yahoo.com', '', 'Carver', 'T', 'Hatfield', 'M', NULL, '', '11-04-1984', NULL, 'Physical And Rehabilitation Medicine', '1', NULL),
(59, 'orrmelton@outlook.com', '', 'Orr Ken', '', 'Melton', 'M', NULL, '', '01-30-1973', NULL, 'Psychiatry', '1', NULL),
(60, 'dianaperez@gmail.com', '', 'Diana Mellie', '', 'Perez', 'F', NULL, '', '05-04-1976', NULL, 'Pulmonology', '1', NULL),
(61, 'jennymarshall@gmail.com', '', 'Jenny', 'U', 'Marshall', 'F', NULL, '', '12-01-1977', NULL, 'Radiology', '1', NULL),
(62, 'rebekahrobinson@gmail.com', '', 'Rebekah', 'V', 'Robinson', 'F', NULL, '', '08-14-1979', NULL, 'Rheumatology', '1', NULL),
(63, 'andreaalbert@gmail.com', '', 'Andrea Sam', '', 'Albert', 'F', NULL, '', '08-05-1974', NULL, 'Urology', '1', NULL),
(64, 'gwenbrennan@outlook.com', '', 'Gwen Hayley', '', 'Brennan', 'F', NULL, '', '11-02-1988', NULL, 'Dentistry', '1', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Accounts`
--
ALTER TABLE `Accounts`
  ADD PRIMARY KEY (`account_id`);

--
-- Indexes for table `Appointments`
--
ALTER TABLE `Appointments`
  ADD PRIMARY KEY (`appointment_id`);

--
-- Indexes for table `Clinics`
--
ALTER TABLE `Clinics`
  ADD PRIMARY KEY (`clinic_id`);
ALTER TABLE `Clinics` ADD FULLTEXT KEY `AREA` (`barangay`,`city`);

--
-- Indexes for table `DoctorMeta`
--
ALTER TABLE `DoctorMeta`
  ADD PRIMARY KEY (`meta_id`);

--
-- Indexes for table `Doctors`
--
ALTER TABLE `Doctors`
  ADD PRIMARY KEY (`doctor_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Accounts`
--
ALTER TABLE `Accounts`
  MODIFY `account_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Appointments`
--
ALTER TABLE `Appointments`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=198;

--
-- AUTO_INCREMENT for table `Clinics`
--
ALTER TABLE `Clinics`
  MODIFY `clinic_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT for table `DoctorMeta`
--
ALTER TABLE `DoctorMeta`
  MODIFY `meta_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=261;

--
-- AUTO_INCREMENT for table `Doctors`
--
ALTER TABLE `Doctors`
  MODIFY `doctor_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
