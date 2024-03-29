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

use App\Entity\TagEntity;
use MagmaCore\Base\AbstractBaseModel;
use MagmaCore\Base\Exception\BaseInvalidArgumentException;

class TagModel extends AbstractBaseModel
{

    /** @var string */
    protected const TABLESCHEMA = 'tags';
    /** @var string */
    protected const TABLESCHEMAID = 'id';
    public const COLUMN_STATUS = [];
    /* columns to include when cloning object */
    protected array $cloneableKeys = ['tag_name', 'tag_slug'];
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
        parent::__construct(self::TABLESCHEMA, self::TABLESCHEMAID, TagEntity::class);
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

    public function getNameForSelectField($id)
    {
        $name = $this->getRepo()->findObjectBy(['id' => $id], ['tag_name']);
        return $name->tag_name;
    }


}

