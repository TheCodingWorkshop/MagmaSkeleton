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

namespace App\Forms\Admin\CostCenter;

use Exception;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\FormBuilderBlueprint;
use MagmaCore\FormBuilder\FormBuilderBlueprintInterface;

class CostCenterForm extends ClientFormBuilder implements ClientFormBuilderInterface
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
                "id" => "holidayForm",
            ]
            )
            ->addRepository($dataRepository)
            ->add($this->blueprint->text('name', [], $this->hasValue('name')))
            ->add($this->blueprint->text('slug', [], $this->hasValue('slug')))
            ->add($this->blueprint->text('code', [], $this->hasValue('code')))
            ->add($this->blueprint->textarea('description', ['uk-textarea'], 'description'), $this->hasValue('description'))
            ->add(
                $this->blueprint->submit(
                    $this->hasValue('id') ? 'edit-costcenter' : 'new-costcenter',
                    ['uk-button', 'uk-button-primary', 'uk-form-width-medium'],
                    'Save',
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}
