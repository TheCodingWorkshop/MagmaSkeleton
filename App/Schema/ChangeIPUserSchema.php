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

class ChangeIPUserSchema extends UserSchema
{
    /**
     * @inheritdoc
     * @return string
     */
    public function createSchema(): string
    {
        return $this->schema
            ->table($this->userModel)
            ->alter('change', function($schema){
                return $schema
                    ->row($this->blueprint->varchar('ip_address', 65, false))
                        ->changeColumn('remote_addr');
            });

    }
}
