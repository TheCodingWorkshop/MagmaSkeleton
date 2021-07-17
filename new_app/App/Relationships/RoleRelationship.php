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

namespace App\Relationships;

use App\Model\RoleModel;
use App\Model\UserModel;
use App\Model\UserRoleModel;
use MagmaCore\DataObjectLayer\DataRelationship\Relationships\ManyToMany;

class RoleRelationship extends UserModel
{

    /**
     * self::class refers to this current class UserModel::class. Create the connection
     * between the different associated models and their pivoting table. In order to
     * establish a relationship. First we need to pass the type of possible 3 relationships
     * ManyToMany, OneToMany or OneToOne with the addRelationship method. Then add both
     * reference table within the table method then the pivot table to the pivot method.
     * Once we complete this we will have access to the methods within the type of relationships
     * we wish to use methods from.
     *
     * @return object
     */
    public function type(): object
    {
        /* self::class refers to UserModel::class */
        return $this->addRelationship(ManyToMany::class)
            ->tables(RoleModel::class, UserModel::class)
            ->pivot(UserRoleModel::class);
    }

}
