<?php
/*
* This file is part of the MagmaCore package.
*
* (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
* =====================================================
* File generated from \App\Schema\TestSchema
*/

declare(strict_types=1);

namespace App\Migrations;

use MagmaCore\Migration\MigrateInterface;

class mec9d4d5ca6330b70d3e3902c9af1c0d953fe7774f2bbae72110d03dfe82f9f68 implements MigrateInterface
{

	/**
	* Migrate the query statement to the database
	*
	* @uses \App\Schema\TestSchema
	* @return string
	*/
	public function up(): string
	{
		return "
CREATE TABLE IF NOT EXISTS `lavacms`.`tests` (
`id` int(10) UNSIGNED  AUTO_INCREMENT NOT NULL DEFAULT NULL,`test_name` int(10) UNSIGNED ,`test_description` int(10) UNSIGNED ,PRIMARY KEY (`id`),UNIQUE KEY `test_name` (`test_name`))ENGINE=innoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC
		";
	}


	/**
	* Migrate the query statement to the database
	*
	* @uses \App\Schema\TestSchema
	* @return string
	*/
	public function down(): string
	{
		return "
		";
	}
}