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
use MagmaCore\Session\SessionTrait;
use MagmaCore\DataObjectLayer\DataRepository\AbstractDataRepositoryValidation;

class PermissionValidate extends AbstractDataRepositoryValidation
{

    use SessionTrait;

    protected array $errors = [];
    protected array $cleanData;
    protected array $dataBag = [];

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
                $createdById = $this->setDefaultValue($cleanData, 'created_byid', SessionTrait::sessionFromGlobal()->get('user_id') ?? 0);

                $newCleanData = [
                    'permission_name' => $this->isSet('permission_name', $cleanData, $dataRepository),
                    'permission_description' => $this->isSet('permission_description', $cleanData, $dataRepository),
                    'created_byid' => $createdById
                ];
                $this->dataBag = [];
            }
            return [
                $newCleanData,
                $this->validatedDataBag($newCleanData),
            ];
        }
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
     * @param object|null $dataRepository
     * @return void
     */
    public function validate(array $cleanData, object|null $dataRepository = null): ?array
    {
        if (null !== $cleanData) {
            if (is_array($cleanData) && count($cleanData) > 0) {
                foreach ($cleanData as $key => $value) :
                    if (isset($key) && $key != '') :
                        switch ($key):
                            case "permission_name":
                            case "permission_description":
                                if (empty($value)) {
                                    $this->errors = Error::display('err_field_require');
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
