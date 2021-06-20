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

namespace App\Forms\Admin\Permission;

use App\Model\PermissionModel;
use Exception;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\FormBuilderBlueprint;
use MagmaCore\FormBuilder\FormBuilderBlueprintInterface;
use MagmaCore\Utility\Utilities;

class PermissionForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

    /** @var FormBuilderBlueprintInterface $blueprint */
    private FormBuilderBlueprintInterface $blueprint;
    private PermissionModel $model;

    /**
     * Main class constructor
     *
     * @param FormBuilderBlueprint $blueprint
     * @param PermissionModel $model
     */
    public function __construct(FormBuilderBlueprint $blueprint, PermissionModel $model)
    {
        $this->blueprint = $blueprint;
        $this->model = $model;
        parent::__construct();
    }

    public function array_flatten($array): array
    {
        $return = array();
        foreach ($array as $key => $value) {
            if (is_array($value)){ $return = array_merge($return, $this->array_flatten($value));}
            else {$return[$key] = $value;}
        }
        return $return;

    }

    /**
     * @param string $action
     * @param object|null $dataRepository
     * @param object|null $callingController
     * @return string
     * @throws Exception
     */
    public function createForm(string $action, ?object $dataRepository = null, ?object $callingController = null): string
    {
        return $this->form(['action' => $action, 'class' => ['uk-form-stacked'], "id" => "permissionForm"])
            ->addRepository($dataRepository)
            ->add($this->blueprint->text('permission_name', [], $this->hasValue('permission_name')))
            ->add($this->blueprint->select('permission_group', ['uk-select', 'uk-width-1-2']), $this->blueprint->choices(
                $this->array_flatten($this->model->getRepo()->findBy(['permission_name'])),
                ''
                )
            )
            ->add($this->blueprint->textarea('permission_description', ['uk-textarea'], 'permission_name'), $this->hasValue('permission_description'))
            ->add(
                $this->blueprint->submit(
                    $this->hasValue('id') ? 'edit-permission' : 'new-permission',
                    ['uk-button', 'uk-button-primary', 'uk-form-width-medium'],
                    'Save'
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}
