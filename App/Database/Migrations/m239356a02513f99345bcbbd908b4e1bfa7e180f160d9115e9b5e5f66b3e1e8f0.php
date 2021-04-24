<?php
/*
* This file is part of the MagmaCore package.
*
* (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
* =====================================================
* File generated from \App\Schema\SettingsSchema
*/

declare(strict_types=1);

namespace App\Migrations;

use MagmaCore\Migration\MigrateInterface;

class m239356a02513f99345bcbbd908b4e1bfa7e180f160d9115e9b5e5f66b3e1e8f0 implements MigrateInterface
{

	/**
	* Migrate the query statement to the database
	*
	* @return string
	*/
	public function up(): string
	{
		return "
        			CREATE TABLE IF NOT EXISTS `lavacms`.`settings`
			(
				`id` int(10) UNSIGNED  AUTO_INCREMENT NOT NULL,
				`setting_name` varchar(65) NOT NULL,
				`setting_value` longtext NOT NULL,
				PRIMARY KEY (`id`),
UNIQUE KEY `setting_name` (`setting_name`)
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