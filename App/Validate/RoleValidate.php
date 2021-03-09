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
use MagmaCore\Auth\Model\RoleModel;
use MagmaCore\Session\SessionTrait;
use App\Controller\Admin\RoleController;
use MagmaCore\ValidationRule\ValidationRule;
use MagmaCore\DataObjectLayer\DataRepository\AbstractDataRepositoryValidation;

class RoleValidate extends AbstractDataRepositoryValidation
{

    use SessionTrait;

    protected array $errors = [];
    protected array $cleanData;
    protected array $dataBag = [];

    protected const DEFAULT_ROLE = 'subscriber';
    /** @var ValidationRule $rules */
    protected ValidationRule $rules;

    /**
     * Undocumented function
     */
    public function __construct()
    {
        $this->rules = new ValidationRule(
            RoleController::class,
            RoleModel::class,
            $this
        );
    }

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

        //if (empty($this->errors)) {
        $cleanData = $this->mergeWithFields($this->cleanData);
        if (null !== $cleanData) {
            $createdById = $this->setDefaultValue($cleanData, 'created_byid', SessionTrait::sessionFromGlobal()->get('user_id') ?? 0);

            $newCleanData = [
                'role_name' => $this->isSet('role_name', $cleanData, $dataRepository),
                'role_description' => $this->isSet('role_description', $cleanData, $dataRepository),
                'created_byid' => $createdById
            ];
            $this->dataBag = [];
        }
        return [
            $newCleanData,
            $this->validatedDataBag($newCleanData),
        ];
        // }
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
        return $this->errors;
    }

    public function fields(): array
    {
        return [];
    }

    /**
     * Validate the role data
     *
     * @param array $cleanData
     * @param Object|null $dataRepository
     * @return void
     */
    public function validate(array $cleanData, ?Object $dataRepository = null): ?array
    {
        if (null !== $cleanData) {
            if (is_array($cleanData) && count($cleanData) > 0) {
                foreach ($cleanData as $key => $value) :
                    $this->validateKey = $key;
                    $this->validateValue = $value;
                    if (isset($key) && $key != '') :
                        switch ($key):
                            case 'role_name':
                                if ($this->rules) {
                                    $this->rules->addRule("required|unique");
                                }
                                break;
                            case 'role_description':
                                if ($this->rules) {
                                    $this->rules->addRule("required");
                                }
                                break;
                            default:
                                if ($cleanData === $dataRepository) {
                                    $this->errors = Error::display('err_unchange');
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
