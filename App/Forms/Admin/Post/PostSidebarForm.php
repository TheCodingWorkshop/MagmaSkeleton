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

namespace App\Forms\Admin\Post;

use Exception;
use App\Model\PostModel;
use MagmaCore\IconLibrary;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\FormBuilderBlueprint;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\FormBuilderBlueprintInterface;

class PostSidebarForm extends ClientFormBuilder implements ClientFormBuilderInterface
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
        return $this->form(['action' => $action, 'class' => ['uk-form-stacked'], "id" => "postMediaForm"])
            ->addRepository($dataRepository)
            ->add(
                $this->blueprint->select(
                    'status[]', 
                    ['uk-select', 'uk-form-blank', 'uk-border-bottom'], 
                    null, 
                    null, 
                    false
                ), 
                $this->blueprint->choices(
                    ['draft', 'published', 'schedule'],
                    (string)$this->hasValue('status'),
                    $this
                ),
                $this->blueprint->settings(false, null, false, null, true, null, 'Post Status')
            )
            ->add(
                $this->blueprint->select(
                    'visible[]', 
                    ['uk-select', 'uk-form-blank', 'uk-border-bottom'], 
                    null, 
                    null, 
                    false
                ), 
                $this->blueprint->choices(
                    ['public', 'private', 'protected'],
                    (string)$this->hasValue('visible'),
                    $this
                ),
                $this->blueprint->settings(false, null, false, null, true, null, 'Post Visibility')
            )
            ->add(
                $this->blueprint->upload('attachment', ['uk-button', 'uk-button-small', 'uk-button-default'], '', true),
                '<span class="ion-28">' . IconLibrary::getIcon('camera', 1.2) . '</span>',
                $this->blueprint->settings(false, null, false, null, true, null, 'Featured Image')
            )

            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>'], false, false);
    }
}
