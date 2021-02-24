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

namespace App\Validate;

use MagmaCore\Utility\ClientIP;
use MagmaCore\Session\SessionTrait;
use MagmaCore\Utility\HashGenerator;
use MagmaCore\Utility\PasswordEncoder;
use MagmaCore\Utility\GravatarGenerator;
use MagmaCore\Utility\RandomCharGenerator;
use MagmaCore\DataObjectLayer\DataRepository\AbstractDataRepositoryValidation;
use MagmaCore\Error\Error;

class UserValidate extends AbstractDataRepositoryValidation
{

    use SessionTrait;

    protected array $errors = [];
    protected array $cleanData;
    protected array $dataBag = [];
    protected string|null $randomPassword = null;

    /**
     * @inheritdoc
     * @param object $cleanData - the incoming data
     * @param object|null $dataRepository - the repository for the entity
     * @return mixed
     */
    public function validateBeforePersist(object $cleanData, Null|object $dataRepository = null)
    {
        /* convert object to an array */
        $this->cleanData = (array)$cleanData;
        $this->validate($this->cleanData, $dataRepository);

        if (empty($this->errors)) {

            $cleanData = $this->mergeWithFields($this->cleanData);
            if (null !== $cleanData) {
                $email = $this->isSet('email', $cleanData, $dataRepository);
                list($tokenHash, $activationHash) = (new HashGenerator())->hash();

                $newCleanData = [
                    'firstname' => $this->isSet('firstname', $cleanData, $dataRepository),
                    'lastname' => $this->isSet('lastname', $cleanData, $dataRepository),
                    'email' => $email,
                    'password_hash' => $this->userPassword($cleanData),
                    'activation_token' => $tokenHash,
                    'status' => $this->isSet('status', $cleanData, $dataRepository),
                    'created_byid' => $this->setDefaultValue($cleanData, 'created_byid', isset($_SESSION['user_id']) ? $_SESSION['user_id'] : 0),
                    'gravatar' => (new GravatarGenerator())->setGravatar($email),
                    'remote_addr' => (new ClientIP())->getClientIp()
                ];

                /* Settings additional data which will get merge with the dataBag */
                $this->dataBag['activation_hash'] = $activationHash;
                if (array_key_exists('role_id', $cleanData)) {
                    $this->dataBag['role_id'] = intval($cleanData['role_id']);
                }

                /**
                 * When updatng we want to unset some key from the $newCleanData array so we
                 * are not overwriting key aspects of the user object. ie. We don't wanna mess
                 * with the user password. And we don't wanna generate a new activation_token
                 * on user update so we will remove these two keys from the array. And !is_null
                 * is simple ensuring we have a user object that we are unsetting from.
                 */
                if (!is_null($dataRepository)) {
                    unset($newCleanData['activation_token'], $newCleanData['password_hash']);
                }
            }
            return [
                $newCleanData,
                $this->validatedDataBag(array_merge($newCleanData, ['random_pass' => $this->randomPassword])),
            ];
        }
    }

    /**
     * A user is required to type their password when creating an account on the
     * frontend of the application. However when admin is creating a user from the 
     * admin panel. A password will be automatically generated instead and send along
     * with the user activation token via their registered email address. Either way the 
     * password will be encoded before pass the database handler
     *
     * @param object|array $cleanData
     * @param integer $length
     * @return string
     */
    private function userPassword(object|array $cleanData, int $length = 12) : string
    {
        $userPassword = '';
        $userPassword = $this->isSet('client_password_hash', $cleanData);
        $encodedPassword = (new PasswordEncoder())->encode(
            !empty($userPassword) ? $userPassword : ($this->randomPassword = (new RandomCharGenerator())->generate($length))
        );
        if ($encodedPassword)
            return $encodedPassword;
    }

    /**
     * @inheritdoc
     * @return array
     */
    public function validatedDataBag($newCleanData): array
    {
        return array_merge($newCleanData, $this->dataBag);
    }

    /**
     * @inheritdoc
     * @return array
     */
    public function getErrors(): array
    {
        return $this->errors;
    }

    /**
     * @inheritdoc
     * @return array
     */
    public function fields(): array
    {
        return [];
    }

    /**
     * @inheritdoc
     * @param array $cleanData
     * @param Object|null $dataRepository
     * @return void
     */
    public function validate(array $cleanData, Null|Object $dataRepository = null): array|null
    {
        if (null !== $cleanData) {
            if (is_array($cleanData) && count($cleanData) > 0) {
                foreach ($cleanData as $key => $value) :
                    if (isset($key) && $key != '') :
                        switch ($key):
                            case "password_hash":
                            case "client_password_hash":
                                if (!empty($value)) {
                                    if (strlen($value) < 6) {
                                        $this->errors[Error::SHORT_PASSWORD] = "Please enter at least 6 characters for the password";
                                    }
                                    if (preg_match('/.*[a-z]+.*/i', $value) == 0) {
                                        $this->errors[Error::PASSWORD_LETTER] = 'Password needs at least one letter';
                                    }
                                    if (preg_match('/.*\d+.*/i', $value) == 0) {
                                        $this->errors[Error::PASSWORD_LETTER] = 'Password needs at least one number';
                                    }
                                }
                                break;
                            case "email":
                                if (filter_var($value, FILTER_VALIDATE_EMAIL) === false) {
                                    $this->errors[Error::INVALID_EMAIL] = "Please enter a valid email address";
                                }
                                break;
                            case "firstame":
                            case "lastname":
                                if (isset($value)) {
                                    if (is_string($value) && empty($value)) {
                                        $this->errors[Error::EMPTY_FIELDS] = "Please enter your name this field can not be left empty.";
                                    }
                                }
                                break;
                            default:
                                if ($cleanData === $dataRepository) {
                                    $this->errors['no_changes'] = "No changes was made.";
                                }
                                break;
                        endswitch;
                    endif;
                endforeach;

                return $this->errors;
            }
        }
    }
}
