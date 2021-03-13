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

use MagmaCore\Error\Error;
use MagmaCore\Utility\ClientIP;
use MagmaCore\Collection\Collection;
use MagmaCore\Utility\HashGenerator;
use MagmaCore\Utility\PasswordEncoder;
use App\Controller\Admin\UserController;
use MagmaCore\Utility\GravatarGenerator;
use MagmaCore\Utility\RandomCharGenerator;
use MagmaCore\ValidationRule\ValidationRule;
use MagmaCore\DataObjectLayer\DataRepository\AbstractDataRepositoryValidation;

class UserValidate extends AbstractDataRepositoryValidation
{

    /** @var array $errors */
    protected array $errors = [];
    /** @var array $dataBag */
    protected array $dataBag = [];
    /** @var ValidationRule $rules */
    protected ValidationRule $rules;

    /** @var string - empty string will redirect on the same request */
    protected const REDIRECT_BACK_TO = '';

    /**
     * Undocumented function
     *
     * @param ValidationRule $rules
     * @return void
     */
    public function __construct(ValidationRule $rules)
    {
        $this->rules = $rules;
        $this->rules->addObject(UserController::class, $this);
    }

    /**
     * @inheritdoc
     * @param Collection $entityCollection
     * @param object|null $dataRepository - the repository for the entity
     * @return mixed
     */
    public function validateBeforePersist(Collection $entityCollection, Null|object $dataRepository = null)
    {
        $this->validate($entityCollection, $dataRepository);
        $dataCollection = $this->mergeWithFields($entityCollection->all());
        if (null !== $dataCollection) {
            $email = $this->isSet('email', $dataCollection, $dataRepository);
            list($tokenHash, $activationHash) = (new HashGenerator())->hash();

            $newCleanData = [
                'firstname' =>          $this->isSet('firstname', $dataCollection, $dataRepository),
                'lastname' =>           $this->isSet('lastname', $dataCollection, $dataRepository),
                'email' =>              $email,
                'password_hash' =>      $this->userPassword($dataCollection),
                'activation_token' =>   $tokenHash,
                'status' =>             $this->isSet('status', $dataCollection, $dataRepository),
                'created_byid' =>       $this->getCreator($dataCollection),
                'gravatar' =>           GravatarGenerator::setGravatar($email),
                'remote_addr' =>        ClientIP::getClientIp()
            ];

            /* Settings additional data which will get merge with the dataBag */
            $this->dataBag['activation_hash'] = $activationHash;
            if (array_key_exists('role_id', $dataCollection)) {
                $this->dataBag['role_id'] = intval($dataCollection['role_id']);
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
            $this->validatedDataBag(
                array_merge(
                    $newCleanData,
                    ['random_pass' => $this->randomPassword]
                )
            )
        ];
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
    private function userPassword(object|array $cleanData, int $length = 12): string
    {
        $userPassword = '';
        $userPassword = $this->isSet('client_password_hash', $cleanData);
        $encodedPassword = PasswordEncoder::encode(
            !empty($userPassword) ? $userPassword : ($this->randomPassword = RandomCharGenerator::generate($length))
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
        return [];
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
     * @return array
     */
    public function validationRedirect(): string
    {
        return sprintf('%s', self::REDIRECT_BACK_TO);
    }

    /**
     * @inheritdoc
     * @param Collection $entityCollection
     * @param Object|null $dataRepository
     * @return void
     */
    public function validate(Collection $entityCollection, Null|Object $dataRepository = null): void
    {
        if (null !== $entityCollection) {
            if (is_object($entityCollection) && $entityCollection->count() > 0) {
                foreach ($entityCollection as $this->key => $this->value) :
                    if (isset($this->key) && $this->key != '') :
                        switch ($this->key):
                            case 'password_hash':
                            case 'client_password_hash':
                                if ($this->rules) {
                                    $this->rules->addRule("required|unique|email");
                                }
                                break;
                            case 'email':
                                if ($this->rules) {
                                    $this->rules->addRule("required|unique|email");
                                }
                                break;
                            case 'firstname':
                            case 'lastname':
                                if ($this->rules) {
                                    $this->rules->addRule("required");
                                }
                                break;
                            default:
                                if ($entityCollection === $dataRepository) {
                                    $this->errors = Error::display('err_unchange');
                                }
                                break;
                        endswitch;
                    endif;
                endforeach;
            }
        }
    }
}
