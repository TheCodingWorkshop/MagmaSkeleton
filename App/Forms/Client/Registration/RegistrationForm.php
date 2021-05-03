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
        return $this->form(['action' => $action, 'class' => 'user'])

            ->add([TextType::class => ['name' => 'firstname', 'class' => ['form-control-user', 'form-control'], 'placeholder' => 'First Name']], null, ['show_label' => false])
            ->add([TextType::class => ['name' => 'lastname', 'placeholder' => 'Last Name', 'class' => ['form-control-user', 'form-control'],]], null, ['show_label' => false])

            ->add([EmailType::class => ['name' => 'email', 'placeholder' => 'Email Address', 'class' => ['form-control-user', 'form-control'],]], null, ['show_label' => false])
            ->add([PasswordType::class => ['name' => 'client_password_hash','autocomplete' => 'new-password', 'required' => true, 'placeholder' => 'Password', 'class' => ['form-control-user', 'form-control'],]], null, ['show_label' => false])

            ->add([HiddenType::class => ['name' => 'role_id', 'value' => '2']], null, ['show_label' => false])

            ->add([SubmitType::class => ['name' => 'register-registration', 'value' => 'Register Account', 'class' => 'btn btn-primary btn-user btn-block']], 
            null, 
            ['show_label' => false, 'before_after_wrapper' => false])
        ->build(['before' => '<div class="form-group">', 'after' => '</div>']);

    }

}
