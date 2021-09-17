-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 17, 2021 at 10:51 AM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.7

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
  `created_byid` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `cat_name`, `cat_slug`, `cat_parent`, `created_at`, `modified_at`, `created_byid`) VALUES
(10, 'People', 'people', NULL, '2020-07-03 17:58:30', NULL, 1);

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
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `created_byid` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `menu_name`, `menu_description`, `parent_menu`, `menu_order`, `menu_break_point`, `created_at`, `modified_at`, `created_byid`) VALUES
(348, 'dashboard', 'dashboard parent menu item.', 1, 100, NULL, '2021-09-09 15:56:18', '2021-09-10 10:42:36', 1),
(349, 'role', 'role parent menu item.', 1, 95, NULL, '2021-09-09 15:56:24', '2021-09-13 23:47:26', 1),
(350, 'user', 'user parent menu item.', 1, 99, NULL, '2021-09-09 15:56:43', '2021-09-10 10:43:05', 1),
(351, 'menu', 'menu parent menu item.', 1, NULL, NULL, '2021-09-09 15:58:21', NULL, 0),
(352, 'plugin', 'plugin parent menu item.', 1, NULL, NULL, '2021-09-09 15:58:26', NULL, 0),
(353, 'setting', 'setting parent menu item.', 1, NULL, NULL, '2021-09-09 15:58:54', NULL, 0),
(354, 'system', 'system parent menu item.', 1, NULL, NULL, '2021-09-09 15:58:59', NULL, 0),
(355, 'permission', 'permission parent menu item.', 1, 90, NULL, '2021-09-10 10:37:26', '2021-09-13 23:46:48', 1);

-- --------------------------------------------------------

--
-- Table structure for table `menu_item`
--

CREATE TABLE `menu_item` (
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
-- Dumping data for table `menu_item`
--

INSERT INTO `menu_item` (`id`, `item_original_id`, `item_original_label`, `item_label`, `item_type`, `item_url`, `item_order`, `item_usable`) VALUES
(861, 348, 'dashboard_indexAction', 'index', 'child_of_dashboard', '/admin/dashboard/index', 0, 1),
(862, 348, 'dashboard_changeRowsAction', 'changeRows', 'child_of_dashboard', '/admin/dashboard/changerows', 0, NULL),
(863, 349, 'role_indexAction', 'index', 'child_of_role', '/admin/role/index', 0, 1),
(864, 349, 'role_newAction', 'new', 'child_of_role', '/admin/role/new', 0, 1),
(865, 349, 'role_editAction', 'edit', 'child_of_role', '/admin/role/edit', 0, NULL),
(866, 349, 'role_deleteAction', 'delete', 'child_of_role', '/admin/role/delete', 0, NULL),
(867, 349, 'role_assignedAction', 'assigned', 'child_of_role', '/admin/role/assigned', 0, NULL),
(868, 349, 'role_logAction', 'log', 'child_of_role', '/admin/role/log', 0, NULL),
(869, 349, 'role_unassignPermissionAction', 'unassignPermission', 'child_of_role', '/admin/role/unassignpermission', 0, NULL),
(870, 349, 'role_changeRowsAction', 'changeRows', 'child_of_role', '/admin/role/changerows', 0, NULL),
(871, 350, 'user_indexAction', 'index', 'child_of_user', '/admin/user/index', 0, 1),
(872, 350, 'user_showAction', 'show', 'child_of_user', '/admin/user/show', 0, NULL),
(873, 350, 'user_newAction', 'new', 'child_of_user', '/admin/user/new', 0, 1),
(874, 350, 'user_editAction', 'edit', 'child_of_user', '/admin/user/edit', 0, NULL),
(875, 350, 'user_deleteAction', 'delete', 'child_of_user', '/admin/user/delete', 0, NULL),
(876, 350, 'user_hardDeleteAction', 'hardDelete', 'child_of_user', '/admin/user/harddelete', 0, NULL),
(877, 350, 'user_bulkAction', 'bulk', 'child_of_user', '/admin/user/bulk', 0, NULL),
(878, 350, 'user_cloneAction', 'clone', 'child_of_user', '/admin/user/clone', 0, NULL),
(879, 350, 'user_lockAction', 'lock', 'child_of_user', '/admin/user/lock', 0, NULL),
(880, 350, 'user_unlockAction', 'unlock', 'child_of_user', '/admin/user/unlock', 0, NULL),
(881, 350, 'user_trashAction', 'trash', 'child_of_user', '/admin/user/trash', 0, NULL),
(882, 350, 'user_trashRestoreAction', 'trashRestore', 'child_of_user', '/admin/user/trashrestore', 0, NULL),
(883, 350, 'user_activeAction', 'active', 'child_of_user', '/admin/user/active', 0, NULL),
(884, 350, 'user_preferencesAction', 'preferences', 'child_of_user', '/admin/user/preferences', 0, NULL),
(885, 350, 'user_privilegeAction', 'privilege', 'child_of_user', '/admin/user/privilege', 0, NULL),
(886, 350, 'user_privilegeExpirationAction', 'privilegeExpiration', 'child_of_user', '/admin/user/privilegeexpiration', 0, NULL),
(887, 350, 'user_logAction', 'log', 'child_of_user', '/admin/user/log', 0, 1),
(888, 350, 'user_changeRowsAction', 'changeRows', 'child_of_user', '/admin/user/changerows', 0, NULL),
(889, 351, 'menu_indexAction', 'index', 'child_of_menu', '/admin/menu/index', 0, 1),
(890, 351, 'menu_newAction', 'new', 'child_of_menu', '/admin/menu/new', 0, 1),
(891, 351, 'menu_editAction', 'edit', 'child_of_menu', '/admin/menu/edit', 0, NULL),
(892, 351, 'menu_removeItemAction', 'removeItem', 'child_of_menu', '/admin/menu/removeitem', 0, NULL),
(893, 351, 'menu_changeRowsAction', 'changeRows', 'child_of_menu', '/admin/menu/changerows', 0, NULL),
(894, 352, 'plugin_indexAction', 'index', 'child_of_plugin', '/admin/plugin/index', 0, 1),
(895, 352, 'plugin_changeRowsAction', 'changeRows', 'child_of_plugin', '/admin/plugin/changerows', 0, NULL),
(896, 353, 'setting_indexAction', 'index', 'child_of_setting', '/admin/setting/index', 0, 1),
(897, 353, 'setting_generalAction', 'general', 'child_of_setting', '/admin/setting/general', 0, NULL),
(898, 353, 'setting_securityAction', 'security', 'child_of_setting', '/admin/setting/security', 0, NULL),
(899, 353, 'setting_purgeAction', 'purge', 'child_of_setting', '/admin/setting/purge', 0, NULL),
(900, 353, 'setting_toolsAction', 'tools', 'child_of_setting', '/admin/setting/tools', 0, NULL),
(901, 353, 'setting_localisationAction', 'localisation', 'child_of_setting', '/admin/setting/localisation', 0, NULL),
(902, 353, 'setting_brandingAction', 'branding', 'child_of_setting', '/admin/setting/branding', 0, NULL),
(903, 353, 'setting_extensionAction', 'extension', 'child_of_setting', '/admin/setting/extension', 0, NULL),
(904, 353, 'setting_applicationAction', 'application', 'child_of_setting', '/admin/setting/application', 0, NULL),
(905, 353, 'setting_changeRowsAction', 'changeRows', 'child_of_setting', '/admin/setting/changerows', 0, NULL),
(906, 354, 'system_indexAction', 'index', 'child_of_system', '/admin/system/index', 0, 1),
(907, 355, 'permission_indexAction', 'index', 'child_of_permission', '/admin/permission/index', 0, 1),
(908, 355, 'permission_newAction', 'new', 'child_of_permission', '/admin/permission/new', 0, 1),
(909, 355, 'permission_editAction', 'edit', 'child_of_permission', '/admin/permission/edit', 0, NULL),
(910, 355, 'permission_deleteAction', 'delete', 'child_of_permission', '/admin/permission/delete', 0, NULL),
(911, 355, 'permission_bulkAction', 'bulk', 'child_of_permission', '/admin/permission/bulk', 0, NULL),
(912, 355, 'permission_changeRowsAction', 'changeRows', 'child_of_permission', '/admin/permission/changerows', 0, NULL);

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
  `created_byid` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `permission_name`, `permission_description`, `created_at`, `modified_at`, `created_byid`) VALUES
(72, 'can_add_user', 'allows to create new user', '2021-07-03 16:25:09', '2021-07-16 22:57:46', 1),
(73, 'can_edit_user', 'Allows to edit a user', '2021-07-03 16:25:43', '2021-07-16 22:57:08', 1),
(74, 'can_delete_user', 'Allows to delete a user', '2021-07-03 16:25:59', '2021-07-16 22:57:00', 1),
(76, 'have_admin_access', 'Basic permission for accessing the admin panel', '2021-07-07 14:20:26', '2021-07-16 23:01:40', 1),
(77, 'basic_access', 'Permission which allow basic access for all subscriber', '2021-07-07 14:31:15', NULL, 1),
(78, 'can_log_user', 'Permission which allows a user to manage the user logs', '2021-07-07 14:37:51', '2021-07-16 22:58:46', 1),
(79, 'can_view_statistics_user', 'Permissions which allows viewing the user statistics', '2021-07-07 14:41:41', '2021-07-17 08:13:31', 1),
(81, 'can_show_user', 'Permission for showing a single use row', '2021-07-09 00:46:41', '2021-07-16 22:57:27', 1),
(82, 'can_view_user', 'access to use index', '2021-07-14 10:25:17', '2021-07-16 22:10:20', 1),
(84, 'can_edit_privilege_user', 'Allows to edit the user privilege', '2021-07-16 23:05:19', '2021-07-17 08:12:29', 1),
(85, 'can_add_permission', 'Allow adding of new permissions', '2021-07-17 07:58:56', NULL, 1),
(86, 'can_view_permission', 'Allow to view the table of permission', '2021-07-17 07:59:20', NULL, 1),
(87, 'can_edit_permission', 'Allows to edit a permission', '2021-07-17 07:59:36', NULL, 1),
(88, 'can_delete_permission', 'Allows to delete a permission', '2021-07-17 07:59:55', '2021-07-25 00:14:26', 1),
(89, 'can_log_permisson', 'Allows to view and modify the permission log', '2021-07-17 08:00:31', NULL, 1),
(91, 'can_view_role', 'Allows to view the roles table', '2021-07-17 08:01:29', NULL, 1),
(92, 'can_edit_role', 'Allows to edit a role', '2021-07-17 08:01:42', NULL, 1),
(93, 'can_delete_role', 'Allows to delete a role', '2021-07-17 08:01:58', NULL, 1),
(94, 'can_assign_role', 'Allows to assign a group of permissions to a role', '2021-07-17 08:02:32', NULL, 1),
(95, 'can_remove_assignment_role', 'Allows to remove permission from a role', '2021-07-17 08:03:38', '2021-07-17 08:13:02', 1),
(96, 'can_log_role', 'Allows to view and modify role log', '2021-07-17 08:08:48', NULL, 1),
(97, 'can_set_privilege_expiration_user', 'Allows to set an expiration for a privilege', '2021-07-17 08:14:03', NULL, 1),
(98, 'can_view_dashboard', 'Allows to view the admin dashboard', '2021-07-17 08:20:11', NULL, 1),
(99, 'can_edit_menu', 'Allows to edit controller menu', '2021-07-18 14:10:56', NULL, 1),
(100, 'can_view_menu', 'Allows to view menu table', '2021-07-18 21:21:31', NULL, 1),
(103, 'can_trash_user', 'Allows to view and delete user trash', '2021-07-18 23:28:51', NULL, 1),
(104, 'can_edit_preferences_user', 'Allows to edit user preferences', '2021-07-19 11:08:37', '2021-07-19 11:10:06', 1),
(105, 'can_edit_general_setting', 'Allows to edit the system general settings', '2021-07-20 00:44:50', NULL, 1),
(106, 'can_edit_purge_setting', 'Allows editing purge setting', '2021-07-20 14:17:08', NULL, 1),
(107, 'can_edit_security_setting', 'Allows editing security setting', '2021-07-20 14:18:02', NULL, 1),
(108, 'can_edit_tool_setting', 'Allows editing tool setting', '2021-07-20 14:18:25', NULL, 1),
(109, 'can_add_menu', 'Allows to add new controller menu updated!', '2021-07-21 22:54:02', '2021-07-26 23:03:03', 1),
(110, 'can_edit_files', 'Allows to edit core yaml files', '2021-07-22 12:09:35', NULL, 1),
(111, 'can_view_notification', 'Allows to view the notification table', '2021-07-22 18:19:37', '2021-07-22 18:21:44', 1),
(112, 'can_add_notification', 'Allows to add notifications', '2021-07-22 19:51:22', NULL, 1),
(113, 'can_edit_notification', 'Allows to edit notification', '2021-07-22 19:59:12', NULL, 1),
(114, 'can_edit_theme', '', '2021-07-25 00:12:44', NULL, 1),
(117, 'can_hard_delete_user', 'Allows to permanently delete a user account from the database', '2021-07-27 15:09:51', NULL, 1),
(118, 'can_restore_trash_user', 'Allows user to manage user trash', '2021-07-28 20:50:00', NULL, 1),
(119, 'can_lock_user', 'Allows to lock and unlock a user account', '2021-07-29 08:07:52', NULL, 1),
(120, 'can_unlock_user', 'Allows to unlock locked user account', '2021-07-29 18:55:29', NULL, 1),
(121, 'can_change_status_user', 'Allows to change an account status', '2021-07-30 08:42:56', NULL, 1),
(124, 'can_add_role', 'Allow to add roles to system', '2021-08-09 10:18:56', NULL, 1),
(128, 'can_edit_theme_delete', 'can edit theme delete', '2021-09-10 10:42:03', NULL, 1),
(129, 'can_banter', 'can banter permission', '2021-09-10 10:56:10', NULL, 1);

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
  `status` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL,
  `visible` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `schedule_at` datetime DEFAULT NULL
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
  `created_byid` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role_name`, `role_description`, `created_at`, `modified_at`, `created_byid`) VALUES
(1, 'Superadmin', 'Complete control', '2020-05-07 00:08:07', '2020-07-02 00:10:34', 1),
(2, 'Subscriber', 'Basic role for users', '2021-02-19 01:46:04', '2021-05-20 21:48:44', 1),
(110, 'Author', 'author roles', '2021-07-14 10:29:52', '2021-07-20 00:37:35', 1),
(121, 'Developer', 'The developer role', '2021-08-20 00:34:08', '2021-09-09 22:03:50', 1);

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
(110, 77),
(110, 99),
(110, 87),
(110, 104),
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
(110, 74),
(121, 77);

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
(23, 'global_table_rows_per_page', '5');

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
  `created_byid` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `tag_name`, `tag_slug`, `created_at`, `modified_at`, `created_byid`) VALUES
(5, 'People Traffic', '', '2020-05-20 00:36:46', '2020-07-03 09:10:23', 1);

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
  `status` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL,
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
(12, 'technical', 'testiubng the', NULL, 'close', 'medium', 16, NULL, 1, '2020-05-28 03:54:14', NULL);

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
  `modified_at` datetime DEFAULT NULL,
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
(1265, 'Ricardo', 'Miller', 'rm@example.com', 'https://www.gravatar.com/avatar/be5f3206ef3171cf48b81cb309f74c51?s=200&d=mystery&r=R', 'active', '$2y$10$kdJa8xvaWDEnR2NvfarzbOv6vLPbckbEUZbznYI5kEeSQAA3/IVJq', NULL, NULL, NULL, NULL, '2021-09-17 09:29:32', NULL, NULL, NULL, '::1', 0, NULL),
(1269, 'Jordan', 'Britt', 'xoboriki@mailinator.com', 'https://www.gravatar.com/avatar/b73130714bf8a27bc87ef74b199c5d24?s=200&d=mystery&r=R', 'pending', '$2y$10$s7PHuUE4e7h6Rhj4xkX4g.kQVwmGazt.rdJV2XzQUFeY/AWdApgVe', NULL, NULL, 'ce80f27c128d6cafaad8d81361eff58578999deda309849395a94ebfd471da08', 1265, '2021-09-17 09:49:41', NULL, NULL, NULL, '::1', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_logs`
--

CREATE TABLE `user_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `level` int(10) NOT NULL,
  `level_name` varchar(100) NOT NULL,
  `context` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`context`)),
  `message` text NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(6, 1269, 'a:2:{s:10:\"last_login\";N;s:10:\"login_from\";N;}', 'a:2:{s:11:\"last_logout\";N;s:11:\"logout_from\";N;}', 'a:2:{s:13:\"failed_logins\";N;s:22:\"failed_login_timestamp\";N;}', 'O:8:\"stdClass\":30:{s:18:\"browser_name_regex\";s:6:\"~^.*$~\";s:20:\"browser_name_pattern\";s:1:\"*\";s:7:\"browser\";s:15:\"Default Browser\";s:7:\"version\";s:1:\"0\";s:8:\"majorver\";s:1:\"0\";s:8:\"minorver\";s:1:\"0\";s:8:\"platform\";s:7:\"unknown\";s:5:\"alpha\";s:0:\"\";s:4:\"beta\";s:0:\"\";s:5:\"win16\";s:0:\"\";s:5:\"win32\";s:0:\"\";s:5:\"win64\";s:0:\"\";s:6:\"frames\";s:1:\"1\";s:7:\"iframes\";s:0:\"\";s:6:\"tables\";s:1:\"1\";s:7:\"cookies\";s:0:\"\";s:16:\"backgroundsounds\";s:0:\"\";s:3:\"cdf\";s:0:\"\";s:8:\"vbscript\";s:0:\"\";s:11:\"javaapplets\";s:0:\"\";s:10:\"javascript\";s:0:\"\";s:15:\"activexcontrols\";s:0:\"\";s:8:\"isbanned\";s:0:\"\";s:14:\"ismobiledevice\";s:0:\"\";s:19:\"issyndicationreader\";s:0:\"\";s:7:\"crawler\";s:0:\"\";s:10:\"cssversion\";s:1:\"0\";s:11:\"supportscss\";s:0:\"\";s:3:\"aol\";s:0:\"\";s:10:\"aolversion\";s:1:\"0\";}');

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
(1265, 1),
(1269, 110);

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
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menu_order` (`menu_order`),
  ADD KEY `menu_name` (`menu_name`);

--
-- Indexes for table `menu_item`
--
ALTER TABLE `menu_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_item_original_name` (`item_original_label`),
  ADD KEY `main_menu_id` (`item_original_id`);

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
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `password_reset_hash` (`password_reset_hash`),
  ADD UNIQUE KEY `activation_token` (`activation_token`);

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=357;

--
-- AUTO_INCREMENT for table `menu_item`
--
ALTER TABLE `menu_item`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=914;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=245;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `temporary_role`
--
ALTER TABLE `temporary_role`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1270;

--
-- AUTO_INCREMENT for table `user_logs`
--
ALTER TABLE `user_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_metadata`
--
ALTER TABLE `user_metadata`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_note`
--
ALTER TABLE `user_note`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

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
-- Constraints for table `menu_item`
--
ALTER TABLE `menu_item`
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
