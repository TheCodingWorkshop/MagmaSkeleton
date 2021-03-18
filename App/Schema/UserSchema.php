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
use MagmaCore\DataSchema\DataSchema;
use MagmaCore\DataSchema\Types\NumericType;
use MagmaCore\DataSchema\DataSchemaBlueprint;
use MagmaCore\DataSchema\DataSchemaBuilderInterface;

class UserSchema implements DataSchemaBuilderInterface
{

    protected DataSchema $schema;
    protected DataSchemaBlueprint $blueprint;
    protected UserModel $userModel;

    /**
     * Undocumented function
     *
     * @param DataSchema $schema
     * @param DataSchemaBlueprint $blueprint
     * @param UserModel $userModel
     * @return void
     */
    public function __construct(DataSchema $schema, DataSchemaBlueprint $blueprint, UserModel $userModel)
    {
        $this->schema = $schema;
        $this->blueprint = $blueprint;
        $this->userModel = $userModel;
    }

    /**
     * @inheritdoc
     * @return string
     */
    public function createSchema(): string
    {
       return $this->schema
            ->schema()
            ->table($this->userModel)
            ->row($this->blueprint->int('role_id', 10))
            ->row($this->blueprint->int('permission_id', 10))
            ->build(function($schema) {
                return $schema
                    ->addPrimaryKey('id')
                        ->setUniqueKey(['role_id', 'permission_id'])
                            ->setConstraintKeys(
                                function() use($schema){
                                    return $schema
                                    ->foreignKey('role_id')
                                    ->on('roles')
                                    ->reference('id')
                                    ->cascade(true, true);
                                })
                                ->addKeys();
            });


    }
}
