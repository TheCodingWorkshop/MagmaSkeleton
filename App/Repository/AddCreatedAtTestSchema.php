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

class AddCreatedATTestSchema extends TestSchema
{
    /**
     * @inheritdoc
     * @return string
     */
    public function createSchema(): string
    {
        return $this->schema
            ->table($this->testModel)
            ->alter('add', function($schema){
                return $schema
                    ->row($this->blueprint->datetime('created_at', false, 'ct', ''))
                        ->addColumn();
            });

    }
}
