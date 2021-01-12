<?php

declare(strict_types=1);

namespace App\Validate;

use MagmaCore\DataObjectLayer\DataRepository\AbstractDataRepositoryValidation;
use MagmaCore\Session\SessionTrait;
use MagmaCore\Utility\PasswordEncoder;
use MagmaCore\Utility\HashGenerator;
use MagmaCore\Utility\GravatarGenerator;
use MagmaCore\Utility\ClientIP;
use App\Model\UserModel;

class UserValidate extends AbstractDataRepositoryValidation
{

    use SessionTrait;

    protected array $errors = [];
    protected array $cleanData;
    protected array $dataBag = [];

    protected const DEFAULT_STATUS = 'pending';

    /**
     * Validate the data before persisting to the database ensure
     * the entity return valid email and password fields
     * 
     * @param object $cleanData - the incoming data
     * @param object|null $dataRepository - the repository for the entity
     * @return mixed
     */
    public function validateBeforePersist(object $cleanData, ?object $dataRepository = null)
    {
        /* convert object to an array */
        $this->cleanData = (array)$cleanData;
        $this->validate($this->cleanData, $dataRepository);

        if (empty($this->errors)) {

            /**
             * getArr() method simple merges any data returned within the $this->fields() method and the 
             * $cleanData array and return a combine array of data
             */
            $cleanData = $this->getArr($this->cleanData);
            if (null !== $cleanData) {
                $status = $this->setDefaultValue($cleanData, 'status', self::DEFAULT_STATUS);
                $createdById = $this->setDefaultValue($cleanData, 'created_byid', SessionTrait::sessionFromGlobal()->get('user_id') ?? 0);
                $encodedPassword = (new PasswordEncoder())->encode($cleanData['password_hash']);
                list(
                    $tokenHash, 
                    $activationHash) = (new HashGenerator())->hash();
                
                $newCleanData = [
                    "firstname" => $cleanData["firstname"],
                    "lastname" => $cleanData["lastname"],
                    "email" => $cleanData["email"],
                    "password_hash" => $encodedPassword,
                    "activation_token" => $tokenHash,
                    "status" => $status,
                    "created_byid" => $createdById,
                    "gravatar" => (new GravatarGenerator())->setGravatar($cleanData["email"]),
                    "remote_addr" => (new ClientIP())->getClientIp()
                ];    
                $this->dataBag['activation_hash'] = $activationHash;
                if (null !== $dataRepository) {
                    unset($newCleanData['activation_token']);
                }
            }
            return [
                $newCleanData,
                $this->validatedDataBag($newCleanData), /* User will need this send to their email address so they can activate their accounts */
            ];
        }
    }

    public function validatedDataBag($newCleanData) 
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
        return [

        ];
    }

    /**
     * Validate the user data
     *
     * @param array $cleanData
     * @param Object|null $dataRepository
     * @return void
     */
    public function validate(array $cleanData, ?Object $dataRepository = null) : ?array
    {
        if (null !== $cleanData) {    
            if (is_array($cleanData) && count($cleanData) > 0) {
                foreach ($cleanData as $key => $value) :
                    if (isset($key) && $key !='') :
                        switch ($key) :
                            case "password_hash" :
                                if (isset($value) && $value !=="") {
                                    if (strlen($value) < 6) {
                                        $this->errors[] = "Please enter at least 6 characters for the password";
                                    }
                                    if (preg_match('/.*[a-z]+.*/i', $value) == 0) {
                                        $this->errors[] = 'Password needs at least one letter';
                                    }
                                    if (preg_match('/.*\d+.*/i', $value) == 0) {
                                        $this->errors[] = 'Password needs at least one number';
                                    }

                                }
                                break;
                            case "email" :                                
                                if (filter_var($value, FILTER_VALIDATE_EMAIL) === false) {
                                    $this->errors[] = "Please enter a valid email address";
                                }
                                /*if ((new UserModel())->emailExists($value, $dataRepository->id ?? null)) {
                                    $this->errors[] = "Email address already exists";
                                }*/
                                break;
                            case "firstame" :
                            case "lastname" :
                                if (is_string($value) && empty($value)) {
                                    $this->errors[] = "Please enter your name this field can not be left empty.";
                                }
                                break;
                            default :
                                if ($cleanData === $dataRepository) {
                                    $this->errors[] = "No changes was made.";
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