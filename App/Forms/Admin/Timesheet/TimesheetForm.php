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

namespace App\Forms\Admin\Timesheet;

use Exception;
use MagmaCore\UserManager\UserModel;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\FormBuilderBlueprint;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\FormBuilderBlueprintInterface;

class TimesheetForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

    /** @var FormBuilderBlueprintInterface $blueprint */
    private FormBuilderBlueprintInterface $blueprint;
    private UserModel $userModel;

    /**
     * Main class constructor
     *
     * @param FormBuilderBlueprint $blueprint
     * @return void
     */
    public function __construct(FormBuilderBlueprint $blueprint, UserModel $userModel)
    {
        $this->blueprint = $blueprint;
        $this->userModel = $userModel;
        parent::__construct();
    }

    public function getModel(): UserModel
    {
        return $this->userModel;
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
                "id" => "timesheetForm",
            ]
            )
            ->addRepository($dataRepository)
            ->add($this->blueprint->datePicker('week_start', ['uk-input uk-form-width-medium'], $this->hasValue('week_start')))
            ->add($this->blueprint->text('employee_id', [], $this->hasValue('employee_id') ?? $callingController->getSession()->get('user_id')))
            ->add($this->blueprint->text('project', [], $this->hasValue('project')))
            ->add($this->blueprint->text('costcenter', [], $this->hasValue('costcenter')))
            ->add($this->blueprint->text('engineer_time', [], $this->hasValue('engineer_time')))
            ->add(
                $this->blueprint->submit(
                    $this->hasValue('id') ? 'edit-timesheet' : 'new-timesheet',
                    ['uk-button', 'uk-button-primary', 'uk-form-width-medium'],
                    'Save',
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}
