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

use MagmaCore\DataObjectSchema\BuildSchema;
use MagmaCore\DataObjectSchema\DataObjectSchema;
use MagmaCore\DataObjectSchema\DataObjectSchemaBuilderInterface;

class UserSchema extends DataObjectSchema implements DataObjectSchemaBuilderInterface
{

    /** */
    public function __construct()
    {
        parent::__construct(\App\Repository\UserRepository::class);
    }

    /**
     * @inheritdoc
     * @return string
     */
    public function createSchema(BuildSchema $schema): string
    {

        return $this
            ->schema()
            //->table(UserRepository::TABLESCHEMA)
            ->row($schema->autoID())
            ->row($schema->varchar('firstname', 190, false))
            ->row($schema->varchar('lastname', 190, false))
            ->row($schema->varchar('email', 190, false))
            ->row($schema->varchar('gravatar', 190, true))
            ->row($schema->varchar('status', 24, false))
            ->row($schema->varchar('password_hash', 190, true))
            ->row($schema->varchar('password_reset_hash', 64, true))
            ->row($schema->timestamp('password_reset_expires_at', 'null'))
            ->row($schema->varchar('activation_hash', 64, true, 'null'))
            ->row($schema->integre('created_byid', 10, false, 'unsigned'))
            ->row($schema->timestamp('created_at', false, 'now'))
            ->row($schema->timestamp('modified_at', true, 'null', 'on update current_timestamp'))
            ->row($schema->varchar('remote_addr', 64, true, 'null'))
            ->key($schema->getFromAutoID())
            ->unique('email')
            ->constraint('user_permission', function ($baseSchema) {
                $baseSchema->foreignKey('permission_id')->on('permission')->reference('id')
                    ->cascade(['onDelete' => true, 'onUpdate' => true]);
            })
            ->constraint('user_role', function ($baseSchema) {
                $baseSchema->foreignKey('role_id')->on('role')->reference('id')
                    ->cascade(['onDelete' => true, 'onUpdate' => true]);
            })
            ->build();
    }
}
