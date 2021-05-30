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

class EditNameForm extends ClientFormBuilder implements ClientFormBuilderInterface
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
		return $this->form(['action' => $action, 'class' => 'uk-form-stacked']) 
		->addRepository($userRepository)
		->add($this->blueprint->text('firstname',['uk-form-width-large']))
		->add($this->blueprint->text('lastname',['uk-form-width-large']))
		->add(
			$this->blueprint->submit(
				'new-account',
				['uk-button', 'uk-button-primary'],
				'Save and Continue'
			),
			null,
			$this->blueprint->settings(false, null, false, null, true, 'Remember Me')
		)
		->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);

        // ->add([TextType::class => ['name' => 'firstname', 'value' => $repository->firstname]], null, ['show_label' => false])
		// ->add([TextType::class => ['name' => 'lastname', 'value' => $repository->lastname]], null, ['show_label' => false])
		// ->add([HiddenType::class => ['name' => 'id', 'value' => $repository->id]], null, ['show_label' => false])
		// ->add([SubmitType::class => ['name' => 'name-account', 'value' => 'Save and Continue', 'class' => ['uk-button', 'uk-button-primary']]], null, ['show_label' => false])
	} 
}
