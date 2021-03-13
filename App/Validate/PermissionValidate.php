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
use MagmaCore\Collection\Collection;
use MagmaCore\ValidationRule\ValidationRule;
use App\Controller\Admin\PermissionController;
use MagmaCore\DataObjectLayer\DataRepository\AbstractDataRepositoryValidation;

class PermissionValidate extends AbstractDataRepositoryValidation
{

    /** @var array $errors */
    protected array $errors = [];
    /** @var array $dataBag */
    protected array $dataBag = [];
    /** @var ValidationRule $rules */
    protected ValidationRule $rules;

    /** @var string */
    protected const REDIRECT_BACK_TO = '/admin/permission/index';

    /**
     * Undocumented function
     *
     * @param ValidationRule $rules
     * @return void
     */
    public function __construct(ValidationRule $rules)
    {
        $this->rules = $rules;
        $this->rules->addObject(PermissionController::class, $this);
    }

    /**
     * Validate the data before persisting to the database ensure
     * the entity return valid email and password fields
     * 
     * @param Collection $entityCollection - the incoming data
     * @param object|null $dataRepository - the repository for the entity
     * @return mixed
     */
    public function validateBeforePersist(Collection $entityCollection, ?object $dataRepository = null)
    {
        $this->validate($entityCollection, $dataRepository);
        $dataCollection = $this->mergeWithFields($entityCollection->all());
        if (null !== $dataCollection) {
            $newCleanData = [
                'permission_name' => $this->isSet('permission_name', $dataCollection, $dataRepository),
                'permission_description' => $this->isSet('permission_description', $dataCollection, $dataRepository),
                'created_byid' => $this->getCreator($dataCollection)
            ];
            $this->dataBag = [];
        }
        return [
            $newCleanData,
            $this->validatedDataBag($newCleanData),
        ];
    }

    public function validatedDataBag($newCleanData): array
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

    public function fields(): array
    {
        return [];
    }

    /**
     * Returns the redirect path for the validation
     *
     * @return string
     */
    public function validationRedirect(): string
    {
        return sprintf('%s', self::REDIRECT_BACK_TO);
    }


    /**
     * Validate the role data
     *
     * @param Collection $entityCollection
     * @param Object|null $dataRepository
     * @return void
     */
    public function validate(Collection $entityCollection, ?Object $dataRepository = null): void
    {
        if (null !== $entityCollection) {
            if (is_array($entityCollection) && $entityCollection->count() > 0) {
                foreach ($entityCollection as $this->key => $this->value) :
                    if (isset($this->key) && $this->key != '') :
                        switch ($this->key):
                            case 'permission_name':
                                if ($this->rules) {
                                    $this->rules->addRule("required|unique");
                                }
                                break;
                            case 'permission_description':
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
