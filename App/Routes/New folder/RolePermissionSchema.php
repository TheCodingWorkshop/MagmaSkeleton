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

namespace App\Schema;

use MagmaCore\Auth\Model\RoleModel;
use MagmaCore\DataSchema\DataSchema;
use MagmaCore\Auth\Model\PermissionModel;
use MagmaCore\Auth\Model\RolePermissionModel;
use MagmaCore\DataSchema\DataSchemaBlueprint;
use MagmaCore\DataSchema\DataSchemaBuilderInterface;

class RolePermissionSchema implements DataSchemaBuilderInterface
{

    /** @var object - $schema for chaing the schema together */
    protected DataSchema $schema;
    /** @var object - provides helper function for quickly adding schema types */
    protected DataSchemaBlueprint $blueprint;
    /** @var object - the database model this schema is linked to */
    protected RolePermissionModel $rolePermModel;

    /**
     * Main constructor class. Any typed hinted dependencies will be autowired. As this 
     * class can be inserted inside a dependency container
     *
     * @param DataSchema $schema
     * @param DataSchemaBlueprint $blueprint
     * @param RolePermissionModel $rolePermModel
     * @return void
     */
    public function __construct(DataSchema $schema, DataSchemaBlueprint $blueprint, RolePermissionModel $rolePermModel)
    {
        $this->schema = $schema;
        $this->blueprint = $blueprint;
        $this->rolePermModel = $rolePermModel;
    }

    /**
     * @inheritdoc
     * @return string
     */
    public function createSchema(): string
    {
        return $this->schema
            ->schema()
            ->table($this->rolePermModel)
            ->row($this->blueprint->int('role_id', 10))
            ->row($this->blueprint->int('permission_id', 10))
            ->build(function($schema) {
                return $schema
                    ->setKey(['role_id', 'permission_id'])
                    ->setConstraints(
                        function ($trait) {
                            $constraint = $trait->addModel(RoleModel::class)->foreignKey('role_id')
                                ->on($trait->getModel()->getSchema())->reference($trait->getModel()->getSchemaID())
                                ->cascade(true,true)->add();   
                            $constraint .= $trait->addModel(PermissionModel::class)->foreignKey('permission_id')
                                ->on($trait->getModel()->getSchema())->reference($trait->getModel()->getSchemaID())
                                ->cascade(true,true)->add(); 
                            return $constraint;                   
                        }
                    );
                    
            });
    }
}
