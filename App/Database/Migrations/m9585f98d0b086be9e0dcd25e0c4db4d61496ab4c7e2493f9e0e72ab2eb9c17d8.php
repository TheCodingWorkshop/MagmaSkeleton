<?php
/*
* This file is part of the MagmaCore package.
*
* (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
* =====================================================
* File generated from \App\Schema\UserMetaSchema
*/

declare(strict_types=1);

namespace App\Migrations;

use MagmaCore\Migration\MigrateInterface;

class m9585f98d0b086be9e0dcd25e0c4db4d61496ab4c7e2493f9e0e72ab2eb9c17d8 implements MigrateInterface
{

	/**
	* Migrate the query statement to the database
	*
	* @return string
	*/
	public function up(): string
	{
		return "
        			CREATE TABLE IF NOT EXISTS `lavacms`.`user_meta`
			(
				`id` int(10) UNSIGNED  AUTO_INCREMENT NOT NULL,
				`user_id` int(10) UNSIGNED ,
				`failed_logins` int(10) UNSIGNED  NOT NULL,
				`failed_login_timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
				`modified_at` datetime ON UPDATE CURRENT_TIMESTAMP  DEFAULT NULL,
				`remote_addr` varchar(64) DEFAULT NULL,
				PRIMARY KEY (`id`),
UNIQUE KEY `user_id` (`user_id`)
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