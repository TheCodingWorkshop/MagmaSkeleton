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

use App\Model\TestModel;
use MagmaCore\DataSchema\DataSchema;
use MagmaCore\DataSchema\DataSchemaBlueprint;
use MagmaCore\DataSchema\DataSchemaBuilderInterface;

class DestroyTestSchema implements DataSchemaBuilderInterface
{

    /** @var object - $schema for chaing the schema together */
    protected DataSchema $schema;
    /** @var object - provides helper function for quickly adding schema types */
    protected DataSchemaBlueprint $blueprint;
    /** @var object - the database model this schema is linked to */
    protected TestModel $testModel;

    /**
     * Main constructor class. Any typed hinted dependencies will be autowired. As this 
     * class can be inserted inside a dependency container
     *
     * @param DataSchema $schema
     * @param UserModel $userModel
     * @return void
     */
    public function __construct(DataSchema $schema, TestModel $testModel)
    {
        $this->schema = $schema;
        $this->testModel = $testModel;
    }

    /**
     * @inheritdoc
     * @return string
     */
    public function createSchema(): string
    {
        return $this->schema
            ->table($this->testModel)
                ->destroy();
    }
}
