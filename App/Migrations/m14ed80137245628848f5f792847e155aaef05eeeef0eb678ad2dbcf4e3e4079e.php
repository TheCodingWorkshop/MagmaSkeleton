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

namespace App\Migrations;

use MagmaCore\Migration\MigrateInterface;

class m14ed80137245628848f5f792847e155aaef05eeeef0eb678ad2dbcf4e3e4079e implements MigrateInterface
{

	/**
	* Migrate the query statement to the database
	*
	* @return string
	*/
	public function up(): string
	{
		return "
			CREATE TABLE IF NOT EXISTS `lavacms`.`users` (
`id` int(10) UNSIGNED  AUTO_INCREMENT NOT NULL DEFAULT NULL,`role_id` int(10) UNSIGNED ,`permission_id` int(10) UNSIGNED ,PRIMARY KEY (`id`),UNIQUE KEY `role_id` (`role_id`),UNIQUE KEY `permission_id` (`permission_id`), FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`)
 ON DELETE CASCADE ON UPDATE CASCADE)ENGINE=innoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC
		";
	}
}