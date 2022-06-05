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

use MagmaCore\DataSchema\DataSchema;
use MagmaCore\DataSchema\DataSchemaBlueprint;
use MagmaCore\DataSchema\DataSchemaBuilderInterface;
use App\Model\BranchModel;

class BranchSchema implements DataSchemaBuilderInterface
{

    /** @var object - $schema for chaining the schema together */
    protected object $schema;
    /** @var object - provides helper function for quickly adding schema types */
    protected object $blueprint;
    /** @var object - the database model this schema is linked to */
    protected object $branchModel
    ;

    /**
     * Main constructor class. Any typed hinted dependencies will be autowired. As this
     * class can be inserted inside a dependency container
     *
     * @param DataSchema $schema
     * @param DataSchemaBlueprint $blueprint
     * @param BranchModel $branchModel
     * @return void
     */
    public function __construct(DataSchema $schema, DataSchemaBlueprint $blueprint, BranchModel $branchModel)
    {
        $this->schema = $schema;
        $this->blueprint = $blueprint;
        $this->branchModel = $branchModel;
    }

    /**
     * @inheritdoc
     * @return string
     */
    public function createSchema(): string
    {
        return $this->schema
            ->schema()
            ->table($this->branchModel)
            ->row($this->blueprint->autoID())
            ->row($this->blueprint->int('project_id', 10, false))
            ->row($this->blueprint->varchar('branch', 150))
            ->row($this->blueprint->varchar('code', 12))
            ->row($this->blueprint->longtext('address'))
            ->row($this->blueprint->varchar('status', 15))
            ->row($this->blueprint->int('created_byid', 10, false))
            ->row($this->blueprint->datetime('created_at', false))
            ->row($this->blueprint->datetime('modified_at', true, 'null', 'on update CURRENT_TIMESTAMP'))
            ->row($this->blueprint->tinyInt('deleted_at', 1, false))
            ->build(function ($schema) {
                return $schema
                    ->addPrimaryKey($this->blueprint->getPrimaryKey())
                    ->setUniqueKey(['name', ['slug']])
                    ->addKeys();
            });
    }
}
