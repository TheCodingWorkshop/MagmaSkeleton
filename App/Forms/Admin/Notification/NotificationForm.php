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

namespace App\Forms\Admin\Notification;

use App\Model\NotificationModel;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\FormBuilderBlueprint;
use MagmaCore\FormBuilder\FormBuilderBlueprintInterface;
use Exception;

class NotificationForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

    /** @var FormBuilderBlueprintInterface $blueprint */
    private FormBuilderBlueprintInterface $blueprint;
    private NotificationModel $model;

    /**
     * Main class constructor
     *
     * @param FormBuilderBlueprint $blueprint
     * @param NotificationModel $model
     */
    public function __construct(FormBuilderBlueprint $blueprint, NotificationModel $model)
    {
        $this->blueprint = $blueprint;
        $this->model = $model;
        parent::__construct();
    }

    /**
     * @return NotificationModel
     */
    public function getModel(): NotificationModel
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
        return $this->form(['action' => $action, 'class' => ['uk-form-stacked'], "id" => "permissionForm"])
            ->addRepository($dataRepository)
            ->add($this->blueprint->text('notify_title', [], $this->hasValue('notify_title')))
            ->add($this->blueprint->text('notify_type', [], $this->hasValue('notify_type')))
            ->add($this->blueprint->text('notify_status', [], $this->hasValue('notify_status')))
            ->add($this->blueprint->text('notifier', [], $this->hasValue('notifier')))
            ->add($this->blueprint->textarea('notify_description', ['uk-textarea'], 'notify_description'), $this->hasValue('notify_description'))
            ->add(
                $this->blueprint->submit(
                    $this->hasValue('id') ? 'edit-notification' : 'new-notification',
                    ['uk-button', 'uk-button-primary', 'uk-form-width-medium'],
                    'Save'
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}

