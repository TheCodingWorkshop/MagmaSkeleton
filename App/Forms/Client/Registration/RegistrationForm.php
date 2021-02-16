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

namespace App\Forms\Client\Registration;

use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\Type\PasswordType;
use MagmaCore\FormBuilder\Type\EmailType;
use MagmaCore\FormBuilder\Type\TextType;
use MagmaCore\FormBuilder\Type\HiddenType;
use MagmaCore\FormBuilder\Type\SubmitType;

class RegistrationForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

    /**
     * {@inheritdoc}
     * @param string $action - form action
     * @return string
     * @throws Exception
     */
    public function createForm(string $action, $dataRepository = null)
    {
        return $this->form(['action' => $action, 'class' => 'uk-form-horizontal'])
            ->add([TextType::class => ['name' => 'firstname']], null)
            ->add([TextType::class => ['name' => 'lastname']], null)
            ->add([EmailType::class => ['name' => 'email', 'class' => ['uk-input', 'uk-form-medium']]], null)
            ->add([PasswordType::class => ['name' => 'client_password_hash','autocomplete' => 'new-password', 'required' => true]], null, ['new_label' => 'Password'])
            ->add([HiddenType::class => ['name' => 'role_id', 'value' => '2']])
            ->add([SubmitType::class => ['name' => 'new-register', 'value' => 'Register new account', 'class' => 'uk-button uk-button-primary']], 
            null, 
            ['show_label' => false, 'before_after_wrapper' => false]
        )
        ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);

    }

}
