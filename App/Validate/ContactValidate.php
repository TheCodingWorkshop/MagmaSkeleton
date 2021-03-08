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

use MagmaCore\Session\SessionTrait;
use MagmaCore\DataObjectLayer\DataRepository\AbstractDataRepositoryValidation;
use MagmaCore\ValidationRule\ValidationRule;

class RoleValidate extends AbstractDataRepositoryValidation
{

    /** @var trait */
    use SessionTrait;

    /** @var array $errors */
    protected array $errors = [];
    /** @var array $cleanData */
    protected array $cleanData;
    /** @var array $dataBag */
    protected array $dataBag = [];
    /** @var ValidationRule $rules */
    protected ValidationRule $rules;

    /**
     * Undocumented function
     */
    public function __construct()
    {
        $this->rules = new ValidationRule(ContactController::class, $this);
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

        if (empty($this->errors)) {
            $cleanData = $this->mergeWithFields($this->cleanData);
            if (null !== $cleanData) {

                /**
                 * Your validation code here
                 */
                $this->dataBag = [];
            }
            return [
                $newCleanData,
                $this->validatedDataBag($newCleanData),
            ];
        }
    }

    /**
     * Undocumented function
     *
     * @param [type] $newCleanData
     * @return array
     */
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

    /**
     * Undocumented function
     *
     * @return array
     */
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
                            case 'name':
                                break;
                        endswitch;
                    endif;
                endforeach;

                return $this->errors;
            }
        }
    }
}
