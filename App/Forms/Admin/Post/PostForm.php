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
        return $this->form(['action' => $action, 'class' => ['uk-form-stacked'], "id" => "postForm"])
            ->addRepository($dataRepository)
            ->add(
                $this->blueprint->text('title', ['uk-form-blank', 'uk-border-bottom'], $this->hasValue('title'), false, 'Title'),
                NULL,
                $this->blueprint->settings(false, null, false, null, true)

            )
            ->add(
                $this->blueprint->text('slug', ['uk-form-blank', 'uk-border-bottom'], $this->hasValue('slug'), false, 'Slug'),
                NULL,
                $this->blueprint->settings(false, null, false, null, true)

            )
            ->add(
                $this->blueprint->text('url', ['uk-form-blank', 'uk-border-bottom'], $this->hasValue('url'), false, 'Url'),
                NULL,
                $this->blueprint->settings(false, null, false, null, true, null, 'Your post url will be auto-generated')

            )


            ->add(
                $this->blueprint->textarea('article', ['uk-textarea', 'uk-form-blank', 'uk-border-bottom', 'uk-height-medium', 'uk-text-wrap'], 'markdown_editor', 'What\'s your article?'),
                $this->hasValue('article'),
                $this->blueprint->settings(false, null, false, null, true)
            )

            ->add(
                $this->blueprint->submit(
                    $this->hasValue('id') ? 'edit-post' : 'new-post',
                    ['uk-button', 'uk-button-primary', 'uk-form-width-medium'],
                    'Post'
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>'], false, true);
    }
}
