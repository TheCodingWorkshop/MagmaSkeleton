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
    protected ?string $randomPass = null;

    protected const DEFAULT_STATUS = 'pending';

    /**
     * Validate the data before persisting to the database ensure
     * the entity return valid email and password fields
     * 
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

            /**
             * getArr() method simple merges any data returned within the 
             * $this->fields() method and the 
             * $cleanData array and return a combine array of data
             */
            $cleanData = $this->getArr($this->cleanData);
            if (null !== $cleanData) {
                $clientIP = (new ClientIP())->getClientIp();
                
                /* Password Generated within admin panel */
                $this->userPassword = (new RandomCharGenerator())->generate();
                /* User created frontend password from registration form */
                $clientPasswordHash = array_key_exists('client_password_hash', $cleanData) ? $cleanData['client_password_hash'] : $this->userPassword;

                $encodedPassword = (new PasswordEncoder())->encode(
                    (isset($clientPasswordHash) ? $clientPasswordHash : $this->userPssword)
                );
                $avatar = (new GravatarGenerator())->setGravatar($cleanData["email"] ? $cleanData['email'] : $dataRepository->email);

                list(
                    $tokenHash,
                    $activationHash
                ) = (new HashGenerator())->hash();

                $newCleanData = [
                    "firstname" => $cleanData["firstname"],
                    "lastname" => $cleanData["lastname"],
                    "email" => $cleanData["email"] ? $cleanData['email'] : $dataRepository->email,
                    "password_hash" => $encodedPassword,
                    "activation_token" => $tokenHash,
                    "status" => $this->setDefaultValue($cleanData, 'status', self::DEFAULT_STATUS),
                    "created_byid" => $this->setDefaultValue($cleanData, 'created_byid', $_SESSION['user_id']),
                    "gravatar" => $avatar,
                    "remote_addr" => $clientIP
                ];
                $this->dataBag['activation_hash'] = $activationHash;
                if (array_key_exists('role_id', $cleanData)) {
                    $this->dataBag['role_id'] = intval($cleanData['role_id']);
                }

                /**
                 * When updatng we want to unset some key from the $newCleanData array so we
                 * are not overwriting key aspects of the user object. ie. We don't wanna mess
                 * with the user password. And we don't wanna generate a new activation_token
                 * on user update so we will remove these two keys from the array. And !is_null
                 * is simpel ensuring we have a user object that we are unsetting from.
                 */
                if (!is_null($dataRepository)) {
                    unset($newCleanData['activation_token'], $newCleanData['password_hash']);
                }     
                    
            }
            return [
                $newCleanData,
                $this->validatedDataBag(array_merge($newCleanData, ['random_pass' => $this->userPassword])),
            ];
        }
    }

    public function validatedDataBag($newCleanData) : array
    {
        return array_merge($newCleanData, $this->dataBag);
    }

    /**
     * Returns the error if any was generated
     *
     * @return array
     */
    public function getErrors(): array
    {
        return $this->errors;
    }

    public function fields(): array
    {
        return [];
    }

    /**
     * Validate the user data
     *
     * @param array $cleanData
     * @param Object|null $dataRepository
     * @return void
     */
    public function validate(array $cleanData, Null|Object $dataRepository = null): Null|array
    {
        if (null !== $cleanData) {
            if (is_array($cleanData) && count($cleanData) > 0) {
                foreach ($cleanData as $key => $value) :
                    if (isset($key) && $key != '') :
                        switch ($key):
                            case "password_hash":
                            case "client_password_hash" :
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
