<?php
/*
* This file is part of the MagmaCore package.
*
* (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
* =====================================================
* File generated from \App\Schema\RememberedLoginSchema
*/

declare(strict_types=1);

namespace App\Migrations;

use MagmaCore\Migration\MigrateInterface;

class mbeca651e7e4d44073da195ffecf362e0cb4ffe92885fdace10ce902912647a97 implements MigrateInterface
{

	/**
	* Migrate the query statement to the database
	*
	* @return string
	*/
	public function up(): string
	{
		return "
        			CREATE TABLE IF NOT EXISTS `lavacms`.`remembered_logins`
			(
				`id` int(10) UNSIGNED  AUTO_INCREMENT NOT NULL,
				`token_hash` varchar(64) NOT NULL,
				`expires_at` datetime NOT NULL,
				PRIMARY KEY (`id`),
UNIQUE KEY `token_hash` (`token_hash`)
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