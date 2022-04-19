<?php
/*
 * This file is part of the MagmaCore package.
 *
 * (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

$vendorPath = '/vendor/magmacore/magmacore/src/';

/**
 * Root constants required for the main index file
 */

defined('MICROTIME_START') or 
    define('MICROTIME_START', microtime(true));
defined('MICROTIME_END') or 
    define('MICROTIME_END', microtime(true));
defined('ROOT_PATH') or 
    define('ROOT_PATH', realpath(dirname(__FILE__, 2)));
defined('CONFIG_PATH') or 
    define("CONFIG_PATH", ROOT_PATH . '/' . "Config/");
defined('CORE_CONFIG_PATH') or 
    define("CORE_CONFIG_PATH", ROOT_PATH . $vendorPath . "System/Config/");
defined('TEMPLATE_CACHE') or 
    define("TEMPLATE_CACHE", ROOT_PATH . '/' . "App/Templates/Cache");
defined('LOG_PATH') or 
    define('LOG_PATH', ROOT_PATH . '/Storage/logs');

/**
 * Load the composer library
 */
$composer = ROOT_PATH . '/vendor/autoload.php';
if (is_file($composer)) {
    require $composer;
}
