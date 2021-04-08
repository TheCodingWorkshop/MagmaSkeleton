<?php
/*
* This file is part of the MagmaCore package.
*
* (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
* =====================================================
* File generated from \App\Schema\DropTestSchema
*/

declare(strict_types=1);

namespace App\Migrations;

use MagmaCore\Migration\MigrateInterface;

class mceb0695293aadce4c540009ffe931761f5f8bb03209e66821119b8b558f638fd implements MigrateInterface
{

	/**
	* Migrate the query statement to the database
	*
	* @uses \App\Schema\DropTestSchema
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
	* @uses \App\Schema\DropTestSchema
	* @return string
	*/
	public function down(): string
	{
		return "
DROP TABLE tests		";
	}
}