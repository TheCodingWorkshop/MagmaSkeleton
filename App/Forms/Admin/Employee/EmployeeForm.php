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

namespace App\Forms\Admin\Employee;

use Exception;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\FormBuilderBlueprint;
use MagmaCore\FormBuilder\FormBuilderBlueprintInterface;

class EmployeeForm extends ClientFormBuilder implements ClientFormBuilderInterface
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
        return $this->form(
            [
                'action' => $action, 
                'class' => ['uk-form-stacked'], 
                "id" => "categoryForm",
            ]
            )
            ->addRepository($dataRepository)
            ->add($this->blueprint->text('cat_name', [], $this->hasValue('cat_name')))
            ->add($this->blueprint->text('cat_slug', [], $this->hasValue('cat_slug')))
            ->add($this->blueprint->textarea('cat_description', ['uk-textarea'], 'cat_description'), $this->hasValue('cat_description'))
            ->add(
                $this->blueprint->submit(
                    $this->hasValue('id') ? 'edit-category' : 'new-category',
                    ['uk-button', 'uk-button-primary', 'uk-form-width-medium'],
                    'Save',
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}
