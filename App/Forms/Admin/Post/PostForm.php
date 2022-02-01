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

use Exception;
use App\Model\PostModel;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\FormBuilderBlueprint;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\FormBuilderBlueprintInterface;

class PostForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

    /** @var FormBuilderBlueprintInterface $blueprint */
    private FormBuilderBlueprintInterface $blueprint;
    private PostModel $model;

    /**
     * Main class constructor
     *
     * @param FormBuilderBlueprint $blueprint
     * @param MessageModel $model
     * @param UserModel $userModel
     */
    public function __construct(FormBuilderBlueprint $blueprint, PostModel $model)
    {
        $this->blueprint = $blueprint;
        $this->model = $model;
        parent::__construct();
    }

    /**
     * @return MessageModel
     */
    public function getModel(): PostModel
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
            // ->add(
            //     $this->blueprint->select('receiver', ['uk-select', 'uk-form-blank', 'uk-border-bottom'], null, null, true), 
            //     $this->blueprint->choices(
            //         array_column($this->userModel->getRepo()->findAll(), 'email'),
            //         '',
            //         $this
            //     ),
            //     $this->blueprint->settings(false, null, false, null, true)

            // )
            ->add(
                $this->blueprint->text('receiver', ['uk-form-blank', 'uk-border-bottom'], $this->hasValue('receiver'), false, 'To'),
                NULL,
                $this->blueprint->settings(false, null, false, null, true)

            )

            ->add(
                $this->blueprint->text('subject', ['uk-form-blank', 'uk-border-bottom'], $this->hasValue('subject'), false, 'Subject'),
                NULL,
                $this->blueprint->settings(false, null, false, null, true)

            )
            ->add(
                $this->blueprint->textarea('body', ['uk-textarea', 'uk-form-blank'], null, 'Message'),
                $this->hasValue('body'),
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->add(
                $this->blueprint->upload('attachment', ['uk-button', 'uk-button-small', 'uk-button-default'], 'Upload', true),
                '<span class="ion-28"><ion-icon name="attach"></ion-icon></span>',
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->add(
                $this->blueprint->hidden('status', 'sent'),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->add(
                $this->blueprint->hidden('is_marked', '0'),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->add(
                $this->blueprint->hidden('is_starred', '0'),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->add(
                $this->blueprint->submit(
                    $this->hasValue('id') ? 'edit-message' : 'new-message',
                    ['uk-button', 'uk-button-primary', 'uk-form-width-medium'],
                    'Send'
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}
