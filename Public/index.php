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

require_once 'include.php';

use MagmaCore\Utility\Yaml;
use MagmaCore\Logger\LogLevel;
use MagmaCore\Base\BaseApplication;
// use Josantonius\ErrorHandler\ErrorHandler;

try {
    /* Attempting to run a single instance of the application */
    BaseApplication::getInstance()
        ->setPath(ROOT_PATH)
        ->setConfig(Yaml::file('app'))
        ->setErrorHandler(Yaml::file('app')['error_handler'], E_ALL)
        ->setSession(Yaml::file('app')['session'], null, true)
        ->setCookie([])
        ->setCache(Yaml::file('app')['cache'], null, true)
        ->setRoutes(Yaml::file('routes'))
        ->setLogger(LOG_PATH, Yaml::file('app')['logger_handler']['file'], LogLevel::DEBUG, [])
        ->setContainerProviders(Yaml::file('providers'))
        ->run();
} catch (Exception $e) {
    echo $e->getMessage();
}