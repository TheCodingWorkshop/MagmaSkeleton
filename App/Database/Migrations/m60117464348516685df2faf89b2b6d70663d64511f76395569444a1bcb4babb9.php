<?php
/*
* This file is part of the MagmaCore package.
*
* (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
* =====================================================
* File generated from \App\Schema\UserSchema
*/

declare(strict_types=1);

namespace App\Migrations;

use MagmaCore\Migration\MigrateInterface;

class m60117464348516685df2faf89b2b6d70663d64511f76395569444a1bcb4babb9 implements MigrateInterface
{

	/**
	* Migrate the query statement to the database
	*
	* @return string
	*/
	public function up(): string
	{
		return "
        			CREATE TABLE IF NOT EXISTS `lavacms`.`users`
			(
				`id` int(10) UNSIGNED  AUTO_INCREMENT NOT NULL,
				`firstname` varchar(190) NOT NULL,
				`lastname` varchar(190) NOT NULL,
				`email` varchar(190) NOT NULL,
				`gravatar` varchar(190) DEFAULT NULL,
				`status` varchar(24) NOT NULL,
				`password_hash` varchar(190) NOT NULL,
				`password_reset_hash` varchar(64) DEFAULT NULL,
				`password_reset_expires_at` datetime DEFAULT NULL,
				`activation_token` varchar(64) DEFAULT NULL,
				`created_byid` int(10) UNSIGNED  NOT NULL,
				`created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
				`modified_at` datetime ON UPDATE CURRENT_TIMESTAMP  DEFAULT NULL,
				`remote_addr` varchar(64) DEFAULT NULL,
				PRIMARY KEY (`id`),
UNIQUE KEY `email` (`email`),
UNIQUE KEY `password_reset_hash` (`password_reset_hash`),
UNIQUE KEY `activation_token` (`activation_token`)
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