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

use App\Model\TagModel;
use App\Entity\TagEntity;
use App\Schema\TagSchema;
use MagmaCore\Base\Access;
use App\Event\TagActionEvent;
use App\DataColumns\TagColumn;
use App\Commander\TagCommander;
use App\Forms\Admin\Tag\TagForm;

class TagController extends \MagmaCore\Administrator\Controller\AdminController
{

    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);

        $this->addDefinitions(
            [
                'repository' => TagModel::class,
                'column' => TagColumn::class,
                'commander' => TagCommander::class,
                'entity' => TagEntity::class,
                'tagForm' => TagForm::class,
                'schema' => TagSchema::class,
                'rawSchema' => TagSchema::class,
                'actionEvent' => TagActionEvent::class
            ]
        );
    }

    protected function indexAction()
    {

        $this->indexAction
            ?->setAccess($this, Access::CAN_VIEW)
            ?->execute($this, NULL, NULL, TagSchema::class, __METHOD__)
            ?->render()
            ?->with(
                [
                ]
            )
            ?->table()
            ?->end();
    }

    protected function newAction()
    {
        $this->newAction
            ->execute($this, TagEntity::class, TagActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form($this->tagForm)
            ->end();
    }

    protected function editAction(): void
    {
        $this->editAction
            ->setAccess($this, Access::CAN_EDIT)
            ->execute($this, TagEntity::class, TagActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with(
                [
                    'tag' => $this->toArray($this->findOr404())
                ]
            )
            ->form($this->tagForm)
            ->end();
    }

    /**
     * Route which puts the item within the trash. This is only for supported models
     * and is effectively changing the deleted_at column to 1. All datatable queries 
     * deleted_at column should be set to 0. this will prevent any trash items 
     * from showing up in the main table
     *
     * @return void
     */
    protected function trashAction()
    {
        $this->ifCanTrashAction
            ->setAccess($this, Access::CAN_TRASH)
            ->execute($this, NULL, TagActionEvent::class, NULL, __METHOD__, [], [], TagSchema::class)
            ->endAfterExecution();
    }

    /**
     * As trashing an item changes the deleted_at column to 1 we can reset that to 0
     * for individual items.
     *
     * @return void
     */
    protected function untrashAction()
    {
        $this->changeStatusAction
        ->setAccess($this, Access::CAN_UNTRASH)
        ->execute($this, TagEntity::class, TagActionEvent::class, NULL, __METHOD__,[], [],['deleted_at' => 0])
        ->endAfterExecution();

    }

    protected function hardDeleteAction()
    {
        $this->deleteAction
            ->setAccess($this, Access::CAN_DELETE)
            ->execute($this, NULL, TagActionEvent::class, NULL, __METHOD__)
            ->endAfterExecution();

    }

}

