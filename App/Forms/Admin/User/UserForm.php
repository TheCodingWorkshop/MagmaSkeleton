<?php
/*
 * This file is part of the MagmaCore package.
 *
 * (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

declare (strict_types=1);

namespace App\Forms\Admin\User;

use Exception;
use MagmaCore\DataObjectLayer\DataLayerTrait;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\FormBuilderBlueprint;
use MagmaCore\FormBuilder\FormBuilderBlueprintInterface;
use MagmaCore\Utility\Yaml;
use App\Model\RoleModel;

class UserForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

    use DataLayerTrait;
    /** @var FormBuilderBlueprintInterface $blueprint */
    private FormBuilderBlueprintInterface $blueprint;
    private RoleModel $roleModel;

    /**
     * Main class constructor
     *
     * @param FormBuilderBlueprint $blueprint
     * @param RoleModel $roleModel
     */
    public function __construct(FormBuilderBlueprint $blueprint, RoleModel $roleModel)
    {
        $this->blueprint = $blueprint;
        $this->roleModel = $roleModel;
        parent::__construct();
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
        return $this->form(['action' => $action, 'class' => ['uk-form-stacked'], "id" => "userForm", "leave_form_open" => true])
            ->addRepository($dataRepository)
            ->add($this->blueprint->text('firstname', [], $this->hasValue('firstname')))
            ->add($this->blueprint->text('lastname', [], $this->hasValue('lastname')))
            ->add($this->blueprint->email('email', [], $this->hasValue('email')))
            ->add($this->blueprint->password(
                'password_hash',
                ['uk-form-width-medium'],
                null,
                'new-password',
                false,
                false,
                true,
                'Auto Generated'),
                null,
                $this->blueprint->settings(false, null, true, 'Password', false, null, 'Leaving this field blank will auto generate a random password')
            )
            ->add(
                $this->blueprint->radio('status', [], $this->hasValue('status')),
                $this->blueprint->choices(Yaml::file('controller')['user']['status_choices'], $dataRepository->status ?? 'pending'),
                $this->blueprint->settings(false, null, true, null, true)
            )
            ->add(
                $this->blueprint->radio('role_id', [], $this->hasValue('role_name')),
                $this->blueprint->choices($this->roleModel->getRepo()->findBy(['id']), 2),
                $this->blueprint->settings(false, null, true, null, true)
            )
            ->add($this->blueprint->text(
                'remote_addr',
                ['uk-form-width-small'],
                $this->hasValue('remote_addr'), /* field value */
                true, /* make field disabled */
                'IP Address'),
                null,
                $this->blueprint->settings(false, null, false)
            )
            ->add($this->blueprint->submit(
                $this->hasValue('id') ? 'edit-user' : 'new-user',
                ['uk-button', 'uk-button-primary', 'uk-form-width-medium'],
                'Save'),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}
