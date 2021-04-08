<?php
/*
* This file is part of the MagmaCore package.
*
* (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
* =====================================================
* File generated from \App\Schema\RoleSchema
*/

declare(strict_types=1);

namespace App\Migrations;

use MagmaCore\Migration\MigrateInterface;

class m6417a8092168003fa41aaefdc406860c5066fe95fec35fe869ff35331944ddd3 implements MigrateInterface
{

	/**
	* Migrate the query statement to the database
	*
	* @uses \App\Schema\RoleSchema
	* @return string
	*/
	public function up(): string
	{
		return "
CREATE TABLE IF NOT EXISTS `lavacms`.`roles` (
`id` int(10) UNSIGNED  AUTO_INCREMENT NOT NULL,`role_name` varchar(64) NOT NULL,`role_description` varchar(190) NOT NULL,`created_byid` int(10) UNSIGNED  NOT NULL,`created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,`modified_at` datetime ON UPDATE CURRENT_TIMESTAMP  DEFAULT NULL,PRIMARY KEY (`id`),UNIQUE KEY `role_name` (`role_name`))ENGINE=innoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC
		";
	}


	/**
	* Migrate the query statement to the database
	*
	* @uses \App\Schema\RoleSchema
	* @return string
	*/
	public function down(): string
	{
		return "
		";
	}
}