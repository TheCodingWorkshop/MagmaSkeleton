<?php
/*
 * This file is part of the MagmaCore package.
 *
 * (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
declare(strict_types=1);

namespace App\Entity;

use App\Schema\UserSchema;
use MagmaCore\Base\BaseEntity;

class UserEntity extends BaseEntity
{

    /**
     * Return an array of database column name matching the object schema
     *
     * @param string $schema
     * @return array
     */
    public function getColumns(string $schema): array
    {
        return $this->create($schema)->getSchemaColumns();
    }

}