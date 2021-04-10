<?php
/*
* This file is part of the MagmaCore package.
*
* (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
* =====================================================
* File generated from \App\Schema\AddAgeUserSchema
*/

declare(strict_types=1);

namespace App\Migrations;

use MagmaCore\Migration\MigrateInterface;

class m14ed80137245628848f5f792847e155aaef05eeeef0eb678ad2dbcf4e3e4079e implements MigrateInterface
{

	/**
	* Migrate the query statement to the database
	*
	* @uses \App\Schema\AddAgeUserSchema
	* @return string
	*/
	public function up(): string
	{
		return "
		";
	}


	/**
	* Migrate the query statement to the database
	*
	* @uses \App\Schema\AddAgeUserSchema
	* @return string
	*/
	public function down(): string
	{
		return "
		";
	}


	/**
	* Migrate the query statement to the database
	*
	* @uses \App\Schema\AddAgeUserSchema
	* @return string
	*/
	public function change(): string
	{
		return "
			ALTER TABLE `users`
			ADD COLUMN`age` int(2) UNSIGNED  NOT NULL;
		";
	}
}