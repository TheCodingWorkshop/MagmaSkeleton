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

use MagmaCore\Base\AbstractBaseModel;

class UserModel extends AbstractBaseModel
{ 

    /** @var string */
    protected const TABLESCHEMA = 'users';
    /** @var string */
    protected const TABLESCHEMAID = 'id';

    /**
     * Main constructor class which passes the relevant information to the 
     * base model parent constructor. This allows the repsitory to fetch the
     * correct information from the database based on the model/entity
     * 
     * @throws BaseInvalidArgumentException
     * @return void
     */
    public function __construct()
    {
        parent::__construct(self::TABLESCHEMA, self::TABLESCHEMAID);
    }

    /**
     * Guard these IDs from being deleted etc..
     *
     * @return array
     */
    public function guardedID() : array
    {
        return [];
    }

    /**
     * See if a user record already exists with the specified email
     *
     * @param string $email email address to search for
     * @param int|null $ignoreID
     * @return boolean  True if a record already exists with the specified email, false otherwise
     */
    public function emailExists(string $email, int $ignoreID = null)
    {
        if (!empty($email)) {
            $result = $this->getRepo()->findObjectBy(['email' => $email], ['*']);
            if ($result) {
                if ($result->id != $ignoreID) {
                    return true;
                }
            }
        }
        return false;
    }


}