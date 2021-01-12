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

namespace App\Forms\Client\Password;

use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\Type\PasswordType;
use MagmaCore\FormBuilder\Type\SubmitType;
use MagmaCore\FormBuilder\Type\HiddenType;

class ResetForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

    /**
     * {@inheritdoc}
     * @param string $action - form action
     * @param mixed $dataRepository - Within this context the returns the hash token
     * @return string
     * @throws Exception
     */
    public function createForm(string $action, $dataRepository = null)
    {
        return $this->form(['action' => $action])
            ->add(
                [PasswordType::class => ['name' => 'password_hash', 'required' => true, 'autofocus' => true, 'placeholder' => 'New Password', 'class' => ['uk-input', 'uk-form-width-large']]],
                null,
                ['inline_icon' => 'lock', 'inline_flip_icon' => true, 'new_label' => 'New Password']

            )
            ->add([HiddenType::class => ['name' => 'token', 'value' => $dataRepository]], null, ['show_label' => false])
            ->add([SubmitType::class => ['name' => 'reset-password', 'value' => 'Reset Password', 'class' => 'uk-button uk-button-teal']], null, ['show_label' => false, 'before_after_wrapper' => false])
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);

    }

}
