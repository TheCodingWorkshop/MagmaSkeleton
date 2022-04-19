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

namespace App\Forms\Admin\Message;

use App\Model\MessageModel;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\FormBuilderBlueprint;
use MagmaCore\FormBuilder\FormBuilderBlueprintInterface;
use Exception;

class MessageReplyForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

    /** @var FormBuilderBlueprintInterface $blueprint */
    private FormBuilderBlueprintInterface $blueprint;
    private MessageModel $model;

    /**
     * Main class constructor
     *
     * @param FormBuilderBlueprint $blueprint
     * @param MessageModel $model
     */
    public function __construct(FormBuilderBlueprint $blueprint, MessageModel $model)
    {
        $this->blueprint = $blueprint;
        $this->model = $model;
        parent::__construct();
    }

    /**
     * @return MessageModel
     */
    public function getModel(): MessageModel
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
            ->add(
                $this->blueprint->textarea('body', ['uk-textarea uk-form-blank'], 'reply_markdown', 'Message'), 
                $this->hasValue('body'),
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->add(
                $this->blueprint->text('attachment', ['uk-form-blank'], $this->hasValue('attachment'), true),
                null,
                $this->blueprint->settings(false, null, false, null, true)
                )
            ->add(
                $this->blueprint->submit(
                    'reply-message',
                    ['uk-button', 'uk-button-primary', 'uk-form-width-medium'],
                    'Reply'
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}

