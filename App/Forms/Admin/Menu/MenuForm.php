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

namespace App\Forms\Admin\Menu;

use MagmaCore\Auth\Model\MenuModel;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\FormBuilderBlueprint;
use MagmaCore\FormBuilder\FormBuilderBlueprintInterface;
use Exception;

class MenuForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

    /** @var FormBuilderBlueprintInterface $blueprint */
    private FormBuilderBlueprintInterface $blueprint;
    private MenuModel $model;

    /**
     * Main class constructor
     *
     * @param FormBuilderBlueprint $blueprint
     * @param MenuModel $model
     */
    public function __construct(FormBuilderBlueprint $blueprint, MenuModel $model)
    {
        $this->blueprint = $blueprint;
        $this->model = $model;
        parent::__construct();
    }

    /**
     * @return MenuModel
     */
    public function getModel(): MenuModel
    {
        return $this->model;
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
        return $this->form(['action' => $action, 'class' => ['uk-form-stacked'], "id" => "menuForm"])
            ->addRepository($dataRepository)
            ->add($this->blueprint->text('menu_name', [], $this->hasValue('menu_name')))
            ->add($this->blueprint->text('parent_menu', ['uk-width-1-2'], $this->hasValue('parent_menu')))
            ->add($this->blueprint->textarea('menu_description', ['uk-textarea'], 'menu_description'), $this->hasValue('menu_description'))

            ->add(
                $this->blueprint->submit(
                    $this->hasValue('id') ? 'edit-menu' : 'new-menu',
                    ['uk-button', 'uk-button-primary', 'uk-form-width-medium'],
                    'Update Menu'
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}

