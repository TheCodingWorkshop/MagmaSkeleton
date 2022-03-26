-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 26, 2022 at 05:49 PM
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
(43, 'Movies', 'movies', NULL, '2022-02-23 11:25:09', NULL, 1270, 0);

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
-- Table structure for table `controllers`
--

CREATE TABLE `controllers` (
  `id` int(10) UNSIGNED NOT NULL,
  `controller` varchar(50) NOT NULL,
  `methods` longtext DEFAULT NULL,
  `method_permissions` longtext DEFAULT NULL,
  `active` int(1) DEFAULT 0,
  `current_new_method` longtext DEFAULT NULL,
  `current_new_method_datetime` datetime DEFAULT NULL,
  `current_method_count` int(11) DEFAULT NULL,
  `is_parent_menu` int(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `controllers`
--

INSERT INTO `controllers` (`id`, `controller`, `methods`, `method_permissions`, `active`, `current_new_method`, `current_new_method_datetime`, `current_method_count`, `is_parent_menu`, `created_at`) VALUES
(62, 'dashboard', 'a:6:{i:0;s:11:\"indexAction\";i:1;s:14:\"datetimeAction\";i:2;s:14:\"settingsAction\";i:3;s:12:\"healthAction\";i:4;s:13:\"historyAction\";i:7;s:15:\"changeRowAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:32:51'),
(63, 'discovery', 'a:5:{i:0;s:14:\"discoverAction\";i:1;s:24:\"discoverControllerAction\";i:2;s:13:\"installAction\";i:5;s:14:\"settingsAction\";i:6;s:15:\"changeRowAction\";}', NULL, 0, 'a:1:{i:3;s:13:\"refreshAction\";}', NULL, 1, 0, '2022-02-22 23:32:57'),
(64, 'accessdenied', 'a:3:{i:0;s:11:\"indexAction\";i:3;s:14:\"settingsAction\";i:4;s:15:\"changeRowAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:44:35'),
(65, 'category', 'a:9:{i:0;s:11:\"indexAction\";i:1;s:9:\"newAction\";i:2;s:10:\"editAction\";i:3;s:11:\"trashAction\";i:4;s:13:\"untrashAction\";i:5;s:16:\"hardDeleteAction\";i:6;s:14:\"settingsAction\";i:9;s:15:\"changeRowAction\";i:16;s:16:\"chooseBulkAction\";}', NULL, 0, 'a:1:{i:7;s:10:\"testAction\";}', NULL, 1, 0, '2022-02-22 23:44:35'),
(66, 'github', 'a:0:{}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:44:35'),
(67, 'group', 'a:10:{i:0;s:11:\"indexAction\";i:1;s:9:\"newAction\";i:2;s:10:\"editAction\";i:3;s:11:\"trashAction\";i:4;s:13:\"untrashAction\";i:5;s:16:\"hardDeleteAction\";i:6;s:12:\"deleteAction\";i:7;s:14:\"assignedAction\";i:8;s:14:\"settingsAction\";i:11;s:15:\"changeRowAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:44:35'),
(68, 'menu', 'a:12:{i:0;s:11:\"trashAction\";i:1;s:11:\"indexAction\";i:2;s:9:\"newAction\";i:3;s:10:\"editAction\";i:4;s:13:\"untrashAction\";i:5;s:16:\"hardDeleteAction\";i:6;s:12:\"deleteAction\";i:7;s:16:\"removeItemAction\";i:8;s:14:\"settingsAction\";i:9;s:15:\"quickSaveAction\";i:12;s:15:\"changeRowAction\";i:19;s:16:\"chooseBulkAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:44:35'),
(69, 'message', 'a:12:{i:1;s:11:\"indexAction\";i:2;s:9:\"newAction\";i:3;s:10:\"showAction\";i:4;s:11:\"replyAction\";i:5;s:13:\"forwardAction\";i:6;s:13:\"starredAction\";i:7;s:15:\"unstarredAction\";i:8;s:12:\"markedAction\";i:9;s:14:\"unmarkedAction\";i:10;s:14:\"settingsAction\";i:11;s:11:\"draftAction\";i:14;s:15:\"changeRowAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:44:35'),
(70, 'permission', 'a:9:{i:0;s:11:\"indexAction\";i:1;s:9:\"newAction\";i:2;s:10:\"editAction\";i:3;s:11:\"trashAction\";i:4;s:13:\"untrashAction\";i:5;s:16:\"hardDeleteAction\";i:6;s:14:\"settingsAction\";i:9;s:15:\"changeRowAction\";i:16;s:16:\"chooseBulkAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:44:35'),
(71, 'plugin', 'a:3:{i:0;s:11:\"indexAction\";i:3;s:14:\"settingsAction\";i:4;s:15:\"changeRowAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:44:35'),
(72, 'post', 'a:8:{i:1;s:11:\"indexAction\";i:2;s:9:\"newAction\";i:3;s:10:\"editAction\";i:4;s:11:\"trashAction\";i:5;s:13:\"untrashAction\";i:6;s:16:\"hardDeleteAction\";i:7;s:14:\"settingsAction\";i:10;s:15:\"changeRowAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:44:35'),
(73, 'profile', 'a:25:{i:0;s:11:\"indexAction\";i:1;s:14:\"overviewAction\";i:2;s:10:\"showAction\";i:3;s:9:\"newAction\";i:4;s:10:\"editAction\";i:5;s:12:\"deleteAction\";i:6;s:11:\"cloneAction\";i:7;s:16:\"hardDeleteAction\";i:8;s:10:\"bulkAction\";i:9;s:16:\"bulkDeleteAction\";i:10;s:15:\"bulkCloneAction\";i:11;s:19:\"bulkUnlockAllAction\";i:12;s:10:\"lockAction\";i:13;s:12:\"unlockAction\";i:14;s:11:\"trashAction\";i:15;s:18:\"trashRestoreAction\";i:16;s:12:\"activeAction\";i:17;s:17:\"preferencesAction\";i:18;s:15:\"privilegeAction\";i:19;s:25:\"privilegeExpirationAction\";i:20;s:9:\"logAction\";i:21;s:11:\"notesAction\";i:22;s:14:\"personalAction\";i:23;s:14:\"settingsAction\";i:26;s:15:\"changeRowAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:44:35'),
(74, 'role', 'a:12:{i:0;s:11:\"indexAction\";i:1;s:9:\"newAction\";i:2;s:10:\"editAction\";i:3;s:11:\"trashAction\";i:4;s:13:\"untrashAction\";i:5;s:16:\"hardDeleteAction\";i:6;s:14:\"assignedAction\";i:7;s:9:\"logAction\";i:8;s:24:\"unassignPermissionAction\";i:9;s:14:\"settingsAction\";i:12;s:15:\"changeRowAction\";i:19;s:16:\"chooseBulkAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:44:35'),
(75, 'search', 'a:3:{i:0;s:12:\"searchAction\";i:3;s:14:\"settingsAction\";i:4;s:15:\"changeRowAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:44:35'),
(76, 'setting', 'a:11:{i:0;s:11:\"indexAction\";i:1;s:13:\"generalAction\";i:2;s:14:\"securityAction\";i:3;s:11:\"purgeAction\";i:4;s:11:\"toolsAction\";i:5;s:18:\"localisationAction\";i:6;s:14:\"brandingAction\";i:7;s:15:\"extensionAction\";i:8;s:17:\"applicationAction\";i:11;s:14:\"settingsAction\";i:12;s:15:\"changeRowAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:44:35'),
(77, 'system', 'a:4:{i:1;s:11:\"indexAction\";i:2;s:10:\"showAction\";i:4;s:14:\"settingsAction\";i:5;s:15:\"changeRowAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:44:35'),
(78, 'tag', 'a:9:{i:0;s:11:\"indexAction\";i:1;s:9:\"newAction\";i:2;s:10:\"editAction\";i:3;s:11:\"trashAction\";i:4;s:13:\"untrashAction\";i:5;s:16:\"hardDeleteAction\";i:6;s:14:\"settingsAction\";i:9;s:15:\"changeRowAction\";i:16;s:16:\"chooseBulkAction\";}', NULL, 0, 'a:1:{i:7;s:10:\"testAction\";}', NULL, 1, 0, '2022-02-22 23:44:35'),
(79, 'ticket', 'a:9:{i:1;s:11:\"indexAction\";i:2;s:9:\"newAction\";i:3;s:10:\"editAction\";i:4;s:11:\"trashAction\";i:5;s:13:\"untrashAction\";i:6;s:16:\"hardDeleteAction\";i:7;s:14:\"settingsAction\";i:10;s:15:\"changeRowAction\";i:16;s:16:\"chooseBulkAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:44:35'),
(80, 'user', 'a:25:{i:0;s:11:\"indexAction\";i:1;s:14:\"overviewAction\";i:2;s:10:\"showAction\";i:3;s:9:\"newAction\";i:4;s:10:\"editAction\";i:5;s:12:\"deleteAction\";i:6;s:11:\"cloneAction\";i:7;s:16:\"hardDeleteAction\";i:8;s:10:\"bulkAction\";i:9;s:16:\"bulkDeleteAction\";i:10;s:15:\"bulkCloneAction\";i:11;s:19:\"bulkUnlockAllAction\";i:12;s:10:\"lockAction\";i:13;s:12:\"unlockAction\";i:14;s:11:\"trashAction\";i:15;s:18:\"trashRestoreAction\";i:16;s:12:\"activeAction\";i:17;s:17:\"preferencesAction\";i:18;s:15:\"privilegeAction\";i:19;s:25:\"privilegeExpirationAction\";i:20;s:9:\"logAction\";i:21;s:11:\"notesAction\";i:22;s:14:\"personalAction\";i:23;s:14:\"settingsAction\";i:26;s:15:\"changeRowAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:44:35'),
(81, 'userrole', 'a:2:{i:2;s:14:\"settingsAction\";i:3;s:15:\"changeRowAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-22 23:44:35'),
(82, 'security', 'a:2:{i:1;s:11:\"indexAction\";i:2;s:13:\"sessionAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-23 06:26:33'),
(83, 'home', 'a:1:{i:1;s:11:\"indexAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-23 12:20:36'),
(84, 'password', 'a:2:{i:0;s:12:\"forgotAction\";i:1;s:11:\"resetAction\";}', NULL, 0, NULL, NULL, NULL, 0, '2022-02-23 12:44:06'),
(85, 'notification', 'a:4:{i:0;s:11:\"indexAction\";i:3;s:14:\"settingsAction\";i:4;s:15:\"changeRowAction\";i:11;s:16:\"chooseBulkAction\";}', NULL, 0, 'a:1:{i:1;s:10:\"showAction\";}', NULL, 1, 0, '2022-02-23 18:24:25');

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
-- Table structure for table `dashboard`
--

CREATE TABLE `dashboard` (
  `id` int(10) UNSIGNED NOT NULL
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
(230, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:8:\"category\";s:16:\"menu_description\";s:26:\"category parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:477;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-02 21:32:26'),
(231, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:479;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-06 09:49:54'),
(232, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:480;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-06 10:11:42'),
(233, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"user\";s:16:\"menu_description\";s:22:\"user parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:481;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-06 10:11:52');
INSERT INTO `event_log` (`id`, `event_log_name`, `event_type`, `source`, `user`, `method`, `event_context`, `event_browser`, `IP`, `created_at`) VALUES
(234, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:482;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-06 10:11:59'),
(235, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:483;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-06 10:12:06'),
(236, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:6:\"plugin\";s:16:\"menu_description\";s:24:\"plugin parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:484;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-06 10:12:11'),
(237, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"setting\";s:16:\"menu_description\";s:25:\"setting parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:485;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-06 10:12:21'),
(238, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:486;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-06 10:16:26'),
(239, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:8:\"category\";s:16:\"menu_description\";s:26:\"category parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:487;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-06 10:16:39'),
(240, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:3:\"tag\";s:16:\"menu_description\";s:21:\"tag parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:488;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-06 10:16:45'),
(241, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:489;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-06 10:17:02'),
(242, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"post\";s:16:\"menu_description\";s:22:\"post parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:490;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-06 10:17:14'),
(243, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:5:\"group\";s:16:\"menu_description\";s:23:\"group parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:491;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-06 10:17:42'),
(244, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"user\";s:16:\"menu_description\";s:22:\"user parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:492;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-06 10:51:58'),
(245, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"message\";s:16:\"menu_description\";s:25:\"message parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:5:\"alert\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:493;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-06 12:21:17'),
(246, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:6:\"ticket\";s:16:\"menu_description\";s:24:\"ticket parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:494;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-07 21:59:01'),
(247, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:8:\"category\";s:16:\"menu_description\";s:26:\"category parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:495;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-08 21:56:23'),
(248, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:496;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-08 21:57:11'),
(249, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"user\";s:16:\"menu_description\";s:22:\"user parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:497;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-08 21:57:26'),
(250, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"post\";s:16:\"menu_description\";s:22:\"post parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:498;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-08 21:57:38'),
(251, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:499;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-08 21:58:51'),
(252, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"setting\";s:16:\"menu_description\";s:25:\"setting parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:500;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-08 21:59:45'),
(253, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:8:\"category\";s:16:\"menu_description\";s:26:\"category parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:501;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-08 23:47:28'),
(254, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:3:\"tag\";s:16:\"menu_description\";s:21:\"tag parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:502;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-08 23:48:55'),
(255, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:503;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-09 21:21:09'),
(256, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:5:\"group\";s:16:\"menu_description\";s:23:\"group parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:504;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-09 21:23:47'),
(257, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"menu\";s:16:\"menu_description\";s:22:\"menu parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:505;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-10 03:16:20'),
(258, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:506;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-10 03:16:55'),
(259, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:507;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-10 03:17:51'),
(260, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"setting\";s:16:\"menu_description\";s:25:\"setting parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:508;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-10 03:18:10'),
(261, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:509;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-10 03:21:56'),
(262, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:510;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-10 03:24:19'),
(263, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"setting\";s:16:\"menu_description\";s:25:\"setting parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:511;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-10 03:24:38'),
(264, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:6:\"ticket\";s:16:\"menu_description\";s:24:\"ticket parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:512;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-10 12:31:14'),
(265, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"message\";s:16:\"menu_description\";s:25:\"message parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:513;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-12 00:26:03'),
(266, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:6:\"plugin\";s:16:\"menu_description\";s:24:\"plugin parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:514;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-13 14:35:20'),
(267, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"menu\";s:16:\"menu_description\";s:22:\"menu parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:515;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-17 03:54:33'),
(268, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"dashboard\";s:16:\"menu_description\";s:27:\"dashboard parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:516;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-17 03:54:58'),
(269, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"user\";s:16:\"menu_description\";s:22:\"user parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:517;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-17 10:23:33'),
(270, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"role\";s:16:\"menu_description\";s:22:\"role parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:518;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-17 10:23:43');
INSERT INTO `event_log` (`id`, `event_log_name`, `event_type`, `source`, `user`, `method`, `event_context`, `event_browser`, `IP`, `created_at`) VALUES
(271, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:10:\"permission\";s:16:\"menu_description\";s:28:\"permission parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:519;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-17 10:23:48'),
(272, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"setting\";s:16:\"menu_description\";s:25:\"setting parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:520;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-17 11:04:02'),
(273, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:6:\"ticket\";s:16:\"menu_description\";s:24:\"ticket parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:521;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-17 11:04:25'),
(274, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:8:\"category\";s:16:\"menu_description\";s:26:\"category parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:522;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-17 11:04:33'),
(275, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:3:\"tag\";s:16:\"menu_description\";s:21:\"tag parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:523;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-17 11:04:38'),
(276, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:7:\"message\";s:16:\"menu_description\";s:25:\"message parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:524;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-17 11:05:58'),
(277, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:9:\"discovery\";s:16:\"menu_description\";s:27:\"discovery parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:525;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-20 16:45:47'),
(278, 'system', 'information', 'magmacore.system.event_system_action_event', 1270, 'MagmaCore\\Base\\Traits\\ControllerMenuTrait::buildControllerMenu', 'a:3:{s:4:\"menu\";a:6:{s:9:\"menu_name\";s:4:\"post\";s:16:\"menu_description\";s:22:\"post parent menu item.\";s:10:\"menu_order\";N;s:16:\"menu_break_point\";N;s:9:\"menu_icon\";s:7:\"warning\";s:11:\"parent_menu\";i:1;}s:7:\"last_id\";i:526;s:6:\"status\";b:1;}', 'a:30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}', 0, '2022-02-22 06:30:58');

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
  `created_byid` int(10) UNSIGNED NOT NULL,
  `deleted_at` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `group_name`, `group_description`, `created_at`, `modified_at`, `created_byid`, `deleted_at`) VALUES
(7, 'Master Author', 'Master author group groups author and contributor roles together which provides additional permissions', '2022-02-12 10:03:19', NULL, 1270, 0);

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
(515, 'menu', 'menu parent menu item.', 1, NULL, NULL, 'warning', '2022-02-17 03:54:33', NULL, 0, 0),
(516, 'dashboard', 'dashboard parent menu item.', 1, 100, '', 'warning', '2022-02-17 03:54:58', '2022-02-17 03:55:22', 0, 1270),
(517, 'user', 'user parent menu item.', 1, NULL, NULL, 'warning', '2022-02-17 10:23:33', NULL, 0, 0),
(518, 'role', 'role parent menu item.', 1, NULL, NULL, 'warning', '2022-02-17 10:23:43', NULL, 0, 0),
(519, 'permission', 'permission parent menu item.', 1, NULL, NULL, 'warning', '2022-02-17 10:23:48', NULL, 0, 0),
(520, 'setting', 'setting parent menu item.', 1, NULL, NULL, 'warning', '2022-02-17 11:04:02', NULL, 0, 0),
(521, 'ticket', 'ticket parent menu item.', 1, NULL, NULL, 'warning', '2022-02-17 11:04:24', NULL, 0, 0),
(522, 'category', 'category parent menu item.', 1, 0, '', 'warning', '2022-02-17 11:04:33', '2022-02-18 20:13:54', 0, 1270),
(523, 'tag', 'tag parent menu item.', 1, NULL, NULL, 'warning', '2022-02-17 11:04:37', NULL, 0, 0),
(524, 'message', 'message parent menu item.', 1, NULL, NULL, 'warning', '2022-02-17 11:05:57', NULL, 0, 0),
(526, 'post', 'post parent menu item.', 1, NULL, NULL, 'warning', '2022-02-22 06:30:58', NULL, 0, 0);

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
(2278, 515, 'menu_trashAction', 'trash', 'child_of_menu', '/admin/menu/trash', 0, NULL),
(2279, 515, 'menu_indexAction', 'index', 'child_of_menu', '/admin/menu/index', 0, 1),
(2280, 515, 'menu_newAction', 'new', 'child_of_menu', '/admin/menu/new', 0, 1),
(2281, 515, 'menu_editAction', 'edit', 'child_of_menu', '/admin/menu/edit', 0, NULL),
(2282, 515, 'menu_untrashAction', 'untrash', 'child_of_menu', '/admin/menu/untrash', 0, NULL),
(2283, 515, 'menu_hardDeleteAction', 'hardDelete', 'child_of_menu', '/admin/menu/harddelete', 0, NULL),
(2284, 515, 'menu_deleteAction', 'delete', 'child_of_menu', '/admin/menu/delete', 0, NULL),
(2285, 515, 'menu_removeItemAction', 'removeItem', 'child_of_menu', '/admin/menu/removeitem', 0, NULL),
(2286, 515, 'menu_settingsAction', 'settings', 'child_of_menu', '/admin/menu/settings', 0, 1),
(2287, 515, 'menu_orderAction', 'order', 'child_of_menu', '/admin/menu/order', 0, NULL),
(2288, 515, 'menu_pingAction', 'ping', 'child_of_menu', '/admin/menu/ping', 0, NULL),
(2289, 515, 'menu_changeRowAction', 'changeRow', 'child_of_menu', '/admin/menu/changerow', 0, NULL),
(2290, 515, 'menu_chooseBulkAction', 'chooseBulk', 'child_of_menu', '/admin/menu/choosebulk', 0, NULL),
(2291, 516, 'dashboard_indexAction', 'index', 'child_of_dashboard', '/admin/dashboard/index', 0, 1),
(2292, 516, 'dashboard_datetimeAction', 'datetime', 'child_of_dashboard', '/admin/dashboard/datetime', 0, NULL),
(2293, 516, 'dashboard_settingsAction', 'settings', 'child_of_dashboard', '/admin/dashboard/settings', 0, 1),
(2294, 516, 'dashboard_healthAction', 'health', 'child_of_dashboard', '/admin/dashboard/health', 0, NULL),
(2295, 516, 'dashboard_changeRowAction', 'changeRow', 'child_of_dashboard', '/admin/dashboard/changerow', 0, NULL),
(2296, 517, 'user_indexAction', 'index', 'child_of_user', '/admin/user/index', 0, 1),
(2297, 517, 'user_overviewAction', 'overview', 'child_of_user', '/admin/user/overview', 0, NULL),
(2298, 517, 'user_showAction', 'show', 'child_of_user', '/admin/user/show', 0, NULL),
(2299, 517, 'user_newAction', 'new', 'child_of_user', '/admin/user/new', 0, 1),
(2300, 517, 'user_editAction', 'edit', 'child_of_user', '/admin/user/edit', 0, NULL),
(2301, 517, 'user_deleteAction', 'delete', 'child_of_user', '/admin/user/delete', 0, NULL),
(2302, 517, 'user_cloneAction', 'clone', 'child_of_user', '/admin/user/clone', 0, NULL),
(2303, 517, 'user_hardDeleteAction', 'hardDelete', 'child_of_user', '/admin/user/harddelete', 0, NULL),
(2304, 517, 'user_bulkAction', 'bulk', 'child_of_user', '/admin/user/bulk', 0, NULL),
(2305, 517, 'user_bulkDeleteAction', 'bulkDelete', 'child_of_user', '/admin/user/bulkdelete', 0, NULL),
(2306, 517, 'user_bulkCloneAction', 'bulkClone', 'child_of_user', '/admin/user/bulkclone', 0, NULL),
(2307, 517, 'user_bulkUnlockAllAction', 'bulkUnlockAll', 'child_of_user', '/admin/user/bulkunlockall', 0, NULL),
(2308, 517, 'user_lockAction', 'lock', 'child_of_user', '/admin/user/lock', 0, NULL),
(2309, 517, 'user_unlockAction', 'unlock', 'child_of_user', '/admin/user/unlock', 0, NULL),
(2310, 517, 'user_trashAction', 'trash', 'child_of_user', '/admin/user/trash', 0, NULL),
(2311, 517, 'user_trashRestoreAction', 'trashRestore', 'child_of_user', '/admin/user/trashrestore', 0, NULL),
(2312, 517, 'user_activeAction', 'active', 'child_of_user', '/admin/user/active', 0, NULL),
(2313, 517, 'user_preferencesAction', 'preferences', 'child_of_user', '/admin/user/preferences', 0, NULL),
(2314, 517, 'user_privilegeAction', 'privilege', 'child_of_user', '/admin/user/privilege', 0, NULL),
(2315, 517, 'user_privilegeExpirationAction', 'privilegeExpiration', 'child_of_user', '/admin/user/privilegeexpiration', 0, NULL),
(2316, 517, 'user_logAction', 'log', 'child_of_user', '/admin/user/log', 0, 1),
(2317, 517, 'user_notesAction', 'notes', 'child_of_user', '/admin/user/notes', 0, NULL),
(2318, 517, 'user_personalAction', 'personal', 'child_of_user', '/admin/user/personal', 0, NULL),
(2319, 517, 'user_settingsAction', 'settings', 'child_of_user', '/admin/user/settings', 0, 1),
(2320, 517, 'user_changeRowAction', 'changeRow', 'child_of_user', '/admin/user/changerow', 0, NULL),
(2321, 518, 'role_indexAction', 'index', 'child_of_role', '/admin/role/index', 0, 1),
(2322, 518, 'role_newAction', 'new', 'child_of_role', '/admin/role/new', 0, 1),
(2323, 518, 'role_editAction', 'edit', 'child_of_role', '/admin/role/edit', 0, NULL),
(2324, 518, 'role_trashAction', 'trash', 'child_of_role', '/admin/role/trash', 0, NULL),
(2325, 518, 'role_untrashAction', 'untrash', 'child_of_role', '/admin/role/untrash', 0, NULL),
(2326, 518, 'role_hardDeleteAction', 'hardDelete', 'child_of_role', '/admin/role/harddelete', 0, NULL),
(2327, 518, 'role_assignedAction', 'assigned', 'child_of_role', '/admin/role/assigned', 0, NULL),
(2328, 518, 'role_logAction', 'log', 'child_of_role', '/admin/role/log', 0, 1),
(2329, 518, 'role_unassignPermissionAction', 'unassignPermission', 'child_of_role', '/admin/role/unassignpermission', 0, NULL),
(2330, 518, 'role_settingsAction', 'settings', 'child_of_role', '/admin/role/settings', 0, 1),
(2331, 518, 'role_changeRowAction', 'changeRow', 'child_of_role', '/admin/role/changerow', 0, NULL),
(2332, 518, 'role_chooseBulkAction', 'chooseBulk', 'child_of_role', '/admin/role/choosebulk', 0, NULL),
(2333, 519, 'permission_indexAction', 'index', 'child_of_permission', '/admin/permission/index', 0, 1),
(2334, 519, 'permission_newAction', 'new', 'child_of_permission', '/admin/permission/new', 0, 1),
(2335, 519, 'permission_editAction', 'edit', 'child_of_permission', '/admin/permission/edit', 0, NULL),
(2336, 519, 'permission_trashAction', 'trash', 'child_of_permission', '/admin/permission/trash', 0, NULL),
(2337, 519, 'permission_untrashAction', 'untrash', 'child_of_permission', '/admin/permission/untrash', 0, NULL),
(2338, 519, 'permission_hardDeleteAction', 'hardDelete', 'child_of_permission', '/admin/permission/harddelete', 0, NULL),
(2339, 519, 'permission_settingsAction', 'settings', 'child_of_permission', '/admin/permission/settings', 0, 1),
(2340, 519, 'permission_changeRowAction', 'changeRow', 'child_of_permission', '/admin/permission/changerow', 0, NULL),
(2341, 519, 'permission_chooseBulkAction', 'chooseBulk', 'child_of_permission', '/admin/permission/choosebulk', 0, NULL),
(2342, 520, 'setting_indexAction', 'index', 'child_of_setting', '/admin/setting/index', 0, 1),
(2343, 520, 'setting_generalAction', 'general', 'child_of_setting', '/admin/setting/general', 0, NULL),
(2344, 520, 'setting_securityAction', 'security', 'child_of_setting', '/admin/setting/security', 0, NULL),
(2345, 520, 'setting_purgeAction', 'purge', 'child_of_setting', '/admin/setting/purge', 0, NULL),
(2346, 520, 'setting_toolsAction', 'tools', 'child_of_setting', '/admin/setting/tools', 0, NULL),
(2347, 520, 'setting_localisationAction', 'localisation', 'child_of_setting', '/admin/setting/localisation', 0, NULL),
(2348, 520, 'setting_brandingAction', 'branding', 'child_of_setting', '/admin/setting/branding', 0, NULL),
(2349, 520, 'setting_extensionAction', 'extension', 'child_of_setting', '/admin/setting/extension', 0, NULL),
(2350, 520, 'setting_applicationAction', 'application', 'child_of_setting', '/admin/setting/application', 0, NULL),
(2351, 520, 'setting_settingsAction', 'settings', 'child_of_setting', '/admin/setting/settings', 0, 1),
(2352, 520, 'setting_changeRowAction', 'changeRow', 'child_of_setting', '/admin/setting/changerow', 0, NULL),
(2353, 521, 'ticket_indexAction', 'index', 'child_of_ticket', '/admin/ticket/index', 0, 1),
(2354, 521, 'ticket_newAction', 'new', 'child_of_ticket', '/admin/ticket/new', 0, 1),
(2355, 521, 'ticket_editAction', 'edit', 'child_of_ticket', '/admin/ticket/edit', 0, NULL),
(2356, 521, 'ticket_trashAction', 'trash', 'child_of_ticket', '/admin/ticket/trash', 0, NULL),
(2357, 521, 'ticket_untrashAction', 'untrash', 'child_of_ticket', '/admin/ticket/untrash', 0, NULL),
(2358, 521, 'ticket_hardDeleteAction', 'hardDelete', 'child_of_ticket', '/admin/ticket/harddelete', 0, NULL),
(2359, 521, 'ticket_settingsAction', 'settings', 'child_of_ticket', '/admin/ticket/settings', 0, 1),
(2360, 521, 'ticket_changeRowAction', 'changeRow', 'child_of_ticket', '/admin/ticket/changerow', 0, NULL),
(2361, 521, 'ticket_chooseBulkAction', 'chooseBulk', 'child_of_ticket', '/admin/ticket/choosebulk', 0, NULL),
(2362, 522, 'category_indexAction', 'index', 'child_of_category', '/admin/category/index', 0, 1),
(2363, 522, 'category_newAction', 'new', 'child_of_category', '/admin/category/new', 0, 1),
(2364, 522, 'category_editAction', 'edit', 'child_of_category', '/admin/category/edit', 0, NULL),
(2365, 522, 'category_trashAction', 'trash', 'child_of_category', '/admin/category/trash', 0, NULL),
(2366, 522, 'category_untrashAction', 'untrash', 'child_of_category', '/admin/category/untrash', 0, NULL),
(2367, 522, 'category_hardDeleteAction', 'hardDelete', 'child_of_category', '/admin/category/harddelete', 0, NULL),
(2368, 522, 'category_settingsAction', 'settings', 'child_of_category', '/admin/category/settings', 0, 1),
(2369, 522, 'category_changeRowAction', 'changeRow', 'child_of_category', '/admin/category/changerow', 0, NULL),
(2370, 522, 'category_chooseBulkAction', 'chooseBulk', 'child_of_category', '/admin/category/choosebulk', 0, NULL),
(2371, 523, 'tag_indexAction', 'index', 'child_of_tag', '/admin/tag/index', 0, 1),
(2372, 523, 'tag_newAction', 'new', 'child_of_tag', '/admin/tag/new', 0, 1),
(2373, 523, 'tag_editAction', 'edit', 'child_of_tag', '/admin/tag/edit', 0, NULL),
(2374, 523, 'tag_trashAction', 'trash', 'child_of_tag', '/admin/tag/trash', 0, NULL),
(2375, 523, 'tag_untrashAction', 'untrash', 'child_of_tag', '/admin/tag/untrash', 0, NULL),
(2376, 523, 'tag_hardDeleteAction', 'hardDelete', 'child_of_tag', '/admin/tag/harddelete', 0, NULL),
(2377, 523, 'tag_settingsAction', 'settings', 'child_of_tag', '/admin/tag/settings', 0, 1),
(2378, 523, 'tag_changeRowAction', 'changeRow', 'child_of_tag', '/admin/tag/changerow', 0, NULL),
(2379, 523, 'tag_chooseBulkAction', 'chooseBulk', 'child_of_tag', '/admin/tag/choosebulk', 0, NULL),
(2380, 524, 'message_indexAction', 'index', 'child_of_message', '/admin/message/index', 0, 1),
(2381, 524, 'message_newAction', 'new', 'child_of_message', '/admin/message/new', 0, 1),
(2382, 524, 'message_showAction', 'show', 'child_of_message', '/admin/message/show', 0, NULL),
(2383, 524, 'message_replyAction', 'reply', 'child_of_message', '/admin/message/reply', 0, NULL),
(2384, 524, 'message_forwardAction', 'forward', 'child_of_message', '/admin/message/forward', 0, NULL),
(2385, 524, 'message_starredAction', 'starred', 'child_of_message', '/admin/message/starred', 0, NULL),
(2386, 524, 'message_unstarredAction', 'unstarred', 'child_of_message', '/admin/message/unstarred', 0, NULL),
(2387, 524, 'message_markedAction', 'marked', 'child_of_message', '/admin/message/marked', 0, NULL),
(2388, 524, 'message_unmarkedAction', 'unmarked', 'child_of_message', '/admin/message/unmarked', 0, NULL),
(2389, 524, 'message_settingsAction', 'settings', 'child_of_message', '/admin/message/settings', 0, 1),
(2390, 524, 'message_changeRowAction', 'changeRow', 'child_of_message', '/admin/message/changerow', 0, NULL),
(2394, 526, 'post_indexAction', 'index', 'child_of_post', '/admin/post/index', 0, 1),
(2395, 526, 'post_newAction', 'new', 'child_of_post', '/admin/post/new', 0, 1),
(2396, 526, 'post_editAction', 'edit', 'child_of_post', '/admin/post/edit', 0, NULL),
(2397, 526, 'post_trashAction', 'trash', 'child_of_post', '/admin/post/trash', 0, NULL),
(2398, 526, 'post_untrashAction', 'untrash', 'child_of_post', '/admin/post/untrash', 0, NULL),
(2399, 526, 'post_hardDeleteAction', 'hardDelete', 'child_of_post', '/admin/post/harddelete', 0, NULL),
(2400, 526, 'post_settingsAction', 'settings', 'child_of_post', '/admin/post/settings', 0, 1),
(2401, 526, 'post_changeRowAction', 'changeRow', 'child_of_post', '/admin/post/changerow', 0, NULL);

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
(23, 1270, 'Hello,\r\n\r\nWe have great news! Your subscription includes DataSpell, a new tool for data scientists.\r\n\r\nDataSpell is an IDE designed specifically for those involved in exploratory data analysis and prototyping ML models. DataSpell combines the interactivity of Jupyter notebooks with the intelligent Python and R coding assistance of PyCharm in one convenient environment.', NULL, 'Your subscription includes a new tool – DataSpell', 'sent', 1, 1270, 0, '2022-01-23 23:20:13', '2022-02-01 21:34:58'),
(24, 1270, '', '', 'Et et nihil ex et se', 'sent', 0, 0, 0, '2022-02-12 22:58:14', NULL),
(25, 1270, '', '', '', 'sent', 0, 0, 0, '2022-02-15 00:38:00', NULL);

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
  `notify_status` varchar(10) NOT NULL DEFAULT 'unread',
  `notifier` varchar(190) NOT NULL,
  `notify_description` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_byid` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `notify_title`, `notify_type`, `notify_status`, `notifier`, `notify_description`, `created_at`, `created_byid`) VALUES
(29, 'Route request made on editAction', 'system', 'read', 'dunno yet', 'A request was made from UserController on the editAction method \r\nby Ricardo Miller @ 2022-02-26 : 11:03:06. \r\nThe request was successful.\r\n{\"firstname\":\"Levi\",\"lastname\":\"Knox\",\"email\":\"wutyj@mailinator.com\",\"id\":\"1425\",\"role_id\":\"2\"}', '2022-02-26 11:03:06', 1270),
(30, 'Route request made on trashAction', 'system', 'read', 'dunno yet', 'A request was made from UserController on the trashAction method \r\nby Ricardo Miller @ 2022-02-27 : 10:48:51. \r\nThe request was successful.\r\nnull', '2022-02-27 10:48:51', 1270),
(31, 'Route request made on lockAction', 'system', 'read', 'dunno yet', 'A request was made from UserController on the lockAction method \r\nby Ricardo Miller @ 2022-02-27 : 10:53:51. \r\nThe request was successful.\r\nnull', '2022-02-27 10:53:51', 1270),
(32, 'Route request made on newAction', 'system', 'unread', 'dunno yet', 'A request was made from UserController on the newAction method \r\nby Ricardo Miller @ 2022-02-27 : 10:56:08. \r\nThe request was successful.\r\nnull', '2022-02-27 10:56:08', 1270),
(33, 'Route request made on trashRestoreAction', 'system', 'unread', 'dunno yet', 'A request was made from UserController on the trashRestoreAction method \r\nby Ricardo Miller @ 2022-02-27 : 10:58:51. \r\nThe request was successful.\r\nnull', '2022-02-27 10:58:51', 1270),
(34, 'Route request made on settingsAction', 'system', 'read', 'dunno yet', 'A request was made from UserController on the settingsAction method \r\nby Ricardo Miller @ 2022-02-27 : 12:20:09. \r\nThe request was successful.\r\nnull', '2022-02-27 12:20:09', 1270);

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
  `permission_description` text COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `resource_group` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `created_byid` int(10) UNSIGNED DEFAULT NULL,
  `deleted_at` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `permission_name`, `permission_description`, `resource_group`, `created_at`, `modified_at`, `created_byid`, `deleted_at`) VALUES
(72, 'can_add_user', 'allows to create new user', NULL, '2021-07-03 16:25:09', '2021-07-16 22:57:46', 1, 0),
(73, 'can_edit_user', 'Allows to edit a user', NULL, '2021-07-03 16:25:43', '2021-07-16 22:57:08', 1, 0),
(74, 'can_delete_user', 'Allows to delete a user', NULL, '2021-07-03 16:25:59', '2021-07-16 22:57:00', 1, 0),
(76, 'have_admin_access', 'Basic permission for accessing the admin panel', NULL, '2021-07-07 14:20:26', '2021-07-16 23:01:40', 1, 0),
(77, 'basic_access', 'Permission which allow basic access for all subscriber and user', NULL, '2021-07-07 14:31:15', '2022-02-13 13:22:29', 1270, 0),
(78, 'can_log_user', 'Permission which allows a user to manage the user logs', NULL, '2021-07-07 14:37:51', '2021-07-16 22:58:46', 1, 0),
(79, 'can_view_statistics_user', 'Permissions which allows viewing the user statistics', NULL, '2021-07-07 14:41:41', '2021-07-17 08:13:31', 1, 0),
(81, 'can_show_user', 'Permission for showing a single use row', NULL, '2021-07-09 00:46:41', '2021-07-16 22:57:27', 1, 0),
(82, 'can_view_user', 'access to use index', NULL, '2021-07-14 10:25:17', '2021-07-16 22:10:20', 1, 0),
(84, 'can_edit_privilege_user', 'Allows to edit the user privilege', NULL, '2021-07-16 23:05:19', '2021-07-17 08:12:29', 1, 0),
(85, 'can_add_permission', 'Allow adding of new permissions', 'permission', '2021-07-17 07:58:56', '2022-02-13 13:22:29', 1270, 0),
(86, 'can_view_permission', 'Allow to view the table of permission', NULL, '2021-07-17 07:59:20', NULL, 1, 0),
(87, 'can_edit_permission', 'Allows to edit a permission', NULL, '2021-07-17 07:59:36', NULL, 1, 0),
(88, 'can_delete_permission', 'Allows to delete a permission', NULL, '2021-07-17 07:59:55', '2021-07-25 00:14:26', 1, 0),
(89, 'can_log_permisson', 'Allows to view and modify the permission log', NULL, '2021-07-17 08:00:31', NULL, 1, 0),
(91, 'can_view_role', 'Allows to view the roles table', NULL, '2021-07-17 08:01:29', NULL, 1, 0),
(92, 'can_edit_role', 'Allows to edit a role', NULL, '2021-07-17 08:01:42', NULL, 1, 0),
(93, 'can_delete_role', 'Allows to delete a role', NULL, '2021-07-17 08:01:58', NULL, 1, 0),
(94, 'can_assign_role', 'Allows to assign a group of permissions to a role', NULL, '2021-07-17 08:02:32', NULL, 1, 0),
(95, 'can_remove_assignment_role', 'Allows to remove permission from a role', NULL, '2021-07-17 08:03:38', '2021-07-17 08:13:02', 1, 0),
(96, 'can_log_role', 'Allows to view and modify role log', NULL, '2021-07-17 08:08:48', NULL, 1, 0),
(97, 'can_set_privilege_expiration_user', 'Allows to set an expiration for a privilege', NULL, '2021-07-17 08:14:03', NULL, 1, 0),
(98, 'can_view_dashboard', 'Allows to view the admin dashboard', NULL, '2021-07-17 08:20:11', NULL, 1, 0),
(99, 'can_edit_menu', 'Allows to edit controller menu', NULL, '2021-07-18 14:10:56', NULL, 1, 0),
(100, 'can_view_menu', 'Allows to view menu table', NULL, '2021-07-18 21:21:31', NULL, 1, 0),
(103, 'can_trash_user', 'Allows to view and delete user trash', NULL, '2021-07-18 23:28:51', NULL, 1, 0),
(104, 'can_edit_preferences_user', 'Allows to edit user preferences', NULL, '2021-07-19 11:08:37', '2021-07-19 11:10:06', 1, 0),
(105, 'can_edit_general_setting', 'Allows to edit the system general settings', NULL, '2021-07-20 00:44:50', NULL, 1, 0),
(106, 'can_edit_purge_setting', 'Allows editing purge setting', NULL, '2021-07-20 14:17:08', NULL, 1, 0),
(107, 'can_edit_security_setting', 'Allows editing security setting', NULL, '2021-07-20 14:18:02', NULL, 1, 0),
(108, 'can_edit_tool_setting', 'Allows editing tool setting', NULL, '2021-07-20 14:18:25', NULL, 1, 0),
(109, 'can_add_menu', 'Allows to add new controller menu updated!', NULL, '2021-07-21 22:54:02', '2022-02-13 13:22:29', 1, 0),
(110, 'can_edit_files', 'Allows to edit core yaml files', NULL, '2021-07-22 12:09:35', NULL, 1, 0),
(111, 'can_view_notification', 'Allows to view the notification table', NULL, '2021-07-22 18:19:37', '2021-07-22 18:21:44', 1, 0),
(114, 'can_edit_theme', '', NULL, '2021-07-25 00:12:44', NULL, 1, 0),
(117, 'can_hard_delete_user', 'Allows to permanently delete a user account from the database', NULL, '2021-07-27 15:09:51', NULL, 1, 0),
(118, 'can_restore_trash_user', 'Allows user to manage user trash', NULL, '2021-07-28 20:50:00', NULL, 1, 0),
(119, 'can_lock_user', 'Allows to lock and unlock a user account', NULL, '2021-07-29 08:07:52', NULL, 1, 0),
(120, 'can_unlock_user', 'Allows to unlock locked user account', NULL, '2021-07-29 18:55:29', NULL, 1, 0),
(121, 'can_change_status_user', 'Allows to change an account status', NULL, '2021-07-30 08:42:56', NULL, 1, 0),
(124, 'can_add_role', 'Allow to add roles to system', NULL, '2021-08-09 10:18:56', NULL, 1, 0),
(128, 'can_edit_theme_delete', 'can edit theme delete', NULL, '2021-09-10 10:42:03', NULL, 1, 0),
(131, 'can_bulk_delete_user', 'Can  carry out bulk deletion of users', NULL, '2021-09-21 19:25:10', NULL, 1270, 0),
(132, 'can_bulk_clone_user', 'Can bulk clone user accounts', NULL, '2021-09-22 11:16:10', NULL, 1270, 0),
(133, 'can_clone_user', 'Can clone a single user account', NULL, '2021-09-22 22:13:12', NULL, 1270, 0),
(135, 'can_edit_own_account', 'Allow backend user to edit their own account', NULL, '2022-01-04 16:28:14', NULL, 1270, 0),
(138, 'can_view_message', 'Permission for viewing messages', NULL, '2022-01-16 19:52:47', NULL, 1270, 0),
(140, 'can_bulk_delete_permission', 'Can bulk delete permission', NULL, '2022-01-18 16:44:12', NULL, 1270, 0),
(142, 'can_bulk_delete_role', '', NULL, '2022-01-18 21:11:59', NULL, 1270, 0),
(145, 'can_view_group', 'Can view the permission group table', NULL, '2022-01-23 00:17:51', NULL, 1270, 0),
(146, 'can_add_group', '', NULL, '2022-01-23 00:33:57', '2022-02-13 13:22:29', 1270, 0),
(147, 'can_edit_group', 'Allows to edit and manage all user account', NULL, '2022-01-23 00:43:14', NULL, 1270, 0),
(148, 'can_delete_group', '', NULL, '2022-01-23 00:45:58', NULL, 1270, 0),
(149, 'can_log_group', '', NULL, '2022-01-23 00:48:02', NULL, 1270, 0),
(150, 'can_assign_group', '', NULL, '2022-01-23 11:49:19', NULL, 1270, 0),
(151, 'can_view_ticket', '', NULL, '2022-01-23 19:15:33', NULL, 1270, 0),
(152, 'can_add_ticket', '', NULL, '2022-01-23 19:15:46', NULL, 1270, 0),
(153, 'can_new_ticket', '', NULL, '2022-01-23 19:15:54', NULL, 1270, 0),
(154, 'can_edit_ticket', '', NULL, '2022-01-23 19:16:06', NULL, 1270, 0),
(155, 'can_delete_ticket', '', NULL, '2022-01-23 19:16:22', NULL, 1270, 0),
(156, 'can_delete_menu', 'can delete menu', NULL, '2022-01-27 21:39:10', NULL, 1270, 0),
(157, 'can_view_post', 'Can View post articles', NULL, '2022-02-02 00:35:07', NULL, 1270, 0),
(158, 'can_add_post', 'Can add a post article', NULL, '2022-02-02 00:35:21', NULL, 1270, 0),
(159, 'can_edit_post', 'Can edit a post article', NULL, '2022-02-02 00:35:33', NULL, 1270, 0),
(160, 'can_delete_post', 'Can delete a post article', NULL, '2022-02-02 00:35:58', NULL, 1270, 0),
(161, 'can_trash_post', 'Can put post in trash', NULL, '2022-02-02 00:36:14', NULL, 1270, 0),
(162, 'can_add_category', 'Allow to add new categories', 'category', '2022-02-02 15:42:28', '2022-02-13 13:22:29', 1270, 0),
(163, 'can_edit_category', 'Can edit a category', NULL, '2022-02-02 15:42:47', NULL, 1270, 0),
(164, 'can_delete_category', 'can delete category', NULL, '2022-02-02 15:43:07', NULL, 1270, 0),
(165, 'can_view_category', 'Can view the category listings', NULL, '2022-02-02 15:43:27', NULL, 1270, 0),
(166, 'can_trash_category', 'Allow to trash the queried category', NULL, '2022-02-03 01:26:24', NULL, 1270, 0),
(167, 'can_bulk_restore_category', '', NULL, '2022-02-04 00:41:09', NULL, 1270, 0),
(168, 'can_bulk_delete_category', '', NULL, '2022-02-04 00:58:51', NULL, 1270, 0),
(169, 'can_untrash_category', '', NULL, '2022-02-04 02:30:30', NULL, 1270, 0),
(170, 'can_view_tag', '', NULL, '2022-02-04 03:59:06', NULL, 1270, 0),
(171, 'can_edit_tag', '', NULL, '2022-02-04 04:00:04', NULL, 1270, 0),
(172, 'can_add_tag', '', NULL, '2022-02-04 04:00:26', NULL, 1270, 0),
(173, 'can_delete_tag', '', NULL, '2022-02-04 20:53:12', NULL, 1270, 0),
(174, 'can_bulk_delete_tag', '', NULL, '2022-02-04 20:53:26', NULL, 1270, 0),
(176, 'can_untrash_tag', '', NULL, '2022-02-04 20:54:54', NULL, 1270, 0),
(177, 'can_trash_tag', '', NULL, '2022-02-04 20:55:25', NULL, 1270, 0),
(179, 'can_trash_permission', '', NULL, '2022-02-05 10:29:01', NULL, 1270, 0),
(182, 'can_trash_role', '', NULL, '2022-02-05 10:38:33', NULL, 1270, 0),
(183, 'can_untrash_permission', '', NULL, '2022-02-05 12:07:50', NULL, 1270, 0),
(185, 'can_bulk_restore_permission', '', NULL, '2022-02-05 12:27:54', NULL, 1270, 0),
(188, 'can_untrash_role', '', NULL, '2022-02-05 14:49:26', NULL, 1270, 0),
(189, 'can_bulk_untrash_role', '', NULL, '2022-02-05 14:49:37', NULL, 1270, 0),
(190, 'can_bulk_trash_role', '', NULL, '2022-02-05 14:53:23', NULL, 1270, 0),
(191, 'can_bulk_restore_role', '', NULL, '2022-02-05 14:54:19', NULL, 1270, 0),
(192, 'can_bulk_trash_category', '', NULL, '2022-02-05 15:06:59', NULL, 1270, 0),
(193, 'can_bulk_trash_tag', '', NULL, '2022-02-05 15:07:13', NULL, 1270, 0),
(194, 'can_bulk_untrash_category', '', NULL, '2022-02-05 15:07:30', NULL, 1270, 0),
(195, 'can_bulk_untrash_tag', '', NULL, '2022-02-05 15:07:42', NULL, 1270, 0),
(196, 'can_bulk_clone_category', '', NULL, '2022-02-05 15:07:58', NULL, 1270, 0),
(197, 'can_bulk_restore_tag', '', NULL, '2022-02-05 15:17:22', NULL, 1270, 0),
(198, 'can_trash_ticket', '', NULL, '2022-02-05 19:23:04', NULL, 1270, 0),
(199, 'can_bulk_restore_ticket', '', NULL, '2022-02-05 19:23:27', NULL, 1270, 0),
(200, 'can_bulk_untrash_ticket', '', NULL, '2022-02-05 19:23:43', NULL, 1270, 0),
(201, 'can_restore_ticket', '', NULL, '2022-02-05 19:29:49', NULL, 1270, 0),
(202, 'can_untrash_ticket', '', NULL, '2022-02-05 19:30:37', NULL, 1270, 0),
(203, 'can_bulk_trash_ticket', '', NULL, '2022-02-05 19:43:27', NULL, 1270, 0),
(205, 'can_bulk_delete_ticket', '', NULL, '2022-02-05 20:17:33', NULL, 1270, 0),
(206, 'can_bulk_trash_menu', '', NULL, '2022-02-06 10:00:00', NULL, 1270, 0),
(207, 'can_bulk_restore_menu', '', NULL, '2022-02-06 10:00:16', NULL, 1270, 0),
(208, 'can_bulk_delete_menu', '', NULL, '2022-02-06 10:00:29', NULL, 1270, 0),
(209, 'can_bulk_untrash_menu', '', NULL, '2022-02-06 10:00:42', NULL, 1270, 0),
(210, 'can_restore_menu', '', NULL, '2022-02-06 10:00:53', NULL, 1270, 0),
(212, 'can_untrash_menu', '', NULL, '2022-02-06 10:04:24', NULL, 1270, 0),
(213, 'can_bulk_trash_permission', '', NULL, '2022-02-08 20:00:27', NULL, 1270, 0),
(214, 'can_manage_settings_user', '', NULL, '2022-02-09 09:29:47', NULL, 1270, 0),
(215, 'can_manage_settings_permission', '', NULL, '2022-02-10 02:42:47', NULL, 1270, 0),
(216, 'can_manage_settings_tag', '', NULL, '2022-02-10 03:06:17', NULL, 1270, 0),
(218, 'can_manage_settings_category', '', NULL, '2022-02-10 03:07:13', NULL, 1270, 0),
(219, 'can_manage_settings_post', '', NULL, '2022-02-10 03:07:56', NULL, 1270, 0),
(220, 'can_manage_settings_group', '', NULL, '2022-02-10 03:10:11', NULL, 1270, 0),
(221, 'can_manage_settings_dashboard', '', NULL, '2022-02-10 03:33:55', NULL, 1270, 0),
(223, 'can_manage_settings_role', '', NULL, '2022-02-10 05:39:34', NULL, 1270, 0),
(225, 'can_hardDelete_tag', 'This is a default description for can_hardDelete_tag', 'tag', '2022-02-16 01:04:03', NULL, 1, 0),
(226, 'can_settings_tag', 'This is a default description for can_settings_tag', 'tag', '2022-02-16 01:05:35', NULL, 1, 0),
(227, 'can_controllerViewGlobals_ticket', 'This is a default description for can_controllerViewGlobals_ticket', 'ticket', '2022-02-16 01:08:18', NULL, 1, 0),
(228, 'can_hardDelete_ticket', 'This is a default description for can_hardDelete_ticket', 'ticket', '2022-02-16 01:08:48', NULL, 1, 0),
(229, 'can_settings_ticket', 'This is a default description for can_settings_ticket', 'ticket', '2022-02-16 01:08:49', NULL, 1, 0),
(230, 'can_callBeforeMiddlewares_ticket', 'This is a default description for can_callBeforeMiddlewares_ticket', 'ticket', '2022-02-16 01:08:50', NULL, 1, 0),
(232, 'can_settings_permission', 'This is a default description for can_settings_permission', 'permission', '2022-02-16 01:08:55', NULL, 1, 0),
(236, 'can_defineCoreMiddeware_permission', 'This is a default description for can_defineCoreMiddeware_permission', 'permission', '2022-02-16 01:09:04', NULL, 1, 0),
(237, 'can_before_permission', 'This is a default description for can_before_permission', 'permission', '2022-02-16 01:09:25', NULL, 1, 0),
(238, 'can_after_permission', 'This is a default description for can_after_permission', 'permission', '2022-02-16 01:09:25', NULL, 1, 0),
(239, 'can_diContainer_permission', 'This is a default description for can_diContainer_permission', 'permission', '2022-02-16 01:09:26', NULL, 1, 0),
(240, 'can_validateSession_permission', 'This is a default description for can_validateSession_permission', 'permission', '2022-02-16 01:09:26', NULL, 1, 0),
(241, 'can_controllerViewGlobals_permission', 'This is a default description for can_controllerViewGlobals_permission', 'permission', '2022-02-16 01:09:28', NULL, 1, 0),
(242, 'can_hardDelete_category', 'This is a default description for can_hardDelete_category', 'category', '2022-02-16 01:09:55', NULL, 1, 0),
(243, 'can_settings_category', 'This is a default description for can_settings_category', 'category', '2022-02-16 01:09:55', NULL, 1, 0),
(244, 'can_callBeforeMiddlewares_category', 'This is a default description for can_callBeforeMiddlewares_category', 'category', '2022-02-16 01:09:56', NULL, 1, 0),
(245, 'can_chooseBulk_permission', 'This is a default description for can_chooseBulk_permission', 'permission', '2022-02-16 01:10:05', NULL, 1, 0),
(246, 'can_callBeforeMiddlewares_security', 'This is a default description for can_callBeforeMiddlewares_security', 'security', '2022-02-16 18:18:46', NULL, 1, 0),
(247, 'can_view_security', 'This is a default description for can_view_security', 'security', '2022-02-16 18:18:46', NULL, 1, 0),
(248, 'can_session_security', 'This is a default description for can_session_security', 'security', '2022-02-16 18:18:47', NULL, 1, 0),
(249, 'can_defineCoreMiddeware_security', 'This is a default description for can_defineCoreMiddeware_security', 'security', '2022-02-16 18:19:05', NULL, 1, 0),
(250, 'can_callAfterMiddlewares_security', 'This is a default description for can_callAfterMiddlewares_security', 'security', '2022-02-16 18:19:05', NULL, 1, 0),
(251, 'can_before_security', 'This is a default description for can_before_security', 'security', '2022-02-16 18:31:05', NULL, 1, 0),
(252, 'can_after_security', 'This is a default description for can_after_security', 'security', '2022-02-16 18:31:06', NULL, 1, 0),
(253, 'can_diContainer_security', 'This is a default description for can_diContainer_security', 'security', '2022-02-16 18:31:06', NULL, 1, 0),
(254, 'can_callBeforeMiddlewares_home', 'This is a default description for can_callBeforeMiddlewares_home', 'home', '2022-02-16 20:58:54', NULL, 1, 0),
(255, 'can_view_home', 'This is a default description for can_view_home', 'home', '2022-02-16 20:58:54', NULL, 1, 0),
(256, 'can_defineCoreMiddeware_home', 'This is a default description for can_defineCoreMiddeware_home', 'home', '2022-02-16 20:58:54', NULL, 1, 0),
(257, 'can_validateSession_security', 'This is a default description for can_validateSession_security', 'security', '2022-02-16 20:58:59', NULL, 1, 0),
(258, 'can_controllerViewGlobals_security', 'This is a default description for can_controllerViewGlobals_security', 'security', '2022-02-16 20:58:59', NULL, 1, 0),
(259, 'can_callAfterMiddlewares_home', 'This is a default description for can_callAfterMiddlewares_home', 'home', '2022-02-16 20:59:44', NULL, 1, 0),
(260, 'can_before_home', 'This is a default description for can_before_home', 'home', '2022-02-16 20:59:44', NULL, 1, 0),
(261, 'can_after_home', 'This is a default description for can_after_home', 'home', '2022-02-16 20:59:45', NULL, 1, 0),
(262, 'can_callAfterMiddlewares_category', 'This is a default description for can_callAfterMiddlewares_category', 'category', '2022-02-16 21:01:25', NULL, 1, 0),
(263, 'can_changeRow_category', 'This is a default description for can_changeRow_category', 'category', '2022-02-16 21:01:26', NULL, 1, 0),
(264, 'can_defineCoreMiddeware_category', 'This is a default description for can_defineCoreMiddeware_category', 'category', '2022-02-16 21:01:27', NULL, 1, 0),
(265, 'can_before_category', 'This is a default description for can_before_category', 'category', '2022-02-16 21:01:33', NULL, 1, 0),
(266, 'can_after_category', 'This is a default description for can_after_category', 'category', '2022-02-16 21:01:33', NULL, 1, 0),
(267, 'can_diContainer_category', 'This is a default description for can_diContainer_category', 'category', '2022-02-16 21:01:34', NULL, 1, 0),
(268, 'can_validateSession_category', 'This is a default description for can_validateSession_category', 'category', '2022-02-16 21:01:35', NULL, 1, 0),
(269, 'can_controllerViewGlobals_category', 'This is a default description for can_controllerViewGlobals_category', 'category', '2022-02-16 21:01:37', NULL, 1, 0),
(270, 'can_trash_menu', 'This is a default description for can_trash_menu', 'menu', '2022-02-16 21:02:13', NULL, 1, 0),
(271, 'can_hardDelete_menu', 'This is a default description for can_hardDelete_menu', 'menu', '2022-02-16 21:02:14', NULL, 1, 0),
(272, 'can_removeItem_menu', 'This is a default description for can_removeItem_menu', 'menu', '2022-02-16 21:02:16', NULL, 1, 0),
(273, 'can_settings_menu', 'This is a default description for can_settings_menu', 'menu', '2022-02-16 21:09:04', NULL, 1, 0),
(274, 'can_quickSave_menu', 'This is a default description for can_quickSave_menu', 'menu', '2022-02-16 21:09:05', NULL, 1, 0),
(275, 'can_callBeforeMiddlewares_menu', 'This is a default description for can_callBeforeMiddlewares_menu', 'menu', '2022-02-16 21:09:07', NULL, 1, 0),
(276, 'can_callAfterMiddlewares_menu', 'This is a default description for can_callAfterMiddlewares_menu', 'menu', '2022-02-16 21:09:25', NULL, 1, 0),
(277, 'can_changeRow_menu', 'This is a default description for can_changeRow_menu', 'menu', '2022-02-16 21:09:26', NULL, 1, 0),
(278, 'can_defineCoreMiddeware_menu', 'This is a default description for can_defineCoreMiddeware_menu', 'menu', '2022-02-16 21:09:28', NULL, 1, 0),
(279, 'can_before_menu', 'This is a default description for can_before_menu', 'menu', '2022-02-16 21:09:46', NULL, 1, 0),
(280, 'can_after_menu', 'This is a default description for can_after_menu', 'menu', '2022-02-16 21:09:47', NULL, 1, 0),
(281, 'can_diContainer_menu', 'This is a default description for can_diContainer_menu', 'menu', '2022-02-16 21:09:49', NULL, 1, 0),
(282, 'can_validateSession_menu', 'This is a default description for can_validateSession_menu', 'menu', '2022-02-16 21:10:30', NULL, 1, 0),
(283, 'can_controllerViewGlobals_menu', 'This is a default description for can_controllerViewGlobals_menu', 'menu', '2022-02-16 21:10:31', NULL, 1, 0),
(284, 'can_chooseBulk_menu', 'This is a default description for can_chooseBulk_menu', 'menu', '2022-02-16 21:10:33', NULL, 1, 0),
(285, 'can_order_menu', 'This is a default description for can_order_menu', 'menu', '2022-02-16 21:21:53', NULL, 1, 0),
(287, 'can_manage_settings_menu', '', 'menu', '2022-02-17 10:25:26', NULL, 1270, 0);

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
  `schedule_at` datetime DEFAULT NULL,
  `deleted_at` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
('6704e220b3e15477d24b58c5dacdb5c2b7a314cbf06ff7fe6409941ecd6c226d', 1270, '2022-02-13 08:23:19'),
('f79f219082c82bc2680de7655b77984e59e1ca3b19810206aaab6a76ffc6bb74', 1270, '2022-03-25 12:44:23');

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
(2, 'Subscriber', 'Basic role for users', '2021-02-19 01:46:04', '2022-02-05 14:54:47', 1, 0);

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
(1, 114),
(1, 117),
(1, 118),
(1, 119),
(1, 120),
(1, 121),
(1, 91),
(1, 124),
(1, 128),
(1, 131),
(1, 132),
(1, 133),
(1, 135),
(1, 138),
(1, 140),
(1, 142),
(1, 145),
(1, 146),
(1, 147),
(1, 148),
(1, 149),
(1, 150),
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
(1, 197),
(1, 198),
(1, 199),
(1, 200),
(1, 201),
(1, 202),
(1, 203),
(1, 205),
(1, 206),
(1, 207),
(1, 208),
(1, 209),
(1, 210),
(1, 212),
(1, 213),
(1, 214),
(1, 215),
(1, 216),
(1, 218),
(1, 219),
(1, 220),
(1, 221),
(1, 223),
(1, 287);

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
-- Table structure for table `session_backup`
--

CREATE TABLE `session_backup` (
  `id` int(10) UNSIGNED NOT NULL,
  `controller` varchar(20) NOT NULL,
  `context` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `session_backup`
--

INSERT INTO `session_backup` (`id`, `controller`, `context`, `created_at`) VALUES
(45, 'user_settings', 'a:4:{s:16:\"records_per_page\";s:1:\"5\";s:17:\"trash_can_support\";s:5:\"false\";s:5:\"query\";s:6:\"status\";s:12:\"filter_alias\";s:1:\"s\";}', '2022-02-10 12:12:13'),
(47, 'role_settings', 'a:4:{s:16:\"records_per_page\";s:1:\"5\";s:17:\"trash_can_support\";s:4:\"true\";s:5:\"query\";s:6:\"status\";s:12:\"filter_alias\";s:1:\"s\";}', '2022-02-17 10:49:59'),
(48, 'category_settings', 'a:4:{s:16:\"records_per_page\";s:1:\"5\";s:17:\"trash_can_support\";s:4:\"true\";s:5:\"query\";s:0:\"\";s:12:\"filter_alias\";s:1:\"s\";}', '2022-02-19 22:46:19');

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
(24, 'menu_icon', 'on'),
(25, 'menu_icon_size', '0.9');

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
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `category`, `ticket_desc`, `attachment`, `status`, `priority`, `assigned_to`, `reassigned_to`, `created_byid`, `created_at`, `modified_at`, `deleted_at`) VALUES
(1, 'general', 'this is ticket test description', NULL, 'open', 'critical', 1270, NULL, 1270, '2022-02-08 15:53:47', NULL, 0);

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
-- Table structure for table `updates`
--

CREATE TABLE `updates` (
  `id` int(10) UNSIGNED NOT NULL,
  `old_version` varchar(5) NOT NULL,
  `new_version` varchar(5) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `updates`
--

INSERT INTO `updates` (`id`, `old_version`, `new_version`, `created_at`) VALUES
(1, '1.3', '1.4', '2022-02-08 13:52:06');

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
(1417, 'Barrett', 'Stephensons', 'zane@mailinator.com', 'https://www.gravatar.com/avatar/48c8bfb7b5c1f9875584d4201ef5f062?s=200&d=mystery&r=R', 'lock', '$2y$10$tQ66Tk4jZhpw5p6RFAcRk.Mq7r.XEjza/X.piyU7LuntD.UeO1yFC', NULL, NULL, '83d90585dfbde86afd6541d18e0c2cf120839a58c7b6317f82be18c5d54e0790', 1270, '2022-02-08 17:25:19', '2022-02-27 10:53:51', NULL, NULL, '::1', 0, NULL),
(1418, 'Celeste', 'Hansen', 'jyvy@mailinator.com', 'https://www.gravatar.com/avatar/4e520a700d96efa2b20010a7e34d8d22?s=200&d=mystery&r=R', 'trash', '$2y$10$klgz1iETyC6vti/zDpl/XeBs11lqswP6cI4zVxNbsxRuag0gcXHTi', NULL, NULL, '0f3dca3907455fe2478b65140ef9fd2f1a5bcfc5c8a0190b637b16ce1e6e2150', 1270, '2022-02-08 17:26:21', NULL, NULL, NULL, '::1', 0, NULL),
(1419, 'Patrick', 'David', 'deximy@mailinator.com', 'https://www.gravatar.com/avatar/c7582f0e274f584dacfd6db1e460d71e?s=200&d=mystery&r=R', 'active', '$2y$10$4Q72q8divc01vYPjD2fpGOnl1MdoQPez6TyJYgRKbu2DfIoSUsnTe', NULL, NULL, '933a44bf603061239850de6b6a796bdcfe7949e25c37fcb5d19af2d7e09f02d5', 1270, '2022-02-08 17:28:31', '2022-02-27 10:58:51', NULL, NULL, '::1', 0, NULL),
(1420, 'Baxter', 'Johnsons', 'sawamykug@mailinator.com', 'https://www.gravatar.com/avatar/8f992695a0b8660c0951f79d1489d3e3?s=200&d=mystery&r=R', 'active', '$2y$10$1zkAZD7f2omfaliScHMEU.dNzK.a2K/cO1tOTV3FCFP0ZdqBJAHSO', NULL, NULL, '61685dda946df909979f3958b8108cfa53fcc13f3f0b0d75fe8a11cdf8ebd63f', 1270, '2022-02-08 19:32:50', '2022-02-26 10:26:28', NULL, NULL, '::1', 0, NULL),
(1421, 'MacKensie', 'Hatfield', 'jylabuzus@mailinator.com', 'https://www.gravatar.com/avatar/3e00c174460e2d8633086a033d35931f?s=200&d=mystery&r=R', 'active', '$2y$10$pVg0M3wTt4ygYbX4yFo4kOuDxRd9XPrQEW431F.CopHfPQp2SgPAS', NULL, NULL, 'cca419dc70df09d70550b3f1675e55171d71f919512d1d1faadbc1df75db99c4', 1270, '2022-02-08 19:33:01', '2022-02-17 10:36:30', NULL, NULL, '::1', 0, NULL),
(1422, 'Oprah', 'Montoya', 'zefuwucela@mailinator.com', 'https://www.gravatar.com/avatar/c7f17d7adbf74ce62d2b0c9b3b89f2a2?s=200&d=mystery&r=R', 'pending', '$2y$10$cKM8DL6RhXb7gmGHoDY1EOeKJ2rPcCw18f3jVbrI733WroRHmvMWO', NULL, NULL, '0ed1ac0cb64df5ce22dd333c5d77eec14a5e549cea4f5330f8f908c641bc130f', 1270, '2022-02-08 19:37:48', NULL, NULL, NULL, '::1', 0, NULL),
(1424, 'Hedwig', 'Saunders', 'pyjyle@mailinator.com', 'https://www.gravatar.com/avatar/48bdadea324a36185471aae0cb3f464a?s=200&d=mystery&r=R', 'pending', '$2y$10$YfKW46.t2lxt4ypjE8DGnO4Oz882vIBwSG7GVgUQdNyovLDahnrt.', NULL, NULL, '9235d36bcedfd3ad01320a474a2a4b8b04b1150fc471273c8b58449ed49f7e50', 1270, '2022-02-08 19:40:03', NULL, NULL, NULL, '::1', 0, NULL),
(1425, 'Levi', 'Knox', 'wutyj@mailinator.com', 'https://www.gravatar.com/avatar/3b98e242236d37860c3d884e837ed118?s=200&d=mystery&r=R', 'active', '$2y$10$gCDnlEFxtfjVnrUZAwQGM.VvT596qqndduL9lqhmO2yIPPnNA8zv6', NULL, NULL, '5b0da80b586326eadb0bf38e90229b215fb94d6ce51d7bf3ff37520fc5f3d988', 1270, '2022-02-08 19:43:09', '2022-02-26 11:03:06', NULL, NULL, '::1', 0, NULL),
(1426, 'Cassidy', 'Hester', 'wamyky@mailinator.com', 'https://www.gravatar.com/avatar/46cd03af7877d4bc89fe3a156762075b?s=200&d=mystery&r=R', 'pending', '$2y$10$EtgyYohfXP8vtVH71NnTW.Ed/FC9SWHYR93r9qmZLZIMnk3vlfd2e', NULL, NULL, 'dd6d331bd5c4752215365926b3af73a77bc5005888eda3639a38a65ed194caec', 1270, '2022-02-25 13:21:57', NULL, NULL, NULL, '::1', 0, NULL),
(1427, 'Orson', 'Herrera', 'lucevaw@mailinator.com', 'https://www.gravatar.com/avatar/3f4b914af0385f33b2bd7c06292e9f53?s=200&d=mystery&r=R', 'pending', '$2y$10$y95P.s/Vwa/CpbpEQfVYXOnAdM4erwiCh908fZXl1mkZpTS2r4HK.', NULL, NULL, '8e43bd093619b662e043f5ede567f02202cd3b5ba305d1be2c9327c32e4c139d', 1270, '2022-02-27 10:56:06', NULL, NULL, NULL, '::1', 0, NULL);

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
(89, 1417, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(90, 1418, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(91, 1419, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(92, 1420, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(93, 1421, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(94, 1422, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(96, 1424, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(97, 1425, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(98, 1426, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}'),
(99, 1427, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}');

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
(3, 1417, 'Welcome Barrett Stephenson', '2022-02-08 17:25:22', NULL),
(4, 1418, 'Welcome Celeste Hansen', '2022-02-08 17:26:21', NULL),
(5, 1419, 'Welcome Patrick David', '2022-02-08 17:28:33', NULL),
(6, 1420, 'Welcome Baxter Johnson', '2022-02-08 19:32:50', NULL),
(7, 1421, 'Welcome MacKensie Hatfield', '2022-02-08 19:33:04', NULL),
(8, 1422, 'Welcome Oprah Montoya', '2022-02-08 19:37:50', NULL),
(10, 1424, 'Welcome Hedwig Saunders', '2022-02-08 19:40:05', NULL),
(11, 1425, 'Welcome Lev Knox', '2022-02-08 19:43:09', NULL),
(12, 1426, 'Welcome Cassidy Hester', '2022-02-25 13:22:00', NULL),
(13, 1427, 'Welcome Orson Herrera', '2022-02-27 10:56:08', NULL);

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
  `enable_notification` int(1) DEFAULT 1,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_preferences`
--

INSERT INTO `user_preferences` (`id`, `user_id`, `address`, `language`, `week_start_on`, `enable_notification`, `updated_at`) VALUES
(1, 1422, NULL, 'en_GB', 0, 1, NULL),
(3, 1424, NULL, 'en_GB', 0, 1, NULL),
(4, 1425, NULL, 'en_GB', 0, 1, NULL),
(5, 1426, NULL, 'en_GB', 0, 1, NULL),
(6, 1427, NULL, 'en_GB', 0, 1, NULL);

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
(1417, 2),
(1418, 2),
(1419, 2),
(1420, 2),
(1424, 2),
(1421, 2),
(1426, 2),
(1425, 2),
(1427, 2);

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
-- Indexes for table `controllers`
--
ALTER TABLE `controllers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `controller` (`controller`);

--
-- Indexes for table `controller_settings`
--
ALTER TABLE `controller_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `controller_name` (`controller_name`),
  ADD KEY `controller_menu_id` (`controller_menu_id`);

--
-- Indexes for table `dashboard`
--
ALTER TABLE `dashboard`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `session_backup`
--
ALTER TABLE `session_backup`
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
-- Indexes for table `updates`
--
ALTER TABLE `updates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `old_version` (`old_version`),
  ADD UNIQUE KEY `new_version` (`new_version`);

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `controllers`
--
ALTER TABLE `controllers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `controller_settings`
--
ALTER TABLE `controller_settings`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `dashboard`
--
ALTER TABLE `dashboard`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_log`
--
ALTER TABLE `event_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=279;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `localisations`
--
ALTER TABLE `localisations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=527;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2402;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=288;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=198;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=245;

--
-- AUTO_INCREMENT for table `session_backup`
--
ALTER TABLE `session_backup`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

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
-- AUTO_INCREMENT for table `updates`
--
ALTER TABLE `updates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1428;

--
-- AUTO_INCREMENT for table `user_logs`
--
ALTER TABLE `user_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_metadata`
--
ALTER TABLE `user_metadata`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `user_note`
--
ALTER TABLE `user_note`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `user_preferences`
--
ALTER TABLE `user_preferences`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
