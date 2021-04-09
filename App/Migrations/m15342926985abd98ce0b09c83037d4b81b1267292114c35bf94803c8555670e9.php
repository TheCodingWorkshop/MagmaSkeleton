<?php
/*
* This file is part of the MagmaCore package.
*
* (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
* =====================================================
* File generated from \App\Schema\RolePermissionSchema
*/

declare(strict_types=1);

namespace App\Migrations;

use MagmaCore\Migration\MigrateInterface;

class m15342926985abd98ce0b09c83037d4b81b1267292114c35bf94803c8555670e9 implements MigrateInterface
{

	/**
	* Migrate the query statement to the database
	*
	* @uses \App\Schema\RolePermissionSchema
	* @return string
	*/
	public function up(): string
	{
		return "
			CREATE TABLE IF NOT EXISTS `lavacms`.`role_permission`
			(
				`role_id` int(10) UNSIGNED ,
				`permission_id` int(10) UNSIGNED ,
				KEY `role_id` (`role_id`),
KEY `permission_id` (`permission_id`), FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`)ON DELETE CASCADE ON UPDATE CASCADE
			)
			ENGINE=innoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC

		";
	}


	/**
	* Migrate the query statement to the database
	*
	* @uses \App\Schema\RolePermissionSchema
	* @return string
	*/
	public function down(): string
	{
		return "
		";
	}
}