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
        return $this->form(['action' => $action])
            ->add([TextType::class => ['name' => 'firstname']])
            ->add([TextType::class => ['name' => 'lastname']])
            ->add([EmailType::class => ['name' => 'email']])
            ->add([PasswordType::class => ['name' => 'password_hash','autocomplete' => 'new-password']])
            ->add([SubmitType::class => ['name' => 'new-register', 'value' => 'Register', 'class' => 'uk-button uk-button-teal']], 
            null, 
            ['show_label' => false, 'before_after_wrapper' => false]
        )
        ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);

    }

}
