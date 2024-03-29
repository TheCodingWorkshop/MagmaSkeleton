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

use App\Entity\TimesheetEntity;
use MagmaCore\UserManager\UserModel;
use MagmaCore\Base\AbstractBaseModel;
use MagmaCore\Base\Exception\BaseInvalidArgumentException;

class TimesheetModel extends AbstractBaseModel
{

    /** @var string */
    protected const TABLESCHEMA = 'timesheets';
    /** @var string */
    protected const TABLESCHEMAID = 'id';
    /* does the model have any status is not return empty array */
    public const COLUMN_STATUS = [];
    /* columns to include when cloning object */
    protected array $cloneableKeys = [];
    /* columns to exclude when cloning objects */
    protected array $unsettableClone = ['id'];


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
        parent::__construct(self::TABLESCHEMA, self::TABLESCHEMAID, TimesheetEntity::class);
    }

    /**
     * Guard these IDs from being deleted etc..
     *
     * @return array
     */
    public function guardedID(): array
    {
        return [];
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

    // public function getNameForSelectField($id)
    // {
    //     $name = $this->getRepo()->findObjectBy(['id' => $id], ['name']);
    //     return $name->name;
    // }

    /**
     * @param $id
     * @return mixed
     */
    public function getNameForSelectField($id)
    {
        return $this->getOtherModel(UserModel::class)->getNameForSelectField($id);
    }


    public function getAllEmployeeIdByName()
    {
        $employees = $this->getRepo()->findBy(['id', 'firstname', 'lastname']);
        if ($employees !==null) {
            return sprintf();
        }
    }
}

