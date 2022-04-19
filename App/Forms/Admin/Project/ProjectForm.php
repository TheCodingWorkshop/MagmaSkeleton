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

namespace App\Forms\Admin\Project;

use App\Model\ProjectModel;
use Exception;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\FormBuilderBlueprint;
use MagmaCore\FormBuilder\FormBuilderBlueprintInterface;
use MagmaCore\Utility\Yaml;

class ProjectForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

    /** @var FormBuilderBlueprintInterface $blueprint */
    private FormBuilderBlueprintInterface $blueprint;
    private ProjectModel $model;

    /**
     * Main class constructor
     *
     * @param FormBuilderBlueprint $blueprint
     * @param ProjectModel $model
     */
    public function __construct(FormBuilderBlueprint $blueprint, ProjectModel $model)
    {
        $this->blueprint = $blueprint;
        $this->model = $model;
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
        return $this->form(['action' => $action, 'class' => ['uk-form-stacked'], "id" => "projectForm"])
            ->addRepository($dataRepository)
            ->add($this->blueprint->text('name', [], $this->hasValue('name')))
            ->add($this->blueprint->text('client', [], $this->hasValue('client')))
            ->add($this->blueprint->text('coordinator', [], $this->hasValue('coordinator')))
            ->add($this->blueprint->text('type', [], $this->hasValue('type')))
            ->add(
                $this->blueprint->radio('status', [], $this->hasValue('status')),
                $this->blueprint->choices(['open', 'close'], 'open'),
                $this->blueprint->settings(false, null, true, null, true)
            )
            ->add($this->blueprint->textarea('description', ['uk-textarea'], 'description'), $this->hasValue('description'))
            ->add($this->blueprint->text('duration', [], $this->hasValue('duration')))
            ->add($this->blueprint->text('location', [], $this->hasValue('location')))
            ->add($this->blueprint->text('cost', ['uk-width-1-2'], $this->hasValue('cost')))
            ->add(
                $this->blueprint->submit(
                    $this->hasValue('id') ? 'edit-project' : 'new-project',
                    ['uk-button', 'uk-button-primary', 'uk-form-width-medium'],
                    'Save'
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}
