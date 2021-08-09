<?php
/*
 * This file is part of the MagmaCore package.
 *
 * (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

declare(strict_types=1);

/**
 * Load the composer autoloader library which enables us to bootstrap the application
 * and initialize the necessary components.
 */
defined('ROOT_PATH') or define('ROOT_PATH', realpath(dirname(dirname(__FILE__))));
defined('CONFIG_PATH') or define("CONFIG_PATH", ROOT_PATH . '/' . "Config/");
defined('CORE_CONFIG_PATH') or define("CORE_CONFIG_PATH", ROOT_PATH . '/vendor/magmacore/magmacore/src/' . "System/Config/");
defined('TEMPLATE_CACHE') or define("TEMPLATE_CACHE", ROOT_PATH . '/' . "App/Templates/Cache");
defined('LOG_PATH') or define('LOG_PATH', ROOT_PATH . '/Storage/logs');

$composer = ROOT_PATH . '/vendor/autoload.php';
if (is_file($composer)) {
    require $composer;
}

use MagmaCore\Utility\Yaml;
use MagmaCore\Base\BaseApplication;
use Symfony\Component\ErrorHandler\Debug;
use MagmaCore\Logger\LogLevel;
//Debug::enable();

try {
    (new BaseApplication())
        ->setPath(ROOT_PATH)
        ->setConfig(Yaml::file('app'))
        ->setErrorHandler(Yaml::file('app')['error_handler'], E_ALL | E_STRICT)
        ->setSession(Yaml::file('session'), null, true)
        ->setCookie([])
        ->setCache(Yaml::file('cache'), null, true)
        ->setRoutes(Yaml::file('routes'))
        ->setLogger(LOG_PATH, Yaml::file('app')['logger_handler']['file'], LogLevel::DEBUG, [])
        ->setContainerProviders(Yaml::file('providers'))
        ->run();
} catch (Exception $e) {
    echo $e->getMessage();
}

                                    