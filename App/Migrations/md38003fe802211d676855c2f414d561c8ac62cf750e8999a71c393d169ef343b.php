<?php
/*
* This file is part of the MagmaCore package.
*
* (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
* =====================================================
* File generated from \App\Schema\PermissionSchema
*/

declare(strict_types=1);

namespace App\Migrations;

use MagmaCore\Migration\MigrateInterface;

class md38003fe802211d676855c2f414d561c8ac62cf750e8999a71c393d169ef343b implements MigrateInterface
{

	/**
	* Migrate the query statement to the database
	*
	* @uses \App\Schema\PermissionSchema
	* @return string
	*/
	public function up(): string
	{
		return "
			CREATE TABLE IF NOT EXISTS `lavacms`.`permissions`
			(
				`id` int(10) UNSIGNED  AUTO_INCREMENT NOT NULL,
				`permission_name` varchar(64) NOT NULL,
				`permission_description` varchar(190) NOT NULL,
				`created_byid` int(10) UNSIGNED  NOT NULL,
				`created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
				`modified_at` datetime ON UPDATE CURRENT_TIMESTAMP  DEFAULT NULL,
				PRIMARY KEY (`id`),
UNIQUE KEY `permission_name` (`permission_name`)
			)
			ENGINE=innoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC

		";
	}


	/**
	* Migrate the query statement to the database
	*
	* @uses \App\Schema\PermissionSchema
	* @return string
	*/
	public function down(): string
	{
		return "
		";
	}
}