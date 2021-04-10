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

use App\Model\UserModel;
use MagmaCore\Auth\Model\RoleModel;
use MagmaCore\DataSchema\DataSchema;
use MagmaCore\Auth\Model\UserRoleModel;
use MagmaCore\DataSchema\DataSchemaBlueprint;
use MagmaCore\DataSchema\DataSchemaBuilderInterface;

class UserRoleSchema implements DataSchemaBuilderInterface
{

    /** @var object - $schema for chaing the schema together */
    protected DataSchema $schema;
    /** @var object - provides helper function for quickly adding schema types */
    protected DataSchemaBlueprint $blueprint;
    /** @var object - the database model this schema is linked to */
    protected UserRoleModel $userRoleModel;

    /**
     * Main constructor class. Any typed hinted dependencies will be autowired. As this 
     * class can be inserted inside a dependency container
     *
     * @param DataSchema $schema
     * @param DataSchemaBlueprint $blueprint
     * @param UserRoleModel $userRoleModel
     * @return void
     */
    public function __construct(DataSchema $schema, DataSchemaBlueprint $blueprint, UserRoleModel $userRoleModel)
    {
        $this->schema = $schema;
        $this->blueprint = $blueprint;
        $this->userRoleModel = $userRoleModel;
    }

    /**
     * @inheritdoc
     * @return string
     */
    public function createSchema(): string
    {
        return $this->schema
            ->schema()
            ->table($this->userRoleModel)
            ->row($this->blueprint->int('user_id', 10))
            ->row($this->blueprint->int('role_id', 10))
            ->build(function($schema) {
                return $schema
                    ->setKey(['user_id', 'role_id'])
                    ->setConstraints(
                        function ($trait) {
                            $constraint = $trait->addModel(UserModel::class)->foreignKey('user_id')
                                ->on($trait->getModel()->getSchema())->reference($trait->getModel()->getSchemaID())
                                ->cascade(true,true)->add();   
                            $constraint .= $trait->addModel(RoleModel::class)->foreignKey('role_id')
                                ->on($trait->getModel()->getSchema())->reference($trait->getModel()->getSchemaID())
                                ->cascade(true,true)->add(); 
                            return $constraint;                   
                        }
                    );
                    
            });
    }
}
