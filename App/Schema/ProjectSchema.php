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

use App\Model\ProjectModel;
use MagmaCore\DataSchema\DataSchema;
use MagmaCore\DataSchema\DataSchemaBlueprint;
use MagmaCore\DataSchema\DataSchemaBuilderInterface;

class ProjectSchema implements DataSchemaBuilderInterface
{

    /** @var object - $schema for chaing the schema together */
    protected DataSchema $schema;
    /** @var object - provides helper function for quickly adding schema types */
    protected DataSchemaBlueprint $blueprint;
    /** @var object - the database model this schema is linked to */
    protected ProjectModel $projectModel;

    /**
     * Main constructor class. Any typed hinted dependencies will be autowired. As this 
     * class can be inserted inside a dependency container
     *
     * @param DataSchema $schema
     * @param DataSchemaBlueprint $blueprint
     * @param ProjectModel $projectModel
     * @return void
     */
    public function __construct(DataSchema $schema, DataSchemaBlueprint $blueprint, ProjectModel $projectModel)
    {
        $this->schema = $schema;
        $this->blueprint = $blueprint;
        $this->projectModel = $projectModel;
    }

    /**
     * @inheritdoc
     * @return string
     */
    public function createSchema(): string
    {
        return $this->schema
            ->schema()
            ->table($this->projectModel)
            ->row($this->blueprint->autoID())
            ->row($this->blueprint->varchar('project_name', 64))
            ->row($this->blueprint->varchar('project_client', 190))
            ->row($this->blueprint->varchar('project_coordinator', 64))
            ->row($this->blueprint->longtext('project_description'))
            ->row($this->blueprint->varchar('project_duration', 20))
            ->row($this->blueprint->varchar('project_cost', 10))
            ->row($this->blueprint->varchar('project_location', 60))
            ->row($this->blueprint->varchar('project_type', 60))
            ->row($this->blueprint->varchar('project_status', 10)) /* open or close */
            ->row($this->blueprint->int('created_byid', 10, false))
            ->row($this->blueprint->datetime('created_at', false, 'ct', ''))
            ->row($this->blueprint->datetime('modified_at', true, 'null', 'on update CURRENT_TIMESTAMP'))
            ->build(function($schema) {
                return $schema
                    ->addPrimaryKey($this->blueprint->getPrimaryKey())
                    ->setUniqueKey(['project_name'])
                    ->addKeys();
            });
    }
}
