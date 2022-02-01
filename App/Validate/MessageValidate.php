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

use App\Controller\Admin\MessageController;
use MagmaCore\Collection\Collection;
use MagmaCore\DataObjectLayer\DataRepository\AbstractDataRepositoryValidation;
use MagmaCore\ValidationRule\ValidationRule;

class MessageValidate extends AbstractDataRepositoryValidation
{

    /** @var array $errors */
    protected $errors = [];
    /** @var array $dataBag */
    protected array $dataBag = [];
    /** @var ValidationRule $rules */
    protected ValidationRule $rules;

    /** @var string */
    protected const REDIRECT_BACK_TO = '/admin/message/index';

    /**
     * Main class constructor. Uses the ValidateRule class has a dependency
     * We are also declaring the $this->rules->addObject() method which takes two
     * argument. First is a qualified namespace of the controller class which
     * calls this validation class and $this keyword which represents this
     * current object. This way we can actually get access to the controller
     * class throw the ValidationRule object
     *  `
     * @param ValidationRule $rules
     * @return void
     */
    public function __construct(ValidationRule $rules)
    {
        $this->rules = $rules;
        $this->rules->addObject(MessageController::class, $this);
    }

    /**
     * Validate the data before persisting to the database ensure
     * the entity return valid email and password fields
     *
     * @param Collection $entityCollection - the incoming data
     * @param object|null $dataRepository - the repository for the entity
     * @param object|null $controller
     * @return array
     */
    public function validateBeforePersist(Collection $entityCollection, ?object $dataRepository = null, ?object $controller = null): array
    {
        $this->validate($entityCollection, $dataRepository);
        $dataCollection = $this->mergeWithFields((array)$entityCollection->all());
        $newCleanData = [];
        $currentSessID = $controller->getSession()->get('user_id');
        if (null !== $dataCollection) {
            $newCleanData = [
                'subject' => $this->isSet('subject', $dataCollection, $dataRepository),
                'user_id' => $currentSessID,
                'body' => $this->isSet('body', $dataCollection, $dataRepository),
                'attachment' => $this->isSet('attachment', $dataCollection, $dataRepository),
                'status' => $this->isSet('status', $dataCollection, $dataRepository),
                'receiver' => $this->isSet('receiver', $dataCollection, $dataRepository),
                'is_marked' => $this->isSet('is_marked', $dataCollection, $dataRepository),
                'is_starred' => $this->isSet('is_starred', $dataCollection, $dataRepository),
            ];
            /* We can return an empty dataBag even if we have nothing to send */
            $this->dataBag = [];
        }
        return [
            $newCleanData,
            $this->validatedDataBag($newCleanData),
        ];
    }

    /**
     * Returns the validated data which will be dispatched to any listeners
     *
     * @param array $newCleanData
     * @return array
     */
    public function validatedDataBag(array $newCleanData): array
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
        return [];
    }

    /**
     * Add additional fields
     *
     * @return array
     */
    public function fields(): array
    {
        return [];
    }

    /**
     * Provides a redirect path for the validation class to use.
     *
     * @return string
     */
    public function validationRedirect(): string
    {
        return sprintf('%s', self::REDIRECT_BACK_TO);
    }

    /**
     * Return a feedback if the save button was click but no data was change or modified
     * from the form
     *
     * @param Collection $entityCollection
     * @param object|null $dataRepository
     * @return null
     */
    private function throwWarningIfNoChange(Collection $entityCollection, ?object $dataRepository = null)
    {
        if ($dataRepository !== null) {
            if (
                $entityCollection['user_id'] === $dataRepository->user_id &&
                $entityCollection['receiver'] === $dataRepository->receiver
            ) {
                if ($controller = $this->rules->getController()) {
                    if ($controller->error) {
                        $controller->error
                            ->addError(['no_change' => 'No Changes'], $controller)
                            ->dispatchError(self::REDIRECT_BACK_TO);
                    }
                }
            }

        }
        return null;
    }

    /**
     * Validate the data collection fields
     *
     * @param Collection $entityCollection
     * @param Object|null $dataRepository
     * @return void
     */
    public function validate(Collection $entityCollection, ?object $dataRepository = null): void
    {
        $this->doValidation(
            $entityCollection,
            $dataRepository,
            function ($key, $value, $entityCollection, $dataRepository) {
                if ($rules = $this->rules) {
                    return match ($key) {
                        'subject', 'body', 'status', 'is_marked', 'is_starred', 'user_id' => $rules->addRule("required"),
                        default => $this->throwWarningIfNoChange($entityCollection, $dataRepository)
                    };
                }
            }
        );
    }
}
