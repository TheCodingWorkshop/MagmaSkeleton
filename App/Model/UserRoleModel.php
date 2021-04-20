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

use App\Model\UserModel;
use App\Entity\UserRoleEntity;
use MagmaCore\Auth\Model\RoleModel;
use MagmaCore\Base\AbstractBaseModel;
use MagmaCore\DataObjectLayer\DataRelationship\ManyToMany;

class UserRoleModel extends AbstractBaseModel
{

    /** @var string */
    protected const TABLESCHEMA = 'user_role';
    /** @var string */
    protected const TABLESCHEMAID = 'id';
    /** @var object $relationship */
    protected object $relationship;

    /**
     * Main constructor class which passes the relevant information to the 
     * base model parent constructor. This allows the repsitory to fetch the
     * correct information from the database based on the model/entity
     * 
     * @throws BaseInvalidArgumentException
     * @return void
     */
    public function __construct()
    {
        parent::__construct(self::TABLESCHEMA, self::TABLESCHEMAID, UserRoleEntity::class);
    }

    /**
     * Guard these IDs from being deleted etc..
     *
     * @return array
     */
    public function guardedID(): array
    {
        return [
        ];
    }

    /**
     * Create an relation between the user and role models using the user_role
     * pivot table as the glue between both relationships
     *
     * @return ManyToMany
     */
    public function hasRelationship(): ManyToMany
    {
        return $this->addRelationship(ManyToMany::class)
            ->hasOne(UserModel::class)->belongsToMany(RoleModel::class)
                ->tablePivot($this, UserRoleSchema::class);
    }

}