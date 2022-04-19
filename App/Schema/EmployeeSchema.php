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

use App\Model\EmployeeModel;
use MagmaCore\DataSchema\DataSchema;
use MagmaCore\DataSchema\DataSchemaBlueprint;
use MagmaCore\DataSchema\DataSchemaBuilderInterface;

class EmployeeSchema implements DataSchemaBuilderInterface
{

    /** @var object - $schema for chaining the schema together */
    protected object $schema;
    /** @var object - provides helper function for quickly adding schema types */
    protected object $blueprint;
    /** @var object - the database model this schema is linked to */
    protected object $employeeModel
    ;

    /**
     * Main constructor class. Any typed hinted dependencies will be autowired. As this
     * class can be inserted inside a dependency container
     *
     * @param DataSchema $schema
     * @param DataSchemaBlueprint $blueprint
     * @param EmployeeModel $employeeModel
     * @return void
     */
    public function __construct(DataSchema $schema, DataSchemaBlueprint $blueprint, EmployeeModel $employeeModel)
    {
        $this->schema = $schema;
        $this->blueprint = $blueprint;
        $this->employeeModel = $employeeModel;
    }

    /**
     * @inheritdoc
     * @return string
     */
    public function createSchema(): string
    {
        return $this->schema
            ->schema()
            ->table($this->employeeModel)
            ->row($this->blueprint->autoID())
            ->row($this->blueprint->varchar('employee_name', 190))
            ->row($this->blueprint->varchar('employee_dob', 30))
            ->row($this->blueprint->varchar('employee_email', 190))
            ->row($this->blueprint->varchar('employee_avatar', 100))
            ->row($this->blueprint->varchar('employee_role'))
            ->row($this->blueprint->longtext('employee_bio'))
            ->row($this->blueprint->int('employee_code', 10))
            ->row($this->blueprint->int('created_byid', 10, false))
            ->row($this->blueprint->datetime('created_at', false))
            ->row($this->blueprint->datetime('modified_at', true, 'null', 'on update CURRENT_TIMESTAMP'))
            ->build(function ($schema) {
                return $schema
                    ->addPrimaryKey($this->blueprint->getPrimaryKey())
                    ->setUniqueKey(['employee_code', 'employee_email'])
                    ->addKeys();
            });
    }
}
