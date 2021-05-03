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
use MagmaCore\FormBuilder\Type\EmailType;
use MagmaCore\FormBuilder\Type\SubmitType;

class PasswordForm extends ClientFormBuilder implements ClientFormBuilderInterface
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
            ->add([EmailType::class => ['name' => 'email', 'required' => true, 'autofocus' => true, 'placeholder' => 'Enter Email Address..', 'class' => ['form-control-user', 'form-control'],]], null, ['show_label' => false])
            ->add([SubmitType::class => ['name' => 'forgot-password', 'value' => 'Reset Password', 'class' => 'btn btn-primary btn-user btn-block']], 
            null, 
            ['show_label' => false, 'before_after_wrapper' => false]
            )
            ->build(['before' => '<div class="form-group">', 'after' => '</div>']
        );

    }

}
