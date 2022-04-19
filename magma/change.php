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
$composer = ROOT_PATH . '/vendor/autoload.php';
if (is_file($composer)) {
    require $composer;
}

use MagmaCore\Migration\Driver\MigrationMysql;

$migrations = new MigrationMysql();
$migrations->migrate('change');