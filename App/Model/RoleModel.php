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

namespace App\Model;

use App\Entity\RoleEntity;
use Exception;
use MagmaCore\Base\AbstractBaseModel;
use MagmaCore\Base\Exception\BaseInvalidArgumentException;
use MagmaCore\Utility\Yaml;

class RoleModel extends AbstractBaseModel
{

    public const REL_ASSOC = ['id' => 'role_id'];
    public const REL_FIELDS = ['role_name'];
    public const COLUMN_STATUS = [];

    /** @var string */
    protected const TABLESCHEMA = 'roles';
    /** @var string */
    protected const TABLESCHEMAID = 'id';

    /**
     * Main constructor class which passes the relevant information to the
     * base model parent constructor. This allows the repository to fetch the
     * correct information from the database based on the model/entity
     *
     * @return void
     * @throws BaseInvalidArgumentException
     */
    public function __construct()
    {
        parent::__construct(self::TABLESCHEMA, self::TABLESCHEMAID, RoleEntity::class);
    }

    /**
     * Guard these IDs from being deleted etc..
     *
     * @return array
     * @throws Exception
     */
    public function guardedID(): array
    {
        return [
            Yaml::file('app')['system']['super_role']['props']['id'],
            Yaml::file('app')['system']['default_role']['props']['id']
        ];
    }

    /**
     * Return an array of column values if table supports the column field
     *
     * @return array
     */
    public function getColumnStatus(): array
    {
        return self::COLUMN_STATUS;
    }

}
