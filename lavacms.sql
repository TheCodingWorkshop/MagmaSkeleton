-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 05, 2022 at 04:47 PM
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
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `id` int(10) UNSIGNED NOT NULL,
  `asset_name` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `asset_filename` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `asset_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `asset_slug` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `asset_size` int(10) DEFAULT NULL,
  `asset_filetype` varchar(65) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `asset_path` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL,
  `folder` varchar(24) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_width` int(10) NOT NULL,
  `image_height` int(10) DEFAULT NULL,
  `image_attr` varchar(65) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `created_byid` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `cat_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cat_slug` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cat_parent` int(10) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `created_byid` int(10) UNSIGNED NOT NULL,
  `deleted_at` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `cat_name`, `cat_slug`, `cat_parent`, `created_at`, `modified_at`, `created_byid`, `deleted_at`) VALUES
(10, 'People', 'people', NULL, '2020-07-03 17:58:30', '2022-02-05 15:09:27', 1270, 0);

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_byid` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `phone`, `created_byid`, `created_at`, `modified_at`, `deleted_at`) VALUES
(1, 'The Bakery', '0800-256-9847', 1, '2021-03-07 22:51:37', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `controller_settings`
--

CREATE TABLE `controller_settings` (
  `id` int(10) NOT NULL,
  `controller_menu_id` int(10) UNSIGNED NOT NULL,
  `controller_name` varchar(100) NOT NULL,
  `records_per_page` int(3) DEFAULT NULL,
  `additional_conditions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional_conditions`)),
  `visibility` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `sortable` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `searchable` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `query_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `query` varchar(30) DEFAULT NULL,
  `alias` varchar(10) DEFAULT NULL,
  `filter` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `event_log`
--

CREATE TABLE `event_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `event_log_name` varchar(10) NOT NULL,
  `event_type` varchar(100) NOT NULL,
  `source` tinytext NOT NULL,
  `user` int(10) UNSIGNED NOT NULL,
  `method` varchar(100) NOT NULL,
  `event_context` longtext CHARACTER SET utf8 NOT NULL,
  `event_browser` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `IP` int(4) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `event_log`
--

INSERT INTO `event_log` (`id`, `event_log_name`, `event_type`, `source`, `user`, `method`, `event_context`, `event_browser`, `IP`, `created_at`) VALUES
(123, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:5:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:357;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-12 17:11:17'),
(124, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:5:{s:9:\"menu_name\";s:4:\"user\";s:16:\"menu_description\";s:22:\"user parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:358;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-12 17:15:27'),
(125, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:5:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:359;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-12 17:15:58'),
(126, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:5:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:360;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-12 17:16:03'),
(127, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:5:{s:9:\"menu_name\";s:4:\"menu\";s:16:\"menu_description\";s:22:\"menu parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:361;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-12 17:16:14'),
(128, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:0:\"\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:362;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-12 17:31:10'),
(129, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:363;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-12 17:31:55'),
(130, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"menu\";s:16:\"menu_description\";s:22:\"menu parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:364;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-12 17:32:15'),
(131, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"user\";s:16:\"menu_description\";s:22:\"user parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:365;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-12 17:45:04'),
(132, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:366;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-12 18:45:56'),
(133, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:367;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-12 18:46:01'),
(134, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"setting\";s:16:\"menu_description\";s:25:\"setting parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:368;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-12 19:02:22'),
(135, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"message\";s:16:\"menu_description\";s:25:\"message parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:369;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-15 23:25:56'),
(136, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:370;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 11:29:44'),
(137, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:371;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 11:30:22'),
(138, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:372;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 11:31:44'),
(139, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:373;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 11:35:39'),
(140, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:374;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 11:36:56'),
(141, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:377;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 11:41:14'),
(142, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:379;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 11:43:24'),
(143, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:380;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 11:44:48'),
(144, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"user\";s:16:\"menu_description\";s:22:\"user parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:381;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 11:45:03'),
(145, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:382;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 11:45:14'),
(146, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:383;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 11:52:58'),
(147, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:384;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 11:53:33'),
(148, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:387;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 11:59:12'),
(149, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:388;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:00:25'),
(150, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:389;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:00:49'),
(151, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:390;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:01:32'),
(152, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:391;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:02:25'),
(153, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:392;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:03:22'),
(154, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:393;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:03:45'),
(155, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:394;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:05:33'),
(156, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:395;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:06:00'),
(157, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:396;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:06:30'),
(158, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:397;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:06:41'),
(159, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:398;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:07:59');
INSERT INTO `event_log` (`id`, `event_log_name`, `event_type`, `source`, `user`, `method`, `event_context`, `event_browser`, `IP`, `created_at`) VALUES
(160, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:399;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:08:13'),
(161, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:400;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:09:07'),
(162, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:401;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:37:58'),
(163, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:402;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:38:29'),
(164, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:403;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:46:54'),
(165, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:404;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:48:36'),
(166, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:405;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:48:49'),
(167, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:406;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:50:32'),
(168, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:407;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:51:48'),
(169, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:408;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:54:04'),
(170, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:409;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 12:55:19'),
(171, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:410;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 22:29:24'),
(172, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"user\";s:16:\"menu_description\";s:22:\"user parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:411;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 22:30:52'),
(173, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:412;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 22:31:03'),
(174, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"setting\";s:16:\"menu_description\";s:25:\"setting parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:413;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 22:31:09'),
(175, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"menu\";s:16:\"menu_description\";s:22:\"menu parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:414;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-20 22:31:14'),
(176, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"menu\";s:16:\"menu_description\";s:22:\"menu parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:415;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 12:24:13'),
(177, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"message\";s:16:\"menu_description\";s:25:\"message parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:416;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 12:24:48'),
(178, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:417;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 12:25:27'),
(179, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"menu\";s:16:\"menu_description\";s:22:\"menu parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:418;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 12:27:31'),
(180, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:420;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 12:30:07'),
(181, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:421;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 12:50:13'),
(182, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"setting\";s:16:\"menu_description\";s:25:\"setting parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:422;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 12:50:20'),
(183, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"user\";s:16:\"menu_description\";s:22:\"user parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:423;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 12:50:27'),
(184, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:425;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 13:05:02'),
(185, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"user\";s:16:\"menu_description\";s:22:\"user parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:426;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 13:06:10'),
(186, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:427;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 13:06:40'),
(187, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:428;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 13:06:55'),
(188, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"setting\";s:16:\"menu_description\";s:25:\"setting parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:429;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 13:07:25'),
(189, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:431;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 13:15:50'),
(190, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"user\";s:16:\"menu_description\";s:22:\"user parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:432;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 13:17:22'),
(191, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:433;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 13:17:28'),
(192, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:434;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 13:17:32'),
(193, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"setting\";s:16:\"menu_description\";s:25:\"setting parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:435;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 13:17:37'),
(194, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"menu\";s:16:\"menu_description\";s:22:\"menu parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:436;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 13:17:41'),
(195, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:437;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 14:40:19'),
(196, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:439;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 15:08:53');
INSERT INTO `event_log` (`id`, `event_log_name`, `event_type`, `source`, `user`, `method`, `event_context`, `event_browser`, `IP`, `created_at`) VALUES
(197, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:441;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 15:19:30'),
(198, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"user\";s:16:\"menu_description\";s:22:\"user parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:442;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 15:23:39'),
(199, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"menu\";s:16:\"menu_description\";s:22:\"menu parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:443;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 15:31:38'),
(200, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:445;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 15:54:37'),
(201, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"user\";s:16:\"menu_description\";s:22:\"user parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:446;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 15:54:43'),
(202, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:447;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 15:54:50'),
(203, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:448;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 15:54:54'),
(204, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"setting\";s:16:\"menu_description\";s:25:\"setting parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:449;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 15:54:58'),
(205, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"menu\";s:16:\"menu_description\";s:22:\"menu parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:450;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 15:55:01'),
(206, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:451;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-22 16:32:08'),
(207, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:5:\"group\";s:16:\"menu_description\";s:23:\"group parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:452;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-23 00:08:25'),
(208, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"message\";s:16:\"menu_description\";s:25:\"message parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:453;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-23 00:26:18'),
(209, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:454;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-23 10:55:05'),
(210, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"user\";s:16:\"menu_description\";s:22:\"user parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:455;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-23 10:55:15'),
(211, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:5:\"group\";s:16:\"menu_description\";s:23:\"group parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:456;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-23 10:55:21'),
(212, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:457;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-23 10:55:25'),
(213, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:458;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-23 10:55:29'),
(214, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"menu\";s:16:\"menu_description\";s:22:\"menu parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:459;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-23 10:55:50'),
(215, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"setting\";s:16:\"menu_description\";s:25:\"setting parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:460;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-23 10:55:55'),
(216, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"message\";s:16:\"menu_description\";s:25:\"message parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:462;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-23 20:33:14'),
(217, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:6:\"ticket\";s:16:\"menu_description\";s:24:\"ticket parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:463;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-23 20:52:15'),
(218, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:6:\"system\";s:16:\"menu_description\";s:24:\"system parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:464;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-25 11:18:36'),
(219, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:465;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-27 21:35:21'),
(220, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:466;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-27 21:38:50'),
(221, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:467;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-27 21:43:43'),
(222, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"user\";s:16:\"menu_description\";s:22:\"user parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:468;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-27 21:45:14'),
(223, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:470;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-27 21:47:15'),
(224, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:471;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-27 21:47:25'),
(225, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"menu\";s:16:\"menu_description\";s:22:\"menu parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:472;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-27 21:47:32'),
(226, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"setting\";s:16:\"menu_description\";s:25:\"setting parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:473;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-27 21:47:51'),
(227, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"message\";s:16:\"menu_description\";s:25:\"message parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:474;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-27 21:48:34'),
(228, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:6:\"ticket\";s:16:\"menu_description\";s:24:\"ticket parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:475;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-01-27 21:48:39'),
(229, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"post\";s:16:\"menu_description\";s:22:\"post parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:476;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-01 05:40:35'),
(230, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:8:\"category\";s:16:\"menu_description\";s:26:\"category parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:477;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-02 21:32:26');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `group_name` varchar(64) NOT NULL,
  `group_description` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `created_byid` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `group_role`
--

CREATE TABLE `group_role` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `group_role`
--

INSERT INTO `group_role` (`role_id`, `group_id`) VALUES
(151, 2);

-- --------------------------------------------------------

--
-- Table structure for table `localisations`
--

CREATE TABLE `localisations` (
  `id` int(10) UNSIGNED NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `locale` varchar(20) NOT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_size` float DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `localisations`
--

INSERT INTO `localisations` (`id`, `file_name`, `locale`, `file_path`, `file_size`, `created_at`, `modified_at`) VALUES
(13, 'english', 'gb', 'C:\\xampp\\htdocs\\MagmaSkeleton/Localegb.yml', NULL, '2022-01-25 22:23:26', NULL),
(14, 'french', 'fr', 'C:\\xampp\\htdocs\\MagmaSkeleton/Localepassword.yml', NULL, '2022-01-26 00:21:02', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `menu_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_menu` tinyint(1) NOT NULL,
  `menu_order` int(10) DEFAULT NULL,
  `menu_break_point` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL,
  `menu_icon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` int(1) DEFAULT 0,
  `created_byid` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `menu_name`, `menu_description`, `parent_menu`, `menu_order`, `menu_break_point`, `menu_icon`, `created_at`, `modified_at`, `deleted_at`, `created_byid`) VALUES
(467, 'dashboard', 'dashboard parent menu item.', 1, NULL, NULL, 'alert', '2022-01-27 21:43:43', NULL, 0, 0),
(468, 'user', 'user parent menu item.', 1, NULL, NULL, 'alert', '2022-01-27 21:45:14', NULL, 0, 0),
(469, 'group', 'group parent menu item.', 1, NULL, NULL, 'alert', '2022-01-27 21:46:46', NULL, 0, 0),
(470, 'role', 'role parent menu item.', 1, NULL, NULL, 'alert', '2022-01-27 21:47:15', NULL, 0, 0),
(471, 'permission', 'permission parent menu item.', 1, NULL, NULL, 'alert', '2022-01-27 21:47:25', NULL, 0, 0),
(472, 'menu', 'menu parent menu item.', 1, NULL, NULL, 'alert', '2022-01-27 21:47:32', NULL, 0, 0),
(473, 'setting', 'setting parent menu item.', 1, NULL, NULL, 'alert', '2022-01-27 21:47:51', NULL, 0, 0),
(474, 'message', 'message parent menu item.', 1, NULL, NULL, 'alert', '2022-01-27 21:48:34', NULL, 0, 0),
(475, 'ticket', 'ticket parent menu item.', 1, NULL, NULL, 'alert', '2022-01-27 21:48:39', NULL, 0, 0),
(476, 'post', 'post parent menu item.', 1, NULL, NULL, 'alert', '2022-02-01 05:40:35', NULL, 0, 0),
(477, 'category', 'category parent menu item.', 1, NULL, NULL, 'alert', '2022-02-02 21:32:26', NULL, 0, 0),
(478, 'tag', 'tag parent menu item.', 1, NULL, NULL, 'alert', '2022-02-04 03:41:39', NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `item_original_id` int(10) UNSIGNED DEFAULT NULL,
  `item_original_label` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_label` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_type` varchar(24) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_url` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_order` int(10) DEFAULT NULL,
  `item_usable` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`id`, `item_original_id`, `item_original_label`, `item_label`, `item_type`, `item_url`, `item_order`, `item_usable`) VALUES
(1807, 467, 'dashboard_indexAction', 'index', 'child_of_dashboard', '/admin/dashboard/index', 0, 1),
(1808, 467, 'dashboard_datetimeAction', 'datetime', 'child_of_dashboard', '/admin/dashboard/datetime', 0, NULL),
(1809, 467, 'dashboard_changeRowsAction', 'changeRows', 'child_of_dashboard', '/admin/dashboard/changerows', 0, NULL),
(1810, 467, 'dashboard_settingsAction', 'settings', 'child_of_dashboard', '/admin/dashboard/settings', 0, NULL),
(1811, 468, 'user_indexAction', 'index', 'child_of_user', '/admin/user/index', 0, 1),
(1812, 468, 'user_overviewAction', 'overview', 'child_of_user', '/admin/user/overview', 0, NULL),
(1813, 468, 'user_showAction', 'show', 'child_of_user', '/admin/user/show', 0, NULL),
(1814, 468, 'user_newAction', 'new', 'child_of_user', '/admin/user/new', 0, 1),
(1815, 468, 'user_editAction', 'edit', 'child_of_user', '/admin/user/edit', 0, NULL),
(1816, 468, 'user_deleteAction', 'delete', 'child_of_user', '/admin/user/delete', 0, NULL),
(1817, 468, 'user_cloneAction', 'clone', 'child_of_user', '/admin/user/clone', 0, NULL),
(1818, 468, 'user_hardDeleteAction', 'hardDelete', 'child_of_user', '/admin/user/harddelete', 0, NULL),
(1819, 468, 'user_bulkAction', 'bulk', 'child_of_user', '/admin/user/bulk', 0, NULL),
(1820, 468, 'user_bulkDeleteAction', 'bulkDelete', 'child_of_user', '/admin/user/bulkdelete', 0, NULL),
(1821, 468, 'user_bulkCloneAction', 'bulkClone', 'child_of_user', '/admin/user/bulkclone', 0, NULL),
(1822, 468, 'user_bulkUnlockAllAction', 'bulkUnlockAll', 'child_of_user', '/admin/user/bulkunlockall', 0, NULL),
(1823, 468, 'user_lockAction', 'lock', 'child_of_user', '/admin/user/lock', 0, NULL),
(1824, 468, 'user_unlockAction', 'unlock', 'child_of_user', '/admin/user/unlock', 0, NULL),
(1825, 468, 'user_trashAction', 'trash', 'child_of_user', '/admin/user/trash', 0, NULL),
(1826, 468, 'user_trashRestoreAction', 'trashRestore', 'child_of_user', '/admin/user/trashrestore', 0, NULL),
(1827, 468, 'user_activeAction', 'active', 'child_of_user', '/admin/user/active', 0, NULL),
(1828, 468, 'user_preferencesAction', 'preferences', 'child_of_user', '/admin/user/preferences', 0, NULL),
(1829, 468, 'user_privilegeAction', 'privilege', 'child_of_user', '/admin/user/privilege', 0, NULL),
(1830, 468, 'user_privilegeExpirationAction', 'privilegeExpiration', 'child_of_user', '/admin/user/privilegeexpiration', 0, NULL),
(1831, 468, 'user_logAction', 'log', 'child_of_user', '/admin/user/log', 0, 1),
(1832, 468, 'user_notesAction', 'notes', 'child_of_user', '/admin/user/notes', 0, NULL),
(1833, 468, 'user_personalAction', 'personal', 'child_of_user', '/admin/user/personal', 0, NULL),
(1834, 468, 'user_changeRowsAction', 'changeRows', 'child_of_user', '/admin/user/changerows', 0, NULL),
(1835, 468, 'user_settingsAction', 'settings', 'child_of_user', '/admin/user/settings', 0, NULL),
(1836, 469, 'group_indexAction', 'index', 'child_of_group', '/admin/group/index', 0, 1),
(1837, 469, 'group_newAction', 'new', 'child_of_group', '/admin/group/new', 0, 1),
(1838, 469, 'group_editAction', 'edit', 'child_of_group', '/admin/group/edit', 0, NULL),
(1839, 469, 'group_deleteAction', 'delete', 'child_of_group', '/admin/group/delete', 0, NULL),
(1840, 469, 'group_assignedAction', 'assigned', 'child_of_group', '/admin/group/assigned', 0, NULL),
(1841, 469, 'group_changeRowsAction', 'changeRows', 'child_of_group', '/admin/group/changerows', 0, NULL),
(1842, 469, 'group_settingsAction', 'settings', 'child_of_group', '/admin/group/settings', 0, NULL),
(1843, 470, 'role_indexAction', 'index', 'child_of_role', '/admin/role/index', 0, 1),
(1844, 470, 'role_newAction', 'new', 'child_of_role', '/admin/role/new', 0, 1),
(1845, 470, 'role_editAction', 'edit', 'child_of_role', '/admin/role/edit', 0, NULL),
(1846, 470, 'role_deleteAction', 'delete', 'child_of_role', '/admin/role/delete', 0, NULL),
(1847, 470, 'role_bulkAction', 'bulk', 'child_of_role', '/admin/role/bulk', 0, NULL),
(1848, 470, 'role_bulkDeleteAction', 'bulkDelete', 'child_of_role', '/admin/role/bulkdelete', 0, NULL),
(1849, 470, 'role_bulkCloneAction', 'bulkClone', 'child_of_role', '/admin/role/bulkclone', 0, NULL),
(1850, 470, 'role_assignedAction', 'assigned', 'child_of_role', '/admin/role/assigned', 0, NULL),
(1851, 470, 'role_logAction', 'log', 'child_of_role', '/admin/role/log', 0, 1),
(1852, 470, 'role_unassignPermissionAction', 'unassignPermission', 'child_of_role', '/admin/role/unassignpermission', 0, NULL),
(1853, 470, 'role_changeRowsAction', 'changeRows', 'child_of_role', '/admin/role/changerows', 0, NULL),
(1854, 470, 'role_settingsAction', 'settings', 'child_of_role', '/admin/role/settings', 0, NULL),
(1855, 471, 'permission_indexAction', 'index', 'child_of_permission', '/admin/permission/index', 0, 1),
(1856, 471, 'permission_newAction', 'new', 'child_of_permission', '/admin/permission/new', 0, 1),
(1857, 471, 'permission_editAction', 'edit', 'child_of_permission', '/admin/permission/edit', 0, NULL),
(1858, 471, 'permission_deleteAction', 'delete', 'child_of_permission', '/admin/permission/delete', 0, NULL),
(1859, 471, 'permission_bulkAction', 'bulk', 'child_of_permission', '/admin/permission/bulk', 0, NULL),
(1860, 471, 'permission_bulkDeleteAction', 'bulkDelete', 'child_of_permission', '/admin/permission/bulkdelete', 0, NULL),
(1861, 471, 'permission_bulkCloneAction', 'bulkClone', 'child_of_permission', '/admin/permission/bulkclone', 0, NULL),
(1862, 471, 'permission_changeRowsAction', 'changeRows', 'child_of_permission', '/admin/permission/changerows', 0, NULL),
(1863, 471, 'permission_settingsAction', 'settings', 'child_of_permission', '/admin/permission/settings', 0, NULL),
(1864, 472, 'menu_trashAction', 'trash', 'child_of_menu', '/admin/menu/trash', 0, NULL),
(1865, 472, 'menu_indexAction', 'index', 'child_of_menu', '/admin/menu/index', 0, 1),
(1866, 472, 'menu_newAction', 'new', 'child_of_menu', '/admin/menu/new', 0, 1),
(1867, 472, 'menu_editAction', 'edit', 'child_of_menu', '/admin/menu/edit', 0, NULL),
(1868, 472, 'menu_deleteAction', 'delete', 'child_of_menu', '/admin/menu/delete', 0, NULL),
(1869, 472, 'menu_removeItemAction', 'removeItem', 'child_of_menu', '/admin/menu/removeitem', 0, NULL),
(1870, 472, 'menu_changeRowsAction', 'changeRows', 'child_of_menu', '/admin/menu/changerows', 0, NULL),
(1871, 472, 'menu_settingsAction', 'settings', 'child_of_menu', '/admin/menu/settings', 0, NULL),
(1872, 473, 'setting_indexAction', 'index', 'child_of_setting', '/admin/setting/index', 0, 1),
(1873, 473, 'setting_generalAction', 'general', 'child_of_setting', '/admin/setting/general', 0, NULL),
(1874, 473, 'setting_securityAction', 'security', 'child_of_setting', '/admin/setting/security', 0, NULL),
(1875, 473, 'setting_purgeAction', 'purge', 'child_of_setting', '/admin/setting/purge', 0, NULL),
(1876, 473, 'setting_toolsAction', 'tools', 'child_of_setting', '/admin/setting/tools', 0, NULL),
(1877, 473, 'setting_localisationAction', 'localisation', 'child_of_setting', '/admin/setting/localisation', 0, NULL),
(1878, 473, 'setting_brandingAction', 'branding', 'child_of_setting', '/admin/setting/branding', 0, NULL),
(1879, 473, 'setting_extensionAction', 'extension', 'child_of_setting', '/admin/setting/extension', 0, NULL),
(1880, 473, 'setting_applicationAction', 'application', 'child_of_setting', '/admin/setting/application', 0, NULL),
(1881, 473, 'setting_changeRowsAction', 'changeRows', 'child_of_setting', '/admin/setting/changerows', 0, NULL),
(1882, 473, 'setting_settingsAction', 'settings', 'child_of_setting', '/admin/setting/settings', 0, NULL),
(1883, 474, 'message_indexAction', 'index', 'child_of_message', '/admin/message/index', 0, 1),
(1884, 474, 'message_newAction', 'new', 'child_of_message', '/admin/message/new', 0, 1),
(1885, 474, 'message_showAction', 'show', 'child_of_message', '/admin/message/show', 0, NULL),
(1886, 474, 'message_replyAction', 'reply', 'child_of_message', '/admin/message/reply', 0, NULL),
(1887, 474, 'message_forwardAction', 'forward', 'child_of_message', '/admin/message/forward', 0, NULL),
(1888, 474, 'message_starredAction', 'starred', 'child_of_message', '/admin/message/starred', 0, NULL),
(1889, 474, 'message_unstarredAction', 'unstarred', 'child_of_message', '/admin/message/unstarred', 0, NULL),
(1890, 474, 'message_markedAction', 'marked', 'child_of_message', '/admin/message/marked', 0, NULL),
(1891, 474, 'message_unmarkedAction', 'unmarked', 'child_of_message', '/admin/message/unmarked', 0, NULL),
(1892, 474, 'message_changeRowsAction', 'changeRows', 'child_of_message', '/admin/message/changerows', 0, NULL),
(1893, 474, 'message_settingsAction', 'settings', 'child_of_message', '/admin/message/settings', 0, NULL),
(1894, 475, 'ticket_indexAction', 'index', 'child_of_ticket', '/admin/ticket/index', 0, 1),
(1895, 475, 'ticket_newAction', 'new', 'child_of_ticket', '/admin/ticket/new', 0, 1),
(1896, 475, 'ticket_editAction', 'edit', 'child_of_ticket', '/admin/ticket/edit', 0, NULL),
(1897, 475, 'ticket_changeRowsAction', 'changeRows', 'child_of_ticket', '/admin/ticket/changerows', 0, NULL),
(1898, 475, 'ticket_settingsAction', 'settings', 'child_of_ticket', '/admin/ticket/settings', 0, NULL),
(1899, 476, 'post_indexAction', 'index', 'child_of_post', '/admin/post/index', 0, 1),
(1900, 476, 'post_changeRowsAction', 'changeRows', 'child_of_post', '/admin/post/changerows', 0, NULL),
(1901, 476, 'post_settingsAction', 'settings', 'child_of_post', '/admin/post/settings', 0, NULL),
(1902, 477, 'category_indexAction', 'index', 'child_of_category', '/admin/category/index', 0, 1),
(1903, 477, 'category_newAction', 'new', 'child_of_category', '/admin/category/new', 0, 1),
(1904, 477, 'category_changeRowsAction', 'changeRows', 'child_of_category', '/admin/category/changerows', 0, NULL),
(1905, 477, 'category_settingsAction', 'settings', 'child_of_category', '/admin/category/settings', 0, NULL),
(1906, 478, 'tag_indexAction', 'index', 'child_of_tag', '/admin/tag/index', 0, 1),
(1907, 478, 'tag_newAction', 'new', 'child_of_tag', '/admin/tag/new', 0, 1),
(1908, 478, 'tag_editAction', 'edit', 'child_of_tag', '/admin/tag/edit', 0, NULL),
(1909, 478, 'tag_trashAction', 'trash', 'child_of_tag', '/admin/tag/trash', 0, NULL),
(1910, 478, 'tag_untrashAction', 'untrash', 'child_of_tag', '/admin/tag/untrash', 0, NULL),
(1911, 478, 'tag_hardDeleteAction', 'hardDelete', 'child_of_tag', '/admin/tag/harddelete', 0, NULL),
(1912, 478, 'tag_multipleAction', 'multiple', 'child_of_tag', '/admin/tag/multiple', 0, NULL),
(1913, 478, 'tag_changeRowsAction', 'changeRows', 'child_of_tag', '/admin/tag/changerows', 0, NULL),
(1914, 478, 'tag_settingsAction', 'settings', 'child_of_tag', '/admin/tag/settings', 0, NULL);

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
(23, 1270, 'Hello,\r\n\r\nWe have great news! Your subscription includes DataSpell, a new tool for data scientists.\r\n\r\nDataSpell is an IDE designed specifically for those involved in exploratory data analysis and prototyping ML models. DataSpell combines the interactivity of Jupyter notebooks with the intelligent Python and R coding assistance of PyCharm in one convenient environment.', NULL, 'Your subscription includes a new tool – DataSpell', 'sent', 1, 1270, 0, '2022-01-23 23:20:13', '2022-02-01 21:34:58');

-- --------------------------------------------------------

--
-- Table structure for table `metadata`
--

CREATE TABLE `metadata` (
  `post_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `keywords` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `robots` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'index'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration_name` varchar(65) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration_name`, `created_at`, `modified_at`) VALUES
(1, 'm239356a02513f99345bcbbd908b4e1bfa7e180f160d9115e9b5e5f66b3e1e8f0', '2021-04-15 21:48:16', NULL),
(2, 'm44d7e693abb227b9a2186af0d62df324ca3c8d89ce0fa703348dc9f22fa1b005', '2021-04-15 21:48:16', NULL),
(3, 'm60117464348516685df2faf89b2b6d70663d64511f76395569444a1bcb4babb9', '2021-04-15 21:48:16', NULL),
(4, 'm9585f98d0b086be9e0dcd25e0c4db4d61496ab4c7e2493f9e0e72ab2eb9c17d8', '2021-04-15 21:48:16', NULL),
(5, 'ma15612338cd498432a5aa7ff98c9c309632f1e8f73a2e8a8fcc16ee122d1ec3a', '2021-04-15 21:48:16', NULL),
(6, 'me5586ad6449afbb0721c52ea3935931eca396eb214d8632ce9cbf96ea508ca42', '2021-04-15 21:48:16', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `notify_title` varchar(190) NOT NULL,
  `notify_type` varchar(30) NOT NULL,
  `notify_status` varchar(10) NOT NULL,
  `notifier` varchar(190) NOT NULL,
  `notify_description` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_byid` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `notify_title`, `notify_type`, `notify_status`, `notifier`, `notify_description`, `created_at`, `created_byid`) VALUES
(1, 'New user created', 'system', 'unread', 'admin', 'a new user was created by Ricardo Miller who is superadmin', '2021-07-22 18:24:53', 1),
(2, 'New account created from control panel', 'system', 'unread', 'admin', 'Ricardo Miller created a new account for Christen Obrien', '2021-07-22 23:20:05', 1),
(3, 'Ricardo Miller updated Christen Obrien user account', 'system', 'unread', 'admin', 'Ricardo Miller created a new account for Christen Obrien', '2021-07-22 23:46:32', 1),
(4, 'New account created from control panel', 'system', 'read', 'admin', 'Ricardo Miller created a new account for Adara Solis', '2021-07-23 00:26:01', 1),
(5, 'New account created from control panel', 'system', 'unread', 'admin', 'Ricardo Miller created a new account for Sharon Stone', '2021-07-23 12:23:27', 1),
(6, 'New account created from control panel', 'system', 'unread', 'admin', 'Ricardo Miller created a new account for Brennan Hill', '2021-07-25 13:58:34', 1),
(7, 'New account created from control panel', 'system', 'unread', 'admin', 'Ricardo Miller created a new account for Yuli Newton', '2021-07-26 22:28:20', 1),
(8, 'New account created from control panel', 'system', 'unread', 'admin', 'Ricardo Miller created a new account for Ivana Eaton', '2021-07-27 12:20:21', 1),
(9, 'New account created from control panel', 'system', 'unread', 'admin', 'Ricardo Miller created a new account for Hoyt Pitts', '2021-07-27 15:28:31', 1),
(10, 'New account created from control panel', 'system', 'unread', 'admin', 'Ricardo Miller created a new account for Rogan Strong', '2021-07-27 15:43:58', 1),
(11, 'New account created from control panel', 'system', 'unread', 'admin', 'Ricardo Miller created a new account for Carter Woods', '2021-07-27 15:59:01', 1),
(12, 'New account created from control panel', 'system', 'unread', 'admin', 'Ricardo Miller created a new account for Amethyst Logan', '2021-07-27 16:00:02', 1),
(13, 'New account created from control panel', 'system', 'unread', 'admin', 'Ricardo Miller created a new account for Xerxes Franco', '2021-07-27 16:02:14', 1),
(14, 'New account created from control panel', 'system', 'unread', 'admin', 'Ricardo Miller created a new account for Angelica Byers', '2021-07-27 16:26:41', 1);

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(190) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(190) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(190) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `author` int(10) UNSIGNED DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `template` int(10) UNSIGNED DEFAULT NULL,
  `status` varchar(24) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `visible` varchar(24) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `extras` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent` int(10) DEFAULT NULL,
  `page_order` int(10) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `permission_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission_description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `created_byid` int(10) UNSIGNED DEFAULT NULL,
  `deleted_at` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `permission_name`, `permission_description`, `created_at`, `modified_at`, `created_byid`, `deleted_at`) VALUES
(72, 'can_add_user', 'allows to create new user', '2021-07-03 16:25:09', '2021-07-16 22:57:46', 1, 0),
(73, 'can_edit_user', 'Allows to edit a user', '2021-07-03 16:25:43', '2021-07-16 22:57:08', 1, 0),
(74, 'can_delete_user', 'Allows to delete a user', '2021-07-03 16:25:59', '2021-07-16 22:57:00', 1, 0),
(76, 'have_admin_access', 'Basic permission for accessing the admin panel', '2021-07-07 14:20:26', '2021-07-16 23:01:40', 1, 0),
(77, 'basic_access', 'Permission which allow basic access for all subscriber and user', '2021-07-07 14:31:15', '2022-02-05 14:05:28', 1270, 0),
(78, 'can_log_user', 'Permission which allows a user to manage the user logs', '2021-07-07 14:37:51', '2021-07-16 22:58:46', 1, 0),
(79, 'can_view_statistics_user', 'Permissions which allows viewing the user statistics', '2021-07-07 14:41:41', '2021-07-17 08:13:31', 1, 0),
(81, 'can_show_user', 'Permission for showing a single use row', '2021-07-09 00:46:41', '2021-07-16 22:57:27', 1, 0),
(82, 'can_view_user', 'access to use index', '2021-07-14 10:25:17', '2021-07-16 22:10:20', 1, 0),
(84, 'can_edit_privilege_user', 'Allows to edit the user privilege', '2021-07-16 23:05:19', '2021-07-17 08:12:29', 1, 0),
(85, 'can_add_permission', 'Allow adding of new permissions', '2021-07-17 07:58:56', NULL, 1, 0),
(86, 'can_view_permission', 'Allow to view the table of permission', '2021-07-17 07:59:20', NULL, 1, 0),
(87, 'can_edit_permission', 'Allows to edit a permission', '2021-07-17 07:59:36', NULL, 1, 0),
(88, 'can_delete_permission', 'Allows to delete a permission', '2021-07-17 07:59:55', '2021-07-25 00:14:26', 1, 0),
(89, 'can_log_permisson', 'Allows to view and modify the permission log', '2021-07-17 08:00:31', NULL, 1, 0),
(91, 'can_view_role', 'Allows to view the roles table', '2021-07-17 08:01:29', NULL, 1, 0),
(92, 'can_edit_role', 'Allows to edit a role', '2021-07-17 08:01:42', NULL, 1, 0),
(93, 'can_delete_role', 'Allows to delete a role', '2021-07-17 08:01:58', NULL, 1, 0),
(94, 'can_assign_role', 'Allows to assign a group of permissions to a role', '2021-07-17 08:02:32', NULL, 1, 0),
(95, 'can_remove_assignment_role', 'Allows to remove permission from a role', '2021-07-17 08:03:38', '2021-07-17 08:13:02', 1, 0),
(96, 'can_log_role', 'Allows to view and modify role log', '2021-07-17 08:08:48', NULL, 1, 0),
(97, 'can_set_privilege_expiration_user', 'Allows to set an expiration for a privilege', '2021-07-17 08:14:03', NULL, 1, 0),
(98, 'can_view_dashboard', 'Allows to view the admin dashboard', '2021-07-17 08:20:11', NULL, 1, 0),
(99, 'can_edit_menu', 'Allows to edit controller menu', '2021-07-18 14:10:56', NULL, 1, 0),
(100, 'can_view_menu', 'Allows to view menu table', '2021-07-18 21:21:31', NULL, 1, 0),
(103, 'can_trash_user', 'Allows to view and delete user trash', '2021-07-18 23:28:51', NULL, 1, 0),
(104, 'can_edit_preferences_user', 'Allows to edit user preferences', '2021-07-19 11:08:37', '2021-07-19 11:10:06', 1, 0),
(105, 'can_edit_general_setting', 'Allows to edit the system general settings', '2021-07-20 00:44:50', NULL, 1, 0),
(106, 'can_edit_purge_setting', 'Allows editing purge setting', '2021-07-20 14:17:08', NULL, 1, 0),
(107, 'can_edit_security_setting', 'Allows editing security setting', '2021-07-20 14:18:02', NULL, 1, 0),
(108, 'can_edit_tool_setting', 'Allows editing tool setting', '2021-07-20 14:18:25', NULL, 1, 0),
(109, 'can_add_menu', 'Allows to add new controller menu updated!', '2021-07-21 22:54:02', '2022-02-05 14:05:28', 1, 0),
(110, 'can_edit_files', 'Allows to edit core yaml files', '2021-07-22 12:09:35', NULL, 1, 0),
(111, 'can_view_notification', 'Allows to view the notification table', '2021-07-22 18:19:37', '2021-07-22 18:21:44', 1, 0),
(112, 'can_add_notification', 'Allows to add notifications', '2021-07-22 19:51:22', '2022-02-05 14:05:28', 1, 0),
(113, 'can_edit_notification', 'Allows to edit notification', '2021-07-22 19:59:12', NULL, 1, 0),
(114, 'can_edit_theme', '', '2021-07-25 00:12:44', NULL, 1, 0),
(117, 'can_hard_delete_user', 'Allows to permanently delete a user account from the database', '2021-07-27 15:09:51', NULL, 1, 0),
(118, 'can_restore_trash_user', 'Allows user to manage user trash', '2021-07-28 20:50:00', NULL, 1, 0),
(119, 'can_lock_user', 'Allows to lock and unlock a user account', '2021-07-29 08:07:52', NULL, 1, 0),
(120, 'can_unlock_user', 'Allows to unlock locked user account', '2021-07-29 18:55:29', NULL, 1, 0),
(121, 'can_change_status_user', 'Allows to change an account status', '2021-07-30 08:42:56', NULL, 1, 0),
(124, 'can_add_role', 'Allow to add roles to system', '2021-08-09 10:18:56', NULL, 1, 0),
(128, 'can_edit_theme_delete', 'can edit theme delete', '2021-09-10 10:42:03', NULL, 1, 0),
(129, 'can_banter', 'can banter permission', '2021-09-10 10:56:10', NULL, 1, 0),
(131, 'can_bulk_delete_user', 'Can  carry out bulk deletion of users', '2021-09-21 19:25:10', NULL, 1270, 0),
(132, 'can_bulk_clone_user', 'Can bulk clone user accounts', '2021-09-22 11:16:10', NULL, 1270, 0),
(133, 'can_clone_user', 'Can clone a single user account', '2021-09-22 22:13:12', NULL, 1270, 0),
(135, 'can_edit_own_account', 'Allow backend user to edit their own account', '2022-01-04 16:28:14', NULL, 1270, 0),
(137, 'can_order', 'dscee', '2022-01-12 20:23:14', NULL, 1270, 0),
(138, 'can_view_message', 'Permission for viewing messages', '2022-01-16 19:52:47', NULL, 1270, 0),
(139, 'cn_bulk_delete_role', 'Can bulk delete roles', '2022-01-18 16:43:52', NULL, 1270, 0),
(140, 'can_bulk_delete_permission', 'Can bulk delete permission', '2022-01-18 16:44:12', NULL, 1270, 0),
(142, 'can_bulk_delete_role', '', '2022-01-18 21:11:59', NULL, 1270, 0),
(143, 'Serena Solomon', 'Dolor vitae consequa', '2022-01-20 22:32:03', NULL, 1270, 0),
(144, 'test_perm', 'fregeffefe', '2022-01-22 16:05:50', NULL, 1270, 0),
(145, 'can_view_group', 'Can view the permission group table', '2022-01-23 00:17:51', NULL, 1270, 0),
(146, 'can_add_group', '', '2022-01-23 00:33:57', '2022-02-05 14:05:28', 1270, 0),
(147, 'can_edit_group', 'Allows to edit and manage all user account', '2022-01-23 00:43:14', NULL, 1270, 0),
(148, 'can_delete_group', '', '2022-01-23 00:45:58', NULL, 1270, 0),
(149, 'can_log_group', '', '2022-01-23 00:48:02', NULL, 1270, 0),
(150, 'can_assign_group', '', '2022-01-23 11:49:19', NULL, 1270, 0),
(151, 'can_view_ticket', '', '2022-01-23 19:15:33', NULL, 1270, 0),
(152, 'can_add_ticket', '', '2022-01-23 19:15:46', NULL, 1270, 0),
(153, 'can_new_ticket', '', '2022-01-23 19:15:54', NULL, 1270, 0),
(154, 'can_edit_ticket', '', '2022-01-23 19:16:06', NULL, 1270, 0),
(155, 'can_delete_ticket', '', '2022-01-23 19:16:22', NULL, 1270, 0),
(156, 'can_delete_menu', 'can delete menu', '2022-01-27 21:39:10', NULL, 1270, 0),
(157, 'can_view_post', 'Can View post articles', '2022-02-02 00:35:07', NULL, 1270, 0),
(158, 'can_add_post', 'Can add a post article', '2022-02-02 00:35:21', NULL, 1270, 0),
(159, 'can_edit_post', 'Can edit a post article', '2022-02-02 00:35:33', NULL, 1270, 0),
(160, 'can_delete_post', 'Can delete a post article', '2022-02-02 00:35:58', NULL, 1270, 0),
(161, 'can_trash_post', 'Can put post in trash', '2022-02-02 00:36:14', NULL, 1270, 0),
(162, 'can_add_category', 'Allow to add new categories', '2022-02-02 15:42:28', '2022-02-05 14:05:28', 1270, 0),
(163, 'can_edit_category', 'Can edit a category', '2022-02-02 15:42:47', NULL, 1270, 0),
(164, 'can_delete_category', 'can delete category', '2022-02-02 15:43:07', NULL, 1270, 0),
(165, 'can_view_category', 'Can view the category listings', '2022-02-02 15:43:27', NULL, 1270, 0),
(166, 'can_trash_category', 'Allow to trash the queried category', '2022-02-03 01:26:24', NULL, 1270, 0),
(167, 'can_bulk_restore_category', '', '2022-02-04 00:41:09', NULL, 1270, 0),
(168, 'can_bulk_delete_category', '', '2022-02-04 00:58:51', NULL, 1270, 0),
(169, 'can_untrash_category', '', '2022-02-04 02:30:30', NULL, 1270, 0),
(170, 'can_view_tag', '', '2022-02-04 03:59:06', NULL, 1270, 0),
(171, 'can_edit_tag', '', '2022-02-04 04:00:04', NULL, 1270, 0),
(172, 'can_add_tag', '', '2022-02-04 04:00:26', NULL, 1270, 0),
(173, 'can_delete_tag', '', '2022-02-04 20:53:12', NULL, 1270, 0),
(174, 'can_bulk_delete_tag', '', '2022-02-04 20:53:26', NULL, 1270, 0),
(176, 'can_untrash_tag', '', '2022-02-04 20:54:54', NULL, 1270, 0),
(177, 'can_trash_tag', '', '2022-02-04 20:55:25', NULL, 1270, 0),
(179, 'can_trash_permission', '', '2022-02-05 10:29:01', NULL, 1270, 0),
(182, 'can_trash_role', '', '2022-02-05 10:38:33', NULL, 1270, 0),
(183, 'can_untrash_permission', '', '2022-02-05 12:07:50', NULL, 1270, 0),
(184, 'can_bulk_restore_permisson', '', '2022-02-05 12:25:07', NULL, 1270, 0),
(185, 'can_bulk_restore_permission', '', '2022-02-05 12:27:54', NULL, 1270, 0),
(188, 'can_untrash_role', '', '2022-02-05 14:49:26', NULL, 1270, 0),
(189, 'can_bulk_untrash_role', '', '2022-02-05 14:49:37', NULL, 1270, 0),
(190, 'can_bulk_trash_role', '', '2022-02-05 14:53:23', NULL, 1270, 0),
(191, 'can_bulk_restore_role', '', '2022-02-05 14:54:19', NULL, 1270, 0),
(192, 'can_bulk_trash_category', '', '2022-02-05 15:06:59', NULL, 1270, 0),
(193, 'can_bulk_trash_tag', '', '2022-02-05 15:07:13', NULL, 1270, 0),
(194, 'can_bulk_untrash_category', '', '2022-02-05 15:07:30', NULL, 1270, 0),
(195, 'can_bulk_untrash_tag', '', '2022-02-05 15:07:42', NULL, 1270, 0),
(196, 'can_bulk_clone_category', '', '2022-02-05 15:07:58', NULL, 1270, 0),
(197, 'can_bulk_restore_tag', '', '2022-02-05 15:17:22', NULL, 1270, 0);

-- --------------------------------------------------------

--
-- Table structure for table `plugins`
--

CREATE TABLE `plugins` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `uri` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `author` varchar(255) NOT NULL,
  `homepage` varchar(196) NOT NULL,
  `version` varchar(10) NOT NULL,
  `status` enum('activate','deactivate','','') NOT NULL DEFAULT 'deactivate'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `plugins`
--

INSERT INTO `plugins` (`id`, `name`, `uri`, `description`, `author`, `homepage`, `version`, `status`) VALUES
(28, 'HelloDolly', 'www.wordpress.org/plugins/hello-dolly/', 'This is not just a plugin it symbolizes the hope and enthusiasm of an entire', 'Matt Mullenweg', 'www.ma.tt/', '1.0.0', 'activate');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` int(10) UNSIGNED NOT NULL,
  `article` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('draft','published','schedule') COLLATE utf8mb4_unicode_ci NOT NULL,
  `visible` enum('private','protected','public') COLLATE utf8mb4_unicode_ci NOT NULL,
  `format` enum('article','chat','quote','image','video','audio','link','gallery','quote') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'article',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `schedule_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `slug`, `url`, `author`, `article`, `summary`, `status`, `visible`, `format`, `created_at`, `modified_at`, `schedule_at`) VALUES
(1, 'PHP 8.1 new release notes', 'php-8-1-new-release-notes', 'http://localhost/post/php-8-1-new-release-notes', 1270, 'PHP 8.1 is a major update of the PHP language.\r\nIt contains many new features, including enums, readonly properties, first-class callable syntax, fibers, intersection types, performance improvements and more.', 'PHP 8.1 is a major update of the PHP language.', 'published', 'public', 'article', '2022-02-02 03:36:33', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `post_assets`
--

CREATE TABLE `post_assets` (
  `id` int(10) UNSIGNED NOT NULL,
  `post_id` int(10) UNSIGNED NOT NULL,
  `asset_id` int(10) UNSIGNED NOT NULL,
  `asset_type` varchar(65) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_categories`
--

CREATE TABLE `post_categories` (
  `rel_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `post_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_tags`
--

CREATE TABLE `post_tags` (
  `rel_id` int(10) UNSIGNED NOT NULL,
  `post_id` int(10) UNSIGNED NOT NULL,
  `tag_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `remembered_logins`
--

CREATE TABLE `remembered_logins` (
  `token_hash` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` int(10) UNSIGNED NOT NULL,
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `remembered_logins`
--

INSERT INTO `remembered_logins` (`token_hash`, `id`, `expires_at`) VALUES
('6704e220b3e15477d24b58c5dacdb5c2b7a314cbf06ff7fe6409941ecd6c226d', 1270, '2022-02-13 08:23:19');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `role_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `role_description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `created_byid` int(10) UNSIGNED DEFAULT NULL,
  `deleted_at` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role_name`, `role_description`, `created_at`, `modified_at`, `created_byid`, `deleted_at`) VALUES
(1, 'Superadmin', 'Complete control', '2020-05-07 00:08:07', '2020-07-02 00:10:34', 1, 0),
(2, 'Subscriber', 'Basic role for users', '2021-02-19 01:46:04', '2022-02-05 14:54:47', 1, 0),
(121, 'Developer', 'The developer role', '2021-08-20 00:34:08', '2022-02-05 14:54:47', 1270, 0),
(151, 'Teacher', 'This is the teacher role', '2022-01-12 20:20:28', '2022-02-05 14:59:21', 1270, 0),
(152, 'Author', 'Role for authorfdfeffef', '2022-01-13 00:00:55', '2022-02-05 14:54:47', 1270, 0),
(170, 'Editor', '', '2022-01-18 21:11:06', '2022-02-05 14:54:47', 1270, 0),
(190, 'Actor', 'Actor role', '2022-02-02 18:31:37', '2022-02-05 14:54:47', 1270, 0);

-- --------------------------------------------------------

--
-- Table structure for table `role_permission`
--

CREATE TABLE `role_permission` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_permission`
--

INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES
(1, 76),
(2, 77),
(1, 72),
(1, 74),
(1, 73),
(1, 78),
(1, 81),
(1, 84),
(1, 79),
(1, 85),
(1, 86),
(1, 87),
(1, 88),
(1, 89),
(1, 92),
(1, 93),
(1, 94),
(1, 95),
(1, 96),
(1, 97),
(1, 98),
(1, 99),
(1, 100),
(1, 103),
(1, 77),
(1, 104),
(1, 82),
(1, 105),
(1, 106),
(1, 107),
(1, 108),
(1, 109),
(1, 110),
(1, 111),
(1, 112),
(1, 113),
(1, 114),
(1, 117),
(1, 118),
(1, 119),
(1, 120),
(1, 121),
(1, 91),
(1, 124),
(1, 129),
(1, 128),
(121, 77),
(1, 131),
(1, 132),
(1, 133),
(1, 135),
(1, 137),
(1, 138),
(1, 139),
(1, 140),
(1, 142),
(1, 143),
(1, 144),
(1, 145),
(1, 146),
(1, 147),
(1, 148),
(1, 149),
(1, 150),
(152, 77),
(1, 151),
(1, 152),
(1, 153),
(1, 154),
(1, 155),
(1, 156),
(1, 157),
(1, 158),
(1, 159),
(1, 160),
(1, 161),
(1, 162),
(1, 163),
(1, 164),
(1, 165),
(190, 77),
(1, 166),
(1, 167),
(1, 168),
(1, 169),
(1, 170),
(1, 171),
(1, 172),
(1, 173),
(1, 174),
(1, 176),
(1, 177),
(1, 179),
(1, 182),
(1, 183),
(1, 184),
(1, 185),
(1, 188),
(1, 189),
(1, 190),
(1, 191),
(1, 192),
(1, 193),
(1, 194),
(1, 195),
(1, 196),
(1, 197);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` int(10) NOT NULL,
  `session_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_access` decimal(15,0) NOT NULL,
  `session_variable` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `setting_name` varchar(65) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting_value` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `setting_name`, `setting_value`) VALUES
(1, 'app_version', '1.0.0'),
(2, 'app_db_version', '1.0.0'),
(3, 'default_category', ''),
(4, 'default_role', 'subscriber'),
(5, 'date_format', 'Y-m-d'),
(6, 'time_format', 'H:i:s'),
(7, 'show_gravatar', '1'),
(8, 'gravatar_size', '80'),
(9, 'gravatar_rating', 'r'),
(10, 'gravatar_default', 'wavatar'),
(11, 'can_register', '1'),
(12, 'summary_limit', '1'),
(13, 'site_name', 'LavaStudio'),
(14, 'site_url', 'http://lava-studio.co.uk'),
(15, 'site_email', 'ricardo.nalio.miller@gmail.com'),
(16, 'timezone', 'Europe/London'),
(17, 'locale', 'en'),
(18, 'app_name', 'Lava-Studio'),
(19, 'site_tagline', 'This is magmacore framework'),
(20, 'site_description', 'This is a generic description'),
(21, 'site_keywords', 'framework, magmacore'),
(22, 'week_starts_on', 'sunday'),
(23, 'global_table_rows_per_page', '5'),
(24, 'menu_icon', 'off'),
(25, 'menu_icon_size', '18');

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `tag_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tag_slug` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `created_byid` int(10) UNSIGNED NOT NULL,
  `deleted_at` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `tag_name`, `tag_slug`, `created_at`, `modified_at`, `created_byid`, `deleted_at`) VALUES
(12, 'Andrew Dyer', 'Enim id eum autem ex', '2022-02-05 15:14:15', '2022-02-05 15:17:53', 1270, 0);

-- --------------------------------------------------------

--
-- Table structure for table `temporary_role`
--

CREATE TABLE `temporary_role` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `prev_role_id` int(10) NOT NULL,
  `current_role_id` int(10) NOT NULL,
  `duration` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `extend_duration` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `temporary_role`
--

INSERT INTO `temporary_role` (`id`, `user_id`, `prev_role_id`, `current_role_id`, `duration`, `created_at`, `extend_duration`) VALUES
(13, 699, 110, 2, NULL, '2021-07-19 16:42:06', NULL),
(14, 702, 1, 2, NULL, '2021-07-19 23:08:44', NULL),
(15, 701, 1, 2, NULL, '2021-07-19 23:09:06', NULL),
(16, 701, 2, 110, NULL, '2021-07-20 00:39:53', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(10) UNSIGNED NOT NULL,
  `category` varchar(65) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ticket_desc` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` blob DEFAULT NULL,
  `status` enum('open','closed','resolved','') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `priority` enum('low','medium','high','critical') COLLATE utf8mb4_unicode_ci NOT NULL,
  `assigned_to` int(10) UNSIGNED DEFAULT NULL,
  `reassigned_to` int(10) UNSIGNED DEFAULT NULL,
  `created_byid` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `category`, `ticket_desc`, `attachment`, `status`, `priority`, `assigned_to`, `reassigned_to`, `created_byid`, `created_at`, `modified_at`) VALUES
(12, 'technical', 'Navigation menu is all fucked up can you resolve it please', NULL, 'open', 'medium', 1385, NULL, 1270, '2020-05-28 03:54:14', '2022-01-23 22:56:11'),
(13, 'general', 'can you have a look at the contact page please', NULL, 'resolved', 'medium', 1385, NULL, 1270, '2022-01-24 23:54:14', '2022-01-23 22:56:11'),
(14, 'general', 'can you have a look at the contact page please', NULL, 'resolved', 'medium', 1385, NULL, 1270, '2022-01-24 23:54:14', '2022-01-23 22:56:11');

-- --------------------------------------------------------

--
-- Table structure for table `ticket_comments`
--

CREATE TABLE `ticket_comments` (
  `id` int(10) UNSIGNED NOT NULL,
  `ticket_id` int(10) UNSIGNED NOT NULL,
  `comment` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `firstname` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
  `lastname` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
  `email` varchar(190) CHARACTER SET utf8mb4 NOT NULL,
  `gravatar` varchar(190) CHARACTER SET utf8mb4 DEFAULT NULL,
  `status` varchar(24) CHARACTER SET utf8mb4 NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `password_reset_hash` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `password_reset_expires_at` datetime DEFAULT NULL,
  `activation_token` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `created_byid` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` tinyint(1) DEFAULT NULL,
  `deleted_at_datetime` datetime DEFAULT NULL,
  `remote_addr` varchar(65) CHARACTER SET utf8mb4 NOT NULL,
  `user_failed_logins` tinyint(1) NOT NULL,
  `user_last_failed_login` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `gravatar`, `status`, `password_hash`, `password_reset_hash`, `password_reset_expires_at`, `activation_token`, `created_byid`, `created_at`, `modified_at`, `deleted_at`, `deleted_at_datetime`, `remote_addr`, `user_failed_logins`, `user_last_failed_login`) VALUES
(1270, 'Ricardo', 'Miller', 'rnm@example.com', 'https://www.gravatar.com/avatar/a166ea8de2bcaf91d509aadaa0e41ae5?s=200&d=mystery&r=R', 'active', '$2y$10$lH0PVKBNFC4XnCFaPYvAneTeYX8P.06ny.buOXE9zmXqbhamvz6dO', NULL, NULL, NULL, 1270, '2021-09-21 12:25:55', '2022-01-23 15:57:44', NULL, NULL, '::1', 0, NULL),
(1385, 'Hiroko', 'Noble', 'wegycikimy@mailinator.com', 'https://www.gravatar.com/avatar/5a34dd7689f1e20c61ed4d1837877212?s=200&d=mystery&r=R', 'active', '$2y$10$fuyriDZVhG05G3WIWLYS1OekZCdNbHHsyV6lmj/doucs7dz5UW9nG', NULL, NULL, 'a3db86cbbb093e96918bfd4fbcb3e539386d0d41032259f531568f7ef9760a90', 1270, '2022-01-09 21:09:36', NULL, NULL, NULL, '::1', 0, NULL),
(1386, 'Jocelyn', 'Middleton', 'lixociqux@mailinator.com', 'https://www.gravatar.com/avatar/802d7a62385973a7ff9e2363d930f26f?s=200&d=mystery&r=R', 'active', '$2y$10$jstmcYwVJPkctNuHKGCxfeuoeLDctNRSDKhqGFCet5epweKm7Mwt6', NULL, NULL, '0ed0ff7a00cf9d33c4b653fb920dcee18cedd9a691d024dabd565f924080ef34', 1270, '2022-01-09 21:10:51', '2022-01-20 00:14:13', NULL, NULL, '::1', 0, NULL),
(1388, 'Hedwig', 'Daniel', 'tadilota@mailinator.com', 'https://www.gravatar.com/avatar/c7470823e8acb8655e0207edce164ecf?s=200&d=mystery&r=R', 'active', '$2y$10$c5ke9AieP4XUr5OEz6lVg.wCVw2xC2rGJ6VwFot4/rHchzShlTsrG', NULL, NULL, '226cd5d5ff3dce8e7ee0fce85ca0d7d7c81d368f8a9992179aabc261f837ff99', 1270, '2022-01-11 13:52:08', '2022-01-29 18:30:43', NULL, NULL, '::1', 0, NULL),
(1389, 'Patience', 'Sanchez', 'roderyqe@mailinator.com', 'https://www.gravatar.com/avatar/479469c5181284a750c6d5d412d98283?s=200&d=mystery&r=R', 'active', '$2y$10$G6H9TSQ6DMdxJfMd7Nl2mOM1L5itqwk3jn/PY1XO3ixJQcv9HVFxq', NULL, NULL, 'd36006a0d314388d38339a984edbfb6e790c5e389c07ea5083eb278de695412e', 1270, '2022-01-11 14:24:27', NULL, NULL, NULL, '::1', 0, NULL),
(1390, 'Hall', 'Mccray', 'tiwukyqy@mailinator.com', 'https://www.gravatar.com/avatar/6ec90732caaa1418f4192486a4da52fd?s=200&d=mystery&r=R', 'pending', '$2y$10$w948SY0iw/rC44Q5gIYZqOkT4NnhkZsofJA/8MZseOaRubSM1PT1W', NULL, NULL, 'e2a2838762dd6ba3a69b792b0ad5b252a4b76a37d5fe2ed343f97b6966e642cf', 1270, '2022-01-11 21:05:45', NULL, NULL, NULL, '::1', 0, NULL),
(1391, 'John', 'Rogers', 'jexomuziji@mailinator.com', 'https://www.gravatar.com/avatar/6451af5b90e1f920cacb9a001cc3b839?s=200&d=mystery&r=R', 'active', '$2y$10$UOT0JBlr0OM.hL2x0UyHnO9Zy0vH0XN.o/gCgAlmyJFSRJx54VdPq', NULL, NULL, 'fff2cf8a3f6d70549c76065bf3d92e9681db9933f8b8a74af0471cb564bc4203', 1270, '2022-01-11 21:06:07', NULL, NULL, NULL, '::1', 0, NULL),
(1392, 'Nomlanga', 'Clark', 'pacojyreh@mailinator.com', 'https://www.gravatar.com/avatar/923cea6659e5209f2e062a73506a61e3?s=200&d=mystery&r=R', 'active', '$2y$10$Zkw/8ATAqrRNgnYo0rBJvucSuRctO02pYKVpmcZXsGntOeHaaQP6C', NULL, NULL, '379da1126b5c04180ea46b7f39ac4f228765fe12e479fb3f6e8ba7e655e4f856', 1270, '2022-01-11 21:09:30', '2022-01-11 22:27:42', NULL, NULL, '::1', 0, NULL),
(1393, 'Sonya', 'Perez', 'tazixipoci@mailinator.com', 'https://www.gravatar.com/avatar/3a895011f0d387d4cbd51b4206450a90?s=200&d=mystery&r=R', 'active', '$2y$10$QdeBe5KuvEFlo0mUY3LPPOsGL3MO1SYTf2C9fersjNhgvah.IO.BS', NULL, NULL, 'fd3d18b1634979b1a77a4eec50e1c20f2b70a7d7d11e62e28595a5661fe9ed4d', 1270, '2022-01-11 21:34:44', '2022-01-11 23:27:33', NULL, NULL, '::1', 0, NULL),
(1394, 'Raja', 'Durham', 'vetozaz@mailinator.com', 'https://www.gravatar.com/avatar/7decc95de03f10ab7f002e39f1993095?s=200&d=mystery&r=R', 'active', '$2y$10$RUTGCMHsVy/KcNexug5x6O6wdADuYoEnAZP0Kwx/evLl8nClb11iu', NULL, NULL, 'a04d6014074dacda7c88f1f75aae83473b05fdb292e3950d8af9aef2e69bf5a8', 1270, '2022-01-11 21:57:51', '2022-01-20 00:14:13', NULL, NULL, '::1', 0, NULL),
(1395, 'Barclay', 'Burks', 'vyzowi@mailinator.com', 'https://www.gravatar.com/avatar/e05a94151796370962f511ca61aa32fa?s=200&d=mystery&r=R', 'active', '$2y$10$bJUrM1Hvx06scAf24gMvKuKaUpdE8lWRjMJncZs9/ep1FRu3m7kBu', NULL, NULL, '0bfc5051f5719aa0f6fddb7c784336f643dd1cda6844d2846d856f22495aa6d5', 1270, '2022-01-11 22:09:11', '2022-01-20 00:27:21', NULL, NULL, '::1', 0, NULL),
(1396, 'Teagan', 'Cote', 'tiho@mailinator.com', 'https://www.gravatar.com/avatar/8305838a14b33e9a481c9db3208c438a?s=200&d=mystery&r=R', 'pending', '$2y$10$oKGpogTptlT.SIbLVqBCoe4JgS/s3m8gsNTzH2LTY7nmel.AQ5oD2', NULL, NULL, 'f5ae9b60ac08a33d0cfda1f435beb63253b851b94f54094fbf50ede5b1789055', 1270, '2022-01-11 22:09:26', NULL, NULL, NULL, '::1', 0, NULL),
(1397, 'Dacey', 'Alexanders', 'badatetizy@mailinator.com', 'https://www.gravatar.com/avatar/9affb0e2f863855ad0e6ca4c2b00eeac?s=200&d=mystery&r=R', 'active', '$2y$10$q24gbwoDOJj1tMUK36cBBOLvnmtvSfPK4Kss6e0GH2YX5vGgiCPr.', NULL, NULL, 'd0f7c479cbb3e9b2528ae9dfaf50242754a83c6262f656770b33977126f0b3a3', 1270, '2022-01-11 22:21:01', '2022-01-20 00:27:21', NULL, NULL, '::1', 0, NULL),
(1399, 'Xandra', 'Le', 'dukebane@mailinator.com', 'https://www.gravatar.com/avatar/cf5f76834fdf06c49319f530a7266ec1?s=200&d=mystery&r=R', 'active', '$2y$10$h8FkXvoE3Ear02DPLKK4yOrKL3ajR7C2qRrAyG9ZurlZoCW54oauO', NULL, NULL, '04551fdfbb152c45e527a572f1e2cac3748e040b6d6a053c57d73662634de733', 1270, '2022-01-11 23:27:11', '2022-01-20 00:14:13', NULL, NULL, '::1', 0, NULL),
(1400, 'Hyatt', 'Griffin', 'gicolibury@mailinator.com', 'https://www.gravatar.com/avatar/925e3af74d51a61dd180a4d20f07d040?s=200&d=mystery&r=R', 'active', '$2y$10$DXYrXI40cvOFATA74Jx9reJqs8/2WqgLYZO1NxPPm3apORL5tqc0S', NULL, NULL, '44e3df162442f7fd8e583e3428a5792d997960f8982f40b69c93e05754f5670a', 1270, '2022-01-12 00:44:13', NULL, NULL, NULL, '::1', 0, NULL),
(1401, 'Phoebe', 'Moore', 'lefote@mailinator.com', 'https://www.gravatar.com/avatar/e5f5d7b2b6494f7b887152eb0470f733?s=200&d=mystery&r=R', 'active', '$2y$10$wjEaveE.dAGnEB7gJlnh1uZdzWW2Y/A.w24BuU8evw0MV81RUD7xy', NULL, NULL, 'a825820cb0159a095a98a508d7076b9ca8b3a617f3a3e93eb97a08ed44bea2e9', 1270, '2022-01-12 09:05:30', '2022-01-20 00:14:13', NULL, NULL, '::1', 0, NULL),
(1402, 'Sheila', 'Lyons', 'xeqimurajy@mailinator.com', 'https://www.gravatar.com/avatar/5093e7762f63337b7cee54249e9994f0?s=200&d=mystery&r=R', 'active', '$2y$10$7DW4L.6qDs2/cAyWb7A7e.QN2EnIwjHkAMHu0lNnziUkbVzCY2eDK', NULL, NULL, '9c2366ae20a3898e21e949b481539a382dbbc5b5bed7ce000cbde94df489c40d', 1270, '2022-01-12 09:06:02', NULL, NULL, NULL, '::1', 0, NULL),
(1405, 'Kalia', 'Avila', 'fuquhyj@mailinator.com', 'https://www.gravatar.com/avatar/b8a40d38caab4a2ac0ec481c84bd34b4?s=200&d=mystery&r=R', 'pending', '$2y$10$OZTlaOPgjrK8ZavfP.8C8.WQ14NIk63DJmCHOEpq25tetaRoK8Ljm', NULL, NULL, '354d0815da2d37f7fe89060d6006515da1132904735cb1b69e68727907d72731', 1270, '2022-01-12 10:00:08', NULL, NULL, NULL, '::1', 0, NULL),
(1406, 'Mark', 'Newton', 'fuzo@mailinator.com', 'https://www.gravatar.com/avatar/5c012f64fefeec0e383c7e0ea2ba7847?s=200&d=mystery&r=R', 'pending', '$2y$10$tr95tTS7nFTAPcjsGN.3/u1Rzg5NGXYqvYsfCavgFZcRSKWBm9oRi', NULL, NULL, '35ef8bd3b3c4360f2ee34857e9da015ba958beb333fe6f50f3073ad27460f0e9', 1270, '2022-01-12 15:48:42', NULL, NULL, NULL, '::1', 0, NULL),
(1407, 'Imani', 'Langley', 'hyjugajy@mailinator.com', 'https://www.gravatar.com/avatar/db7e4cdd9ebcb8f5a6e26db4e3e8c7cc?s=200&d=mystery&r=R', 'active', '$2y$10$EORGJnFlwFBZCMavXPfacOf8ejxqtTwQjP7IPUpwsLCr0GVzGaYyi', NULL, NULL, '9ae838eec3cccd55a0ecc5d57da2c14601d890695028d26e28c66cef2abab333', 1270, '2022-01-12 15:49:30', '2022-01-20 00:14:13', NULL, NULL, '::1', 0, NULL),
(1408, 'Yolanda', 'Tyler', 'huwezycy@mailinator.com', 'https://www.gravatar.com/avatar/21160526aeb0ee1c788a1549183f4db8?s=200&d=mystery&r=R', 'active', '$2y$10$3e6hJcHV9KCJ8oeKWEOW0OWc/hHPSe63QGg7hidazk4BYYTjxQDKS', NULL, NULL, '721760464b61efb1c37dd993c47d973e733dbb289be80c90f5c8baf3534e466f', 1270, '2022-01-12 15:50:29', '2022-01-20 00:14:13', NULL, NULL, '::1', 0, NULL),
(1409, 'Karly', 'Cook', 'vazeboto@mailinator.com', 'https://www.gravatar.com/avatar/23e810d125bae2c84d82c5e93cbf40b1?s=200&d=mystery&r=R', 'pending', '$2y$10$bjrdNXmKRkW/tmQFvblpZ.BTqWuU0pZopVigNkePTFxYGUPF78M/q', NULL, NULL, '39904c5e96a1000a73fdb787bdcec44fb873ff14411a397f264f8dcccc14d563', 1270, '2022-01-12 15:51:30', NULL, NULL, NULL, '::1', 0, NULL),
(1411, 'Riley', 'Pacheco', 'jocaj@mailinator.com', 'https://www.gravatar.com/avatar/4fb26a3b32bca29ddfb7206972923041?s=200&d=mystery&r=R', 'active', '$2y$10$PdiW8K8cbFnUaZBMxUqaoOmWPJRGP21UKqZ3Z6rCpRedoRcWMUYFm', NULL, NULL, '0a2337e3aeed8e21b4b9d02bcb699425b65884befd903b150e8f0684db376a54', 1270, '2022-01-12 16:10:12', NULL, NULL, NULL, '::1', 0, NULL),
(1412, 'Fatima', 'Sweeney', 'zuqowezu@mailinator.com', 'https://www.gravatar.com/avatar/622f3efb2955f07fc62764b88ae610e0?s=200&d=mystery&r=R', 'active', '$2y$10$3hxj04h/LFA2EknNKvB4GOIxrmSQBwNKaNInSY0IkyKi7ozYm2fle', NULL, NULL, 'cc2411320902d31ce54eaacba2a6c0f0762dbc3a211d7a71bed16f0c6eacf63e', 1270, '2022-01-12 16:15:34', '2022-01-20 00:22:30', NULL, NULL, '::1', 0, NULL),
(1413, 'Scarlet', 'Rivers', 'viduqytu@mailinator.com', 'https://www.gravatar.com/avatar/f166fbbf9c17512de3e665d786729696?s=200&d=mystery&r=R', 'pending', '$2y$10$4KjmPDgyh5AyiPZzm4INoeC70W7j1Ubwyu1tbm0WJCPT54K60cz7W', NULL, NULL, '9557401eb3207efbebfcf08d64ffcf7403a7cb15b71b3606b373190322220b27', 1270, '2022-01-12 18:45:27', NULL, NULL, NULL, '::1', 0, NULL),
(1414, 'Emma', 'Blair', 'boveve@mailinator.com', 'https://www.gravatar.com/avatar/c3df8551eef84fc3dc3d70734550e79a?s=200&d=mystery&r=R', 'active', '$2y$10$IdCmca2W3xhoRYrlxTWxueQj9s6xbF/21THc//aHs9Jj1kGFRJN.2', NULL, NULL, '69c90d037481adfef7c0310cd9e7f97f9776325e1c60ef89f1fe2975b41f0274', 1270, '2022-01-13 20:23:29', '2022-01-20 00:27:21', NULL, NULL, '::1', 0, NULL),
(1415, 'TaShya', 'Weber', 'kakufiw@mailinator.com', 'https://www.gravatar.com/avatar/c0a263e0f844286f4995ac348a52044e?s=200&d=mystery&r=R', 'active', '$2y$10$Cv1viENvDPe96HoZeIsOF.gcwf1tleFC5Al6zOAEZO2PXr/AWQC/y', NULL, NULL, '337a012e763772d1ba9b3ef3f450a23ab87a575916fd0c1352294cbbfafefce8', 1270, '2022-01-19 19:54:29', NULL, NULL, NULL, '::1', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_group`
--

CREATE TABLE `user_group` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_group`
--

INSERT INTO `user_group` (`user_id`, `group_id`) VALUES
(1270, 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_logs`
--

CREATE TABLE `user_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `level` int(10) NOT NULL,
  `level_name` varchar(100) NOT NULL,
  `context` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `message` text NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_logs`
--

INSERT INTO `user_logs` (`id`, `level`, `level_name`, `context`, `message`, `user_id`, `created_at`) VALUES
(1, 200, 'info', NULL, 'new user added today', 1270, '2022-01-20 00:49:09'),
(2, 300, 'warning', NULL, 'user update process failed', 1270, '2022-01-20 00:49:09');

-- --------------------------------------------------------

--
-- Table structure for table `user_metadata`
--

CREATE TABLE `user_metadata` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `login` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `logout` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `brute_force` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `user_browser` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_metadata`
--

INSERT INTO `user_metadata` (`id`, `user_id`, `login`, `logout`, `brute_force`, `user_browser`) VALUES
(57, 1385, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(58, 1386, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(60, 1388, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(61, 1389, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(62, 1390, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(63, 1391, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(64, 1392, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(65, 1393, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(66, 1394, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(67, 1395, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(68, 1396, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(69, 1397, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(71, 1399, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(72, 1400, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(73, 1401, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(74, 1402, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(77, 1405, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(78, 1406, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(79, 1407, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(80, 1408, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(81, 1409, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(83, 1411, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(84, 1412, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(85, 1413, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(86, 1414, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(87, 1415, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}');

-- --------------------------------------------------------

--
-- Table structure for table `user_note`
--

CREATE TABLE `user_note` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `user_note`
--

INSERT INTO `user_note` (`id`, `user_id`, `notes`, `created_at`, `modified_at`) VALUES
(1, 1415, 'Welcome TaShya Weber', '2022-01-19 19:54:29', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_preferences`
--

CREATE TABLE `user_preferences` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `address` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `language` varchar(5) DEFAULT NULL,
  `week_start_on` int(10) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`user_id`, `role_id`) VALUES
(1270, 1),
(1385, 121),
(1389, 2),
(1390, 2),
(1391, 121),
(1392, 121),
(1393, 2),
(1394, 2),
(1396, 121),
(1400, 2),
(1401, 2),
(1407, 2),
(1411, 121),
(1414, 152),
(1415, 170),
(1397, 121),
(1412, 121),
(1395, 152);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cat_name` (`cat_name`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `controller_settings`
--
ALTER TABLE `controller_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `controller_name` (`controller_name`),
  ADD KEY `controller_menu_id` (`controller_menu_id`);

--
-- Indexes for table `event_log`
--
ALTER TABLE `event_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `group_name` (`group_name`);

--
-- Indexes for table `group_role`
--
ALTER TABLE `group_role`
  ADD UNIQUE KEY `role_id` (`role_id`),
  ADD UNIQUE KEY `group_id` (`group_id`);

--
-- Indexes for table `localisations`
--
ALTER TABLE `localisations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `locale` (`locale`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menu_order` (`menu_order`),
  ADD KEY `menu_name` (`menu_name`);

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_item_original_name` (`item_original_label`),
  ADD KEY `main_menu_id` (`item_original_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `metadata`
--
ALTER TABLE `metadata`
  ADD UNIQUE KEY `post_id` (`post_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `migration_name` (`migration_name`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `title` (`title`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permission_name` (`permission_name`);

--
-- Indexes for table `plugins`
--
ALTER TABLE `plugins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `title` (`title`);

--
-- Indexes for table `post_assets`
--
ALTER TABLE `post_assets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `asset_id` (`asset_id`);

--
-- Indexes for table `post_categories`
--
ALTER TABLE `post_categories`
  ADD PRIMARY KEY (`rel_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD PRIMARY KEY (`rel_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- Indexes for table `remembered_logins`
--
ALTER TABLE `remembered_logins`
  ADD PRIMARY KEY (`token_hash`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `role_permission`
--
ALTER TABLE `role_permission`
  ADD KEY `role_id` (`role_id`) USING BTREE,
  ADD KEY `permission_id` (`permission_id`) USING BTREE;

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_name` (`setting_name`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tag_name` (`tag_name`);

--
-- Indexes for table `temporary_role`
--
ALTER TABLE `temporary_role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ticket_comments`
--
ALTER TABLE `ticket_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_comment_id` (`ticket_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `password_reset_hash` (`password_reset_hash`),
  ADD UNIQUE KEY `activation_token` (`activation_token`);

--
-- Indexes for table `user_group`
--
ALTER TABLE `user_group`
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `user_logs`
--
ALTER TABLE `user_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_log_id` (`user_id`);

--
-- Indexes for table `user_metadata`
--
ALTER TABLE `user_metadata`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `user_note`
--
ALTER TABLE `user_note`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_note_id` (`user_id`);

--
-- Indexes for table `user_preferences`
--
ALTER TABLE `user_preferences`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `controller_settings`
--
ALTER TABLE `controller_settings`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `event_log`
--
ALTER TABLE `event_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=231;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `localisations`
--
ALTER TABLE `localisations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=479;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1915;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=198;

--
-- AUTO_INCREMENT for table `plugins`
--
ALTER TABLE `plugins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `post_assets`
--
ALTER TABLE `post_assets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `post_categories`
--
ALTER TABLE `post_categories`
  MODIFY `rel_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `post_tags`
--
ALTER TABLE `post_tags`
  MODIFY `rel_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=245;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `temporary_role`
--
ALTER TABLE `temporary_role`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `ticket_comments`
--
ALTER TABLE `ticket_comments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1416;

--
-- AUTO_INCREMENT for table `user_logs`
--
ALTER TABLE `user_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_metadata`
--
ALTER TABLE `user_metadata`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `user_note`
--
ALTER TABLE `user_note`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_preferences`
--
ALTER TABLE `user_preferences`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `controller_settings`
--
ALTER TABLE `controller_settings`
  ADD CONSTRAINT `controller_menu_id` FOREIGN KEY (`controller_menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `main_menu_id` FOREIGN KEY (`item_original_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `metadata`
--
ALTER TABLE `metadata`
  ADD CONSTRAINT `post_metadata_rel` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `post_assets`
--
ALTER TABLE `post_assets`
  ADD CONSTRAINT `asset` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `post_categories`
--
ALTER TABLE `post_categories`
  ADD CONSTRAINT `category_rel` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `post_rel` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD CONSTRAINT `post_tag_rel` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tag_rel` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `role_permission`
--
ALTER TABLE `role_permission`
  ADD CONSTRAINT `permission` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ticket_comments`
--
ALTER TABLE `ticket_comments`
  ADD CONSTRAINT `ticket_comment_id` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_logs`
--
ALTER TABLE `user_logs`
  ADD CONSTRAINT `user_log_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_metadata`
--
ALTER TABLE `user_metadata`
  ADD CONSTRAINT `user_metadata_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_note`
--
ALTER TABLE `user_note`
  ADD CONSTRAINT `user_note_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_preferences`
--
ALTER TABLE `user_preferences`
  ADD CONSTRAINT `user_preferences_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
