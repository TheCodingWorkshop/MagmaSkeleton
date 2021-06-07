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
defined('TEMPLATE_CACHE') or define("TEMPLATE_CACHE", ROOT_PATH . '/' . "App/Templates/Cache");

$composer = ROOT_PATH . '/vendor/autoload.php';
if (is_file($composer)) {
    require $composer;
}

use MagmaCore\Utility\Yaml;
use MagmaCore\Base\BaseApplication;
use Symfony\Component\ErrorHandler\Debug;
Debug::enable();

(new BaseApplication())
    ->setPath(ROOT_PATH)
        ->setConfig(Yaml::file('app'))
            ->setErrorHandler(Yaml::file('app')['error_handler'], E_ALL)
                ->setSession(Yaml::file('session'))
                    ->setCookie([])
                        ->setCache()
                            ->setRoutes(Yaml::file('routes'))
                                ->setContainerProviders(Yaml::file('providers'))
                                    ->run();

                                    