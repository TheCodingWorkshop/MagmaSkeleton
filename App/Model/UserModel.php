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

use App\Entity\UserEntity;
use MagmaCore\Auth\Contracts\UserSecurityInterface;
use MagmaCore\Base\AbstractBaseModel;
use MagmaCore\Base\Exception\BaseInvalidArgumentException;
use MagmaCore\Utility\PasswordEncoder;

class UserModel extends AbstractBaseModel implements UserSecurityInterface
{

    public const REL_ASSOC = ['id' => 'user_id'];
    public const REL_FIELDS = ['firstname', 'lastname', 'email'];
    public const COLUMN_STATUS = ['status' => ['pending', 'active', 'trash', 'lock', '']];

    /** @var string */
    protected const TABLESCHEMA = 'users';
    /** @var string */
    protected const TABLESCHEMAID = 'id';
    /** @var array - field casting */
    protected array $cast = [
        'firstname' => 'array_json'
    ];
    /** @var array $fillable - an array of fields that should not be null */
    protected array $fillable = [
        'firstname',
        'lastname',
        'email',
        'status',
        'password_hash',
        'created_byid',
        'remote_addr',
    ];
    protected ?string $validatedHashPassword;
    protected ?object $tokenRepository;


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
        parent::__construct(self::TABLESCHEMA, self::TABLESCHEMAID, UserEntity::class);
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

    /**
     * See if a user record already exists with the specified email
     *
     * @param string $email email address to search for
     * @param int|null $ignoreID
     * @return boolean  True if a record already exists with the specified email, false otherwise
     */
    public function emailExists(string $email, int $ignoreID = null): bool
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
     * @param object $cleanData - data returning from the user entity filtered and sanitized
     * @param object|null $repository
     * @return self
     */
    public function validatePassword(object $cleanData, ?object $repository = null): static
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
