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

class DeleteAccountForm extends ClientFormBuilder implements ClientFormBuilderInterface
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
		return $this->form(['action' => $action, 'class' => 'uk-form-stacked uk-form-bolder']) 
		->addRepository($userRepository)
		->add(
			$this->blueprint->submit(
				'delete-profile',
				['uk-button', 'uk-button-primary'],
				'Continue'
			),
			null,
			$this->blueprint->settings(false, null, false, null, true, 'Remember Me')
		)
		// ->add([HiddenType::class => ['name' => 'user_id', 'value' => $repository->id]], null, ['show_label' => false])
		// ->add([SubmitType::class => ['name' => 'delete-profile', 'value' => 'Continue', 'class' => ['uk-button', 'uk-button-danger uk-button-large']]], null, ['show_label' => false])
		->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
	} 
}
