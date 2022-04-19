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

class PostMetaForm extends ClientFormBuilder implements ClientFormBuilderInterface
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
        return $this->form(['action' => $action, 'class' => ['uk-form-stacked'], "id" => "postMetaForm"])
            ->addRepository($dataRepository)
            ->add(
                $this->blueprint->select('format', ['uk-select', 'uk-form-blank', 'uk-border-bottom', 'uk-height-medium'], null, null, true), 
                $this->blueprint->choices(
                    ['article', 'aside', 'image', 'video', 'audio', 'link', 'quote', 'gallery'],
                    'article',
                    $this
                ),
                $this->blueprint->settings(false, null, false, null, true, null, 'Format<br/>Formts allows us to view the content in many different ways specified within the options. For example if your article is represented by a video. Then its best to choose the video format, likewise for audio or a post consist of a gallery.')
            )
            // ->add(
            //     $this->blueprint->radio('format', [], $this->hasValue('format')),
            //     $this->blueprint->choices(
            //         [
            //             'article' => 'Article', 
            //             'image' => 'Image', 
            //             'video' => 'Video', 
            //             'audio' => 'Audio', 
            //             'chat' => 'Chat', 
            //             'gallery' => 'Gallery', 
            //             'link' => 'Link', 
            //             'quote' => 'Quote',
            //         ], 
            //         $dataRepository->format ?? 'article'),
            //     $this->blueprint->settings(false, null, true, null, true)
            // )

            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>'], false, false);
    }
}
