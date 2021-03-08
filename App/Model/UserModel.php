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
use MagmaCore\Utility\PasswordEncoder;
use MagmaCore\Auth\Contracts\UserSecurityInterface;

class UserModel extends AbstractBaseModel implements UserSecurityInterface
{

    /** @var string */
    protected const TABLESCHEMA = 'users';
    /** @var string */
    protected const TABLESCHEMAID = 'id';
    protected const PROTECTED_SUPERADMIN = 1;
    protected const PROTECTED_SUBSCRIBER = 2;
    /** */
    protected array $profileError = [];
    /** */
    protected const PROFILE_FIELDS = ['firstname', 'lastname', 'email', 'password_hash'];

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
    public function guardedID(): array
    {
        return [
        ];
    }

    /**
     * Returns the databae table schema name
     * 
     * @return string
     */
    public function getSchemaID(): string
    {
        return self::TABLESCHEMAID;
    }

    /**
     * Returns the database table schema primary key 
     * 
     * @return string
     */
    public function getSchema(): string
    {
        return self::TABLESCHEMA;
    }

    /**
     * See if a user record already exists with the specified email
     *
     * @param string $email email address to search for
     * @param int|null $ignoreID
     * @return boolean  True if a record already exists with the specified email, false otherwise
     */
    public function emailExists(string $email, int $ignoreID = null) : bool
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

    /**
     * Validate the new user password. Using the validate user object
     * Once the password is validated it will then be hash using the
     * passing hash from our traits services
     *
     * @param Object $cleanData - data returning from the user entity filtered and sanitized
     * @param Object|null $dataRepository
     * @return self
     * @throws ReflectionException
     */
    public function validatePassword(object $cleanData, Null|object $repository = null)
    {
        $cleanData = (array)$cleanData;
        $validate = $this->get('Validate.UserValidate')->validate($cleanData);
        if (empty($validate->errors)) {
            $this->validatedHashPassword = (new PasswordEncoder())->encode($cleanData['password_hash']);
            $this->tokenRepository = $repository;

            return $this;
        }
    }
}