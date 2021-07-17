<?php
/*
 * This file is part of the MagmaCore package.
 *
 * (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

declare (strict_types=1);

namespace App\Forms\Client\Password;

use Exception;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\FormBuilderBlueprint;
use MagmaCore\FormBuilder\FormBuilderBlueprintInterface;
use MagmaCore\FormBuilder\Type\HiddenType;
use MagmaCore\FormBuilder\Type\PasswordType;
use MagmaCore\FormBuilder\Type\SubmitType;

class ResetForm extends ClientFormBuilder implements ClientFormBuilderInterface
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
        parent::__construct();
    }


    /**
     * @param string $action
     * @param object|null $dataRepository
     * @param object|null $callingController
     * @return string
     * @throws Exception
     */
    public function createForm(string $action, ?object $dataRepository = null, ?object $callingController = null): string
    {
        return $this->form(['action' => $action, 'class' => 'uk-form-stacked'])
            ->addRepository($dataRepository)
            ->add($this->blueprint->password('password_hash', ['uk-form-width-large']))
//            ->add(
//                [PasswordType::class => ['name' => 'password_hash', 'required' => true, 'autofocus' => true, 'placeholder' => 'New Password', 'class' => ['uk-input', '']]],
//                null,
//                ['show_label' => false]
//
//            )
//            ->add([HiddenType::class => ['name' => 'token', 'value' => $dataRepository]], null, ['show_label' => false])
//            ->add([SubmitType::class => ['name' => 'reset-password', 'value' => 'Save my new Password', 'class' => 'uk-button uk-button-teal']], null, ['show_label' => false, 'before_after_wrapper' => false])
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);

    }

}
