<?php
/*
* This file is part of the MagmaCore package.
*
* (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
* =====================================================
* File generated from \App\Schema\ContactSchema
*/

declare(strict_types=1);

namespace App\Migrations;

use MagmaCore\Migration\MigrateInterface;

class m3cf19c0f7fd56015f7335bbcdf10ff3bab7f0d6985c79cc218a25094473254c8 implements MigrateInterface
{

	/**
	* Migrate the query statement to the database
	*
	* @uses \App\Schema\ContactSchema
	* @return string
	*/
	public function up(): string
	{
		return "
CREATE TABLE IF NOT EXISTS `lavacms`.`contacts` (
`id` int(10) UNSIGNED  AUTO_INCREMENT NOT NULL DEFAULT NULL,`contact_name` int(10) UNSIGNED ,`contact_description` int(10) UNSIGNED ,PRIMARY KEY (`id`),UNIQUE KEY `contact_name` (`contact_name`))ENGINE=innoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC
		";
	}


	/**
	* Migrate the query statement to the database
	*
	* @uses \App\Schema\ContactSchema
	* @return string
	*/
	public function down(): string
	{
		return "
		";
	}
}