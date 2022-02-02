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

namespace App\Controller\Admin;

use App\Model\PostModel;
use App\Entity\PostEntity;
use App\Schema\PostSchema;
use MagmaCore\Base\Access;
use App\Event\PostActionEvent;
use App\DataColumns\PostColumn;
use App\Commander\PostCommander;
use App\Forms\Admin\Post\PostForm;
use App\Forms\Admin\Post\PostMetaForm;
use App\Forms\Admin\Post\PostMediaForm;
use App\Forms\Admin\Post\PostSidebarForm;
use MagmaCore\Administrator\Controller\AdminController;

class PostController extends AdminController
{

    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);
        
        $this->addDefinitions(
            [
                'repository' => PostModel::class,
                'entity' => PostEntity::class,
                'column' => PostColumn::class,
                'commander' => PostCommander::class,
                'postForm' => PostForm::class,
                'postMetaForm' => PostMetaForm::class,
                'postMediaForm' => PostMediaForm::class,
                'postSidebarForm' => PostSidebarForm::class
            ]
        );
    }

    /**
     * Returns a 404 error page if the data is not present within the database
     * else return the requested object
     *
     * @return mixed
     */
    public function findOr404(): mixed
    {
        if (isset($this)) {
            return $this->repository->getRepo()
                ->findAndReturn($this->thisRouteID())
                ->or404();
        }
    }

    /**
     * Return an array of template context which is accessible from any route within this controller
     * @return array
     */
    protected function controllerViewGlobals(): array
    {
        return [
        ];
    }

    protected function indexAction()
    {
        $this->indexAction
            ?->setAccess($this, Access::CAN_VIEW)
            ?->execute($this, NULL, NULL, PostSchema::class, __METHOD__)
            ?->render()
            ?->with(
                [

                ]
            )
            ?->table()
            ?->end();
    }
    
    /**
     * Submit post form data
     *
     * @return void
     */
    protected function newAction()
    {
        $this->newAction
            ->setAccess($this, Access::CAN_ADD)
            ->execute($this, PostEntity::class, PostActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with(
                [
                    'form_meta' => $this->postMetaForm->createForm('', null, $this),
                    'form_media' => $this->postMediaForm->createForm('', null, $this),
                    'form_sidebar' => $this->postSidebarForm->createForm('', null, $this)
                ]
            )
            ->form($this->postForm)
            ->end();
    }

    protected function editAction()
    {
        $data = !empty($this->thisRouteID()) ? $this->findOr404() : null;
        $this->editAction
            ->setAccess($this, Access::CAN_EDIT)
            ->execute($this, PostEntity::class, PostActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with(
                [
                    'form_meta' => $this->postMetaForm->createForm('', $data, $this),
                    'form_media' => $this->postMediaForm->createForm('', $data, $this),
                    'form_sidebar' => $this->postSidebarForm->createForm('', $data, $this),
                    'post' => $this->toArray($this->findOr404())
                ]
            )
            ->form($this->postForm)
            ->end();
    }

}

