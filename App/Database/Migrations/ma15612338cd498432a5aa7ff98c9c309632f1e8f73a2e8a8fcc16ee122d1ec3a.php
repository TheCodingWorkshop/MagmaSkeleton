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

class ma15612338cd498432a5aa7ff98c9c309632f1e8f73a2e8a8fcc16ee122d1ec3a implements MigrateInterface
{

	/**
	* Migrate the query statement to the database
	*
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
	* @return string
	*/
	public function down(): string
	{
		return "
        Drop table tests
        ";
	}


}