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

namespace App\Forms\Client\Security;

use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\Type\PasswordType;
use MagmaCore\FormBuilder\Type\CheckboxType;
use MagmaCore\FormBuilder\Type\SubmitType;
use MagmaCore\FormBuilder\Type\EmailType;

class LoginForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

	/**
	 * Construct the security login form. The attribute name='{string}' must match 
	 * the string name pass to the $this->form->isSubmittable() method within the 
	 * any method checking if the form canHandleRequest and isSubmittable
	 *
	 * @param string $action
	 * @param Object|null $Repository
	 * @return void
	 */
    public function createForm(string $action,?Object $repository = null) 
	{
		return $this->form(['action' => $action, 'class' => 'user']) 
		->add([EmailType::class => ['name' => 'email', 'class' => ['form-control form-control-user']]], null, ['show_label' => false])
		->add([PasswordType::class => ['name' => 'password_hash', 'class' => ['form-control form-control-user']]], null, ['show_label' => false])
		->add([CheckboxType::class => ['name' => 'remember_me', 'value' => false]], null, ['show_label' => false, 'checkbox_label' => 'Remember Me'])
		->add([SubmitType::class => ['name' => 'index-security', 'value' => 'Login', 'class' => ['btn btn-primary btn-user btn-block']]], null, ['show_label' => false])
		->build(['before' => '<div class="form-group">', 'after' => '</div>']);
	} 
}
