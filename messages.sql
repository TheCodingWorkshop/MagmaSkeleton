-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 17, 2022 at 02:53 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lavacms`
--

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `body` longtext NOT NULL,
  `attachment` varchar(256) DEFAULT NULL,
  `subject` text NOT NULL,
  `status` varchar(24) NOT NULL,
  `is_starred` int(1) NOT NULL DEFAULT 0,
  `receiver` int(10) UNSIGNED NOT NULL,
  `is_marked` int(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `user_id`, `body`, `attachment`, `subject`, `status`, `is_starred`, `receiver`, `is_marked`, `created_at`, `modified_at`) VALUES
(11, 1270, 'We noticed your personal access token, LavaCore, has an outdated format and was used to access the GitHub API on December 30th, 2021 at 00:10 (UTC) with a user-agent header of git-credential-manager (Microsoft Windows NT 6.2.9200.0; Win32NT; x64) CLR/4.0.30319 git-tools/1.19.0.', NULL, 'Hi @TheCodingWorkshop,', 'inbox', 1, 1270, 0, '2022-01-16 21:07:00', '2022-01-17 10:52:09'),
(12, 1270, 'We noticed a new sign-in to your Google Account on a Windows device. If this was you, you don’t need to do anything. If not, we’ll help you secure your account.', NULL, 'A new sign-in on Windows', 'send', 0, 1387, 0, '2022-01-16 21:42:36', NULL),
(13, 1270, 'Optio culpa nihil', NULL, 'Qui voluptatem in qu', 'send', 0, 0, 0, '2022-01-17 10:10:28', NULL),
(14, 1270, 'Enim Nam quasi volup', NULL, 'Aliquid est sint mi', 'send', 0, 0, 0, '2022-01-17 10:10:43', NULL),
(15, 1270, 'Fatal error: Uncaught TypeError: Argument 1 passed to EvoError::exceptionHandler() must be an instance of Exception, instance of Error given in C:xampphtdocsmboneaCoreError.php:31 Stack trace: #0 [internal function]: EvoError::exceptionHandler(Object(Error)) #1 {main} thrown in C:xampphtdocsmboneaCoreError.php on line 31', NULL, 'New MVC I&#39;m working', 'send', 0, 0, 0, '2022-01-17 10:11:42', NULL),
(16, 1270, 'Hello, brother, it&#39;s been a while. I&#39;ve been busy with an office team project, and I still am, but these two days I&#39;ve watched a 6 hour video from thecodeholic, and at this moment, I&#39;m at 05:25:26. He&#39;s going through that process of making the framework installable.\r\n\r\nSo here&#39;s what I thought:\r\n\r\nSince it&#39;s already working in terms of simple routing, authentication, middleware, and bootstrap display, how about once I&#39;m done with this one, I start inserting the Magma framework code, and keep building up from there?\r\n\r\nI think if I go in baby steps like this, by June, I will have an already working project.\r\n\r\nI need your input on this, that&#39;s why I&#39;ve started a new convo.', NULL, 'New MVC I&#39;m working on, from which I will insert Magma modules one by one', 'send', 0, 1270, 0, '2022-01-17 10:15:32', NULL),
(17, 1270, 'Bumps follow-redirects from 1.13.3 to 1.14.7.\r\n\r\nCommits\r\n2ede36d Release version 1.14.7 of the npm package.\r\n8b347cb Drop Cookie header across domains.\r\n6f5029a Release version 1.14.6 of the npm package.\r\naf706be Ignore null headers.\r\nd01ab7a Release version 1.14.5 of the npm package.\r\n40052ea Make compatible with Node 17.\r\n86f7572 Fix: clear internal timer on request abort to avoid leakage\r\n2e1eaf0 Keep Authorization header on subdomain redirects.\r\n2ad9e82 Carry over Host header on relative redirects (#172)\r\n77e2a58 Release version 1.14.4 of the npm package.\r\nAdditional commits viewable in compare view', NULL, '[tafcoder/sleek-dashboard] build(deps): bump follow-redirects from 1.13.3 to 1.14.7 (PR #319)', 'send', 0, 1270, 0, '2022-01-17 10:24:46', NULL),
(18, 1270, 'Duis aut dolore id', NULL, 'Vel rerum est dolore', 'send', 0, 0, 0, '2022-01-17 10:32:48', NULL),
(19, 1270, 'Enim blanditiis quae', NULL, 'Labore irure repelle', 'send', 0, 0, 0, '2022-01-17 10:37:16', NULL),
(20, 1270, 'Tenetur iste omnis r', NULL, 'Aut tenetur veritati', 'send', 0, 0, 0, '2022-01-17 10:42:56', NULL),
(21, 1270, 'Tenetur laborum Qui', NULL, 'Qui sit mollitia ut', 'send', 0, 0, 0, '2022-01-17 10:43:49', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
