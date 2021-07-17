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

namespace App\Model;

use App\Entity\RolePermissionEntity;
use App\Schema\Pivot\RolePermissionSchema;
use MagmaCore\Base\AbstractBaseModel;
use MagmaCore\Base\Exception\BaseInvalidArgumentException;
use MagmaCore\DataObjectLayer\DataRelationship\Relationships\ManyToMany;

class RolePermissionModel extends AbstractBaseModel
{

    /** @var string */
    protected const TABLESCHEMA = 'role_permission';
    /** @var string */
    protected const TABLESCHEMAID = 'id';

    /**
     * Main constructor class which passes the relevant information to the
     * base model parent constructor. This allows the repository to fetch the
     * correct information from the database based on the model/entity
     *
     * @return void
     * @throws BaseInvalidArgumentException
     */
    public function __construct()
    {
        parent::__construct(self::TABLESCHEMA, self::TABLESCHEMAID, RolePermissionEntity::class);
    }

    /**
     * Guard these IDs from being deleted etc..
     *
     * @return array
     */
    public function guardedID(): array
    {
        return [];
    }

    /**
     * Create an relation between the user and role models using the user_role
     * pivot table as the glue that hold both relationships
     *
     * @return ManyToMany
     */
    public function hasRelationship(): ManyToMany
    {
        return $this->addRelationship(ManyToMany::class)
            ->hasOne(RoleModel::class)->belongsToMany(PermissionModel::class)
            ->tablePivot($this, RolePermissionSchema::class);
    }

}
