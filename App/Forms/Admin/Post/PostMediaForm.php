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

class PostMediaForm extends ClientFormBuilder implements ClientFormBuilderInterface
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
                $this->blueprint->textarea('summary', ['uk-textarea', 'uk-form-blank', 'uk-border-bottom'], 'summary_markdown', 'Your Summary?'),
                $this->hasValue('summary'),
                $this->blueprint->settings(false, null, false, null, true, null, 'This summary is a much shorter version of the main article content. Perfect for displaing a snippet of the full content from your homepage.<br>The content here is auto-generated. However writing your own summary will take precedent over the auto-generated article.')
            )
            ->add(
                $this->blueprint->select('categories', ['uk-select', 'uk-form-blank', 'uk-border-bottom'], null, null, true), 
                $this->blueprint->choices(
                    ['public', 'private', 'protected'],
                    '',
                    $this
                ),
                $this->blueprint->settings(false, null, false, null, true, null, 'Categories')
            )
            ->add(
                $this->blueprint->select('tags', ['uk-select', 'uk-form-blank', 'uk-border-bottom'], null, null, true), 
                $this->blueprint->choices(
                    ['public', 'private', 'protected'],
                    '',
                    $this
                ),
                $this->blueprint->settings(false, null, false, null, true, null, 'Tags<br/>these can be created within the tags section. Each articn can have multiple tags.')
            )

            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>'], false, false);
    }
}
