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

use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\FormBuilderBlueprint;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\FormBuilderBlueprintInterface;

class EditPasswordForm extends ClientFormBuilder implements ClientFormBuilderInterface
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
	 * Construct the security login form. The attribute name='{string}' must match 
	 * the string name pass to the $this->form->isSubmittable() method within the 
	 * any method checking if the form canHandleRequest and isSubmittable
	 *
	 * @param string $action
	 * @param object|null $userRepository
	 * @return void
	 */
	public function createForm(string $action, ?Object $userRepository = null, object $callingController = null)
	{
		return $this->form(['action' => $action, 'class' => 'uk-form-horizontal'])
		->addRepository($userRepository)
		->add($this->blueprint->password(
			'password_hash', 
			['uk-form-width-large'], 
			null, 
			'autocomplete', 
			true),
			NULL,
			$this->blueprint->settings(false, null, true, 'Old Password', true)
		)
		->add($this->blueprint->password(
			'client_password_hash', 
			['uk-form-width-large'], 
			null, 
			'autocomplete', 
			true),
			NULL,
			$this->blueprint->settings(false, null, true, 'New Password', true)
		)
		->add($this->blueprint->password(
			'password_hash_retype', 
			['uk-form-width-large'], 
			null, 
			'autocomplete', 
			true),
			NULL,
			$this->blueprint->settings(false, null, true, 'Confirm Password', true)
		)

		->add(
			$this->blueprint->submit(
				'password-account',
				['uk-button', 'uk-button-primary'],
				'Save and Continue'
			),
			null,
			$this->blueprint->settings(false, null, false, null, true, 'Remember Me')
		)
		->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);

			// ->add([PasswordType::class => ['name' => 'password_hash', 'placeholder' => 'Current Password']], null, ['show_label' => false])
			// ->add([PasswordType::class => ['name' => 'client_password_hash', 'placeholder' => 'New Password']], null, ['show_label' => false])
			// ->add([PasswordType::class => ['name' => 'password_hash_retype', 'placeholder' => 'Retype Password']], null, ['show_label' => false])
			// ->add([HiddenType::class => ['name' => 'id', 'value' => $repository->id]], null, ['show_label' => false])
			// ->add([SubmitType::class => ['name' => 'password-account', 'value' => 'Save and Continue', 'class' => ['uk-button', 'uk-button-primary']]], null, ['show_label' => false])
			// ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
	}
}
