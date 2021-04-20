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

use MagmaCore\Base\BaseEntity;

/** @todo try and access the schema object to fetch the database column dynamically */
class PermissionEntity extends BaseEntity
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
