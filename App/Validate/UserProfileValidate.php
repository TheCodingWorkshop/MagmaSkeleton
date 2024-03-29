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

use App\Controller\Profile\AccountController;
use MagmaCore\Collection\Collection;
use MagmaCore\DataObjectLayer\DataRepository\AbstractDataRepositoryValidation;
use MagmaCore\Utility\RandomCharGenerator;
use MagmaCore\Utility\UtilityTrait;
use MagmaCore\ValidationRule\ValidationRule;
use Exception;

class UserProfileValidate extends AbstractDataRepositoryValidation
{

    use UtilityTrait;

    /** @var array $errors */
    protected array $errors = [];
    /** @var array $dataBag */
    protected array $dataBag = [];
    /** @var ValidationRule $rules */
    protected ValidationRule $rules;
    protected ?string $randomPassword = null;

    /** @var string - empty string will redirect on the same request */
    protected const REDIRECT_BACK_TO = '';

    /**
     * Main class constructor. Uses the ValidateRule class has a dependency
     * We are also declaring the $this->rules->addObject() method which takes two
     * argument. First is a qualified namespace of the controller class which
     * calls this validation class and $this keyword which represents this
     * current object. This way we can actually get access to the controller
     * class throw the ValidationRule object
     *
     * @param ValidationRule $rules
     * @return void
     */
    public function __construct(ValidationRule $rules)
    {
        $this->rules = $rules;
        $this->rules->addObject(AccountController::class, $this);
        $this->randomPassword = RandomCharGenerator::generate();
    }

    /**
     * @inheritdoc
     * @param Collection $entityCollection
     * @param object|null $dataRepository - the repository for the entity
     * @return array
     * @throws Exception
     */
    public function validateBeforePersist(Collection $entityCollection, ?object $dataRepository = null): array
    {
        $newCleanData = [];
        $this->validate($entityCollection, $dataRepository);
        $dataCollection = $this->mergeWithFields((array)$entityCollection->all());
        if (null !== $dataCollection) {
            $email = $this->isSet('email', $dataCollection, $dataRepository);
            $newCleanData = [
                'firstname' => $this->isSet('firstname', $dataCollection, $dataRepository),
                'lastname' => $this->isSet('lastname', $dataCollection, $dataRepository),
                'email' => $email,
            ];
            /* prevent the password from updating if not updating the password exactly */
            if (array_key_exists('password_hash', $dataCollection)) {
                $updatePassword = ['password_hash' => $this->userPassword($dataCollection)];
            }
        }
        return [
            array_merge($newCleanData, $updatePassword ?? []),
            $this->validatedDataBag(
                array_merge(
                    $newCleanData,
                    []
                )
            )
        ];
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
     * @return string
     */
    public function validationRedirect(): string
    {
        return sprintf('%s', self::REDIRECT_BACK_TO);
    }

    /**
     * @inheritdoc
     * @param Collection $entityCollection
     * @param object|null $dataRepository
     * @return void
     */
    public function validate(Collection $entityCollection, ?object $dataRepository = null): void
    {
        $this->doValidation(
            $entityCollection,
            $dataRepository,
            function ($key) {
                if (isset($this->rules)) {
                    return match ($key) {
                        'password_hash', 'client_password_hash' => $this->rules->addRule("required"),
                        'email' => $this->rules->addRule("required|email"),
                        'firstname', 'lastname' => $this->rules->addRule("required"),
                        default => NULL
                    };    
                }
            }
        );
    }
}
