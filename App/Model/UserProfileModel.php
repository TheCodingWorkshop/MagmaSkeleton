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

class UserProfileModel extends UserModel
{

    /** @var array */
    protected array $profileError = [];
    /** @var array */
    protected const PROFILE_FIELDS = ['firstname', 'lastname', 'email', 'password_hash'];

    /**
     * Verify the user password before making changes. Ensuring the correct user 
     * is making changes.
     *
     * @return void
     */
    public function verifyPassword($id)
    {
        if (array_key_exists('password_hash', $_POST)) {
            if (password_verify($this->request->handler()->get('password_hash'), $this->getRepo()->find($id)['password_hash'])) {
                return true;
            }
        }
    }

    private function unsetValues(array $cleanData): bool
    {
        if (self::PROFILE_FIELDS) {
            foreach (self::PROFILE_FIELDS as $field) {
                if (array_key_exists($field, $cleanData)) {
                    return true;
                }
            }
            return false;
        }
        return false;
    }

    /**
     * Undocumented function
     *
     * @param array $cleanData
     * @param integer $repository
     * @return array
     */
    public function updateProfileNameOnceValidated(Object $cleanData, ?Object $repository): array
    {
        $clean = (array)$cleanData;
        $this->validateChanges($clean, $repository);
        if ($this->unsetValues($clean)) {
            $newCleanData = [
                'firstname' => $clean['firstname'] ? $clean['firstname'] : $repository->firstname,
                'lastname' => $clean['lastname'] ? $clean['lastname'] : $repository->lastname
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
     * @param array $cleanData
     * @param Object|null $repository
     * @return array
     */
    private function validateChanges(array $cleanData, ?Object $repository): array
    {
        foreach ($cleanData as $key => $value) {
            switch ($key) {
                case 'lastname':
                case 'lastname':
                    if (isset($value)) {
                        $this->profileError[] = 'One or more empty fields detected.';
                    }
                    break;
                case 'email':
                    if (filter_var($cleanData['email'], FILTER_VALIDATE_EMAIL) === false) {
                        $this->profileError[] = 'Please enter a valid email address.';
                    }
                    break;
                case 'password_hash':
                    if (!$this->validatePassword((object)$cleanData, $repository)) {
                        $this->profileError[] = '';
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
