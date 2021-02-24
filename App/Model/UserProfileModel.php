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

use MagmaCore\Auth\Contracts\UserProfileInterface;

class UserProfileModel extends UserModel implements UserProfileInterface
{

    /** @var array */
    protected array $profileError = [];
    /** @var array */
    protected const PROFILE_FIELDS = ['firstname', 'lastname', 'email', 'password_hash', 'user_id'];

    /**
     * Verify the user password before making changes. Ensuring the correct user 
     * is making changes.
     *
     * @param Object $object - the current object to which the method is called from
     * @param int $id - the users ID
     * @param Null|string $fieldName
     * @return boolean
     */
    public function verifyPassword(Object $object, int $id, ?string $fieldName = null): bool
    {
        if (array_key_exists('password_hash', $_POST)) {
            if (password_verify(
                $object->request->handler()->get('password_hash'),
                $this->getRepo()->findObjectBy(['id' => $id], ['password_hash'])->password_hash
            )) {
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
    public function isPasswordMatching(Object $object, Object $cleanData): bool
    {
        if ($cleanData->client_password_hash === $cleanData->password_hash_retype) {
            return true;
        }
        return false;
    }

    /**
     * Returns true only if the current account ID matches the current sessions ID
     * returns false otherwise
     *
     * @param Object $object
     * @return boolean
     */
    public function isOwnAccount(Object $object): bool
    {
        if ($object) {
            $userID = $object->formBuilder->getData()['user_id'];
            if (intval($userID) === $_SESSION['user_id']) {
                return true;
            } else {
                return false;
            }
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

    public function updateProfileAfterValidation(Object $cleanData, Object $repository): array
    {
        $this->validateChanges($cleanData, $repository);
        if ($this->unsetValues($cleanData)) {
            $data = $cleanData;
            $newCleanData = [
                'firstname' => isset($data->firstname) ? $data->firstname : $repository->firstname,
                'lastname' => isset($data->lastname) ? $data->lastname : $repository->lastname,
                'email' => isset($data->email) ? $data->email : $repository->email,
            ];
            return [
                $newCleanData,
                $this->getProfileErrors()
            ];
        }
    }

    /**
     * delete the user profile account
     *
     * @param Object $cleanData
     * @param Object|null $repository
     * @return array
     */
    public function deleteAccountOnceValidated(Object $cleanData, Null|Object $repository): array
    {
        $this->validateChanges($cleanData, $repository);
        if ($this->unsetValues($cleanData)) {
            $newCleanData = [
                'id' => intval($cleanData->user_id)
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
    private function validateChanges(Object $cleanData, Null|Object $repository): array
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
                    if (!$this->validatePassword((object)$value, $repository)) {
                        $this->profileError[] = '';
                    }
                    break;
                case 'user_id':

                    break;
                default:
                    /*if ($value === $repository->$key) {
                        $this->profileError[] = 'No changes made!';
                    }*/
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
