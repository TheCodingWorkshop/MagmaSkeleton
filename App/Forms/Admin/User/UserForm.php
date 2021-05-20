<?php
/*
 * This file is part of the MagmaCore package.
 *
 * (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

declare (strict_types = 1);

namespace App\Forms\Admin\User;

use MagmaCore\Utility\Yaml;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\FormBuilderBlueprint;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\FormBuilderBlueprintInterface;

class UserForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

    /** @var FormBuilderBlueprintInterface $blueprint */
    private FormBuilderBlueprintInterface $blueprint;

    /**
     * Main class constructor
     *
     * @param FormBuilderBlueprint $blueprint
     * @return void
     */
    public function __construct(FormBuilderBlueprint $blueprint)
    {
        $this->blueprint = $blueprint;
    }

    /**
     * {@inheritdoc}
     * @param string $action - form action
     * @return string
     * @throws Exception
     */
    public function createForm(string $action, $dataRepository = null, object $callingController = null)
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
                $this->blueprint->choices(Yaml::file('controller')['user']['status_choices'], 'pending'),
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
