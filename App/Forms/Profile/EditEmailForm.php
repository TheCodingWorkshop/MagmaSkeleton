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

namespace App\Forms\Profile;

use MagmaCore\FormBuilder\Type\EmailType;
use MagmaCore\FormBuilder\Type\HiddenType;
use MagmaCore\FormBuilder\Type\SubmitType;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\Type\PasswordType;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;

class EditEmailForm extends ClientFormBuilder implements ClientFormBuilderInterface
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
		return $this->form(['action' => $action, 'class' => 'uk-form-stacked uk-form-bolder']) 
		->add([EmailType::class => ['name' => 'email', 'value' => $repository->email]], null, ['show_label' => false])
		->add([PasswordType::class => ['name' => 'password_hash']], null, ['show_label' => false])
		->add([HiddenType::class => ['name' => 'id', 'value' => $repository->id]], null, ['show_label' => false])
		->add([SubmitType::class => ['name' => 'email-account', 'value' => 'Save and Continue', 'class' => ['uk-button', 'uk-button-primary']]], null, ['show_label' => false])
		->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
	} 
}
