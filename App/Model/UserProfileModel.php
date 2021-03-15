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

class UserProfileModel extends UserModel
{

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


}
