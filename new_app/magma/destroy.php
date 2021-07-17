<?php
require inc.php;

use MagmaCore\Migration\Driver\MigrationMysql;

$migrations = new MigrationMysql();
$migrations->migrate('down');