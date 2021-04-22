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

class ChangeStatus_TestSchema extends TestSchema
{
    /**
     * @inheritdoc
     * @return string
     */
    public function createSchema(): string
    {
        return $this->schema
            ->table($this->testModel)
            ->alter('change', function($schema){
                return $schema
                    ->row($this->blueprint->varchar('status', 65, false))
                        ->changeColumn('test_status');
            });

    }
}
