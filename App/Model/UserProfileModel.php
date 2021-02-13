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

use MagmaCore\Utility\PasswordEncoder;
use MagmaCore\Auth\Contracts\UserProfileInterface;

class UserProfileModel extends UserModel implements UserProfileInterface
{

    /** @var array */
    protected array $profileError = [];
    /** @var array */
    protected const PROFILE_FIELDS = ['firstname', 'lastname', 'email', 'password_hash'];

    /**
     * Verify the user password before making changes. Ensuring the correct user 
     * is making changes.
     *
     * @param Object $object - the current object to which the method is called from
     * @param int $id - the users ID
     * @param Null|string $fieldName
     * @return boolean
     */
    public function verifyPassword(Object $object, int $id, ?string $fieldName = null) : bool
    {
        if (array_key_exists('password_hash', $_POST)) {
            if (password_verify(
                $object->request->handler()->get('password_hash'), 
                $this->getRepo()->findObjectBy(['id' => $id], ['password_hash'])->password_hash)
            ) {
                return true;
            } else {
                return false;
            }
        }
        return false;
    }

    /**
     * Return true if both password fields matches
     *
     * @param Object $object
     * @param Object $cleanData
     * @return boolean
     */
    public function isPasswordMatching(Object $object, Object $cleanData) : bool
    {
        if ($cleanData->password_hash_new === $cleanData->password_hash_retype) {
            return true;
        }
        return false;
    }

    /**
     * Undocumented function
     *
     * @param object $cleanData
     * @return boolean
     */
    private function unsetValues(object $cleanData): bool
    {
        if (self::PROFILE_FIELDS) {
            foreach (self::PROFILE_FIELDS as $field) {
                if (array_key_exists($field, (array)$cleanData)) {
                    return true;
                }
            }
            return false;
        }
        return false;
    }

    /**
     * Update the user first and lastname fro their profile accounts page. Users name
     * will be subject to the same validation as registering a new account meaning 
     * users can only use valid and allowed characters
     *
     * @param object $cleanData
     * @param object $repository
     * @return array
     */
    public function updateProfileNameOnceValidated(Object $cleanData, ?Object $repository): array
    {
        $this->validateChanges($cleanData, $repository);
        if ($this->unsetValues($cleanData)) {
            $newCleanData = [
                'firstname' => $cleanData->firstname ? $cleanData->firstname : $repository->firstname,
                'lastname' => $cleanData->lastname ? $cleanData->lastname : $repository->lastname
            ];
        }
        return [
            $newCleanData,
            $this->getProfileErrors()
        ];
    }

    /**
     * Update the user profile email
     *
     * @param Object $cleanData
     * @param Object|null $repository
     * @return array
     */
    public function updateProfileEmailOnceValidated(Object $cleanData, ?Object $repository) : array
    {
        $this->validateChanges($cleanData, $repository);
        if ($this->unsetValues($cleanData)) {
            $newCleanData = [
                'email' => $cleanData->email ? $cleanData->email : $repository->email,
            ];
        }
        return [
            $newCleanData,
            $this->getProfileErrors()
        ];
    }

    /**
     * Update the user profile password
     *
     * @param Object $cleanData
     * @param Object|null $repository
     * @return array|bool
     */
    public function updateProfilePasswordOnceValidated(Object $cleanData, ?Object $repository)
    {
        $this->validateChanges($cleanData, $repository);
        if ($this->unsetValues($cleanData)) {
            $newCleanData = [
                'password_hash' => password_hash($cleanData->password_hash_new, PASSWORD_DEFAULT)
            ];
        }
        return [
            $newCleanData,
            $this->getProfileErrors()
        ];
    }

    /**
     * Validate the user profile data on changes. Ensuring the data that is being
     * submitted is validated and sanitize.
     *
     * @param object $cleanData
     * @param Object|null $repository
     * @return array
     */
    private function validateChanges(Object $cleanData, ?Object $repository): array
    {
        foreach ($cleanData as $key => $value) {
            switch ($key) {
                case 'firstname':
                case 'lastname':
                    if (isset($value)) {
                        $this->profileError[] = 'One or more empty fields detected.';
                    }
                    break;
                case 'email':
                    if (filter_var($value, FILTER_VALIDATE_EMAIL) === false) {
                        $this->profileError[] = 'Please enter a valid email address.';
                    }
                    break;
                case 'password_hash':
                case 'password_hash_new' :
                case 'password_hash_retype' :
                    if ($cleanData->password_hash_new != $cleanData->password_hash_retype) {
                        $this->profileError[] = 'Oops! Password did not match! Try again.';
                    }
                    if (!$this->validatePassword((object)$value, $repository)) {
                        $this->profileError[] = '';
                    }
                    break;
                default :
                    if ($value === $repository->$key) {
                        $this->profileError[] = 'No changes made!';
                    }
                    break;
            }
        }
        return $this->profileError;
    }

    /**
     * Return an array of user profile errors
     *
     * @return array
     */
    public function getProfileErrors(): array
    {
        return $this->profileError;
    }
}
