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

use App\Model\ContactModel;
use MagmaCore\DataSchema\DataSchema;
use MagmaCore\DataSchema\DataSchemaBlueprint;
use MagmaCore\DataSchema\DataSchemaBuilderInterface;

class ContactSchema implements DataSchemaBuilderInterface
{

    /** @var object - $schema for chaing the schema together */
    protected DataSchema $schema;
    /** @var object - provides helper function for quickly adding schema types */
    protected DataSchemaBlueprint $blueprint;
    /** @var object - the database model this schema is linked to */
    protected ContactModel $contactModel;

    /**
     * Main constructor class. Any typed hinted dependencies will be autowired. As this 
     * class can be inserted inside a dependency container
     *
     * @param DataSchema $schema
     * @param DataSchemaBlueprint $blueprint
     * @param ContactModel $contactModel
     * @return void
     */
    public function __construct(DataSchema $schema, DataSchemaBlueprint $blueprint, ContactModel $contactModel)
    {
        $this->schema = $schema;
        $this->blueprint = $blueprint;
        $this->contactModel = $contactModel;
    }

    /**
     * @inheritdoc
     * @return string
     */
    public function createSchema(): string
    {
        return $this->schema
            ->schema()
            ->table($this->contactModel)
            ->row($this->blueprint->autoID())
            ->row($this->blueprint->int('contact_name', 10))
            ->row($this->blueprint->int('contact_description', 10))
            ->build(function ($schema) {
                return $schema
                    ->addPrimaryKey($this->blueprint->getPrimaryKey())
                    ->setUniqueKey(['contact_name'])
                    // ->setConstraintKeys(
                    //     function () use ($schema) {
                    //         return $schema->foreignKey('role_id')->on('roles')
                    //             ->reference('id')
                    //             ->cascade(true, true);
                    //     }
                    // )

                    ->addKeys();
            });
    }
}
