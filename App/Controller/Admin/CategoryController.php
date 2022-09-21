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

use MagmaCore\Base\Access;
use App\Model\CategoryModel;
use App\Entity\CategoryEntity;
use App\Schema\CategorySchema;
use App\Event\CategoryActionEvent;
use App\DataColumns\CategoryColumn;
use App\Commander\CategoryCommander;
use App\Forms\Admin\Category\CategoryForm;

class CategoryController extends \MagmaCore\Administrator\Controller\AdminController
{

    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);

        $this->addDefinitions(
            [
                'repository' => CategoryModel::class,
                'column' => CategoryColumn::class,
                'commander' => CategoryCommander::class,
                'entity' => CategoryEntity::class,
                'categoryForm' => CategoryForm::class,
                'schema' => CategorySchema::class, /* outputs the schema object */
                'rawSchema' => CategorySchema::class, /* outputs the qualified namespace */
                'actionEvent' => CategoryActionEvent::class /* outputs the qualified namespace */
            ]
        );
    }

    protected function indexAction()
    {        
         
        $this->indexAction
            ?->setAccess($this, Access::CAN_VIEW)
            ?->execute($this, NULL, NULL, CategorySchema::class, __METHOD__)
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
            ?->setAccess($this, Access::CAN_VIEW)
            ?->execute(controller:$this, entity:CategoryEntity::class, event:CategoryActionEvent::class, method:__METHOD__)
            //->execute($this, CategoryEntity::class, CategoryActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form($this->categoryForm)
            ->end();
    }

    protected function editAction(): void
    {
        $this->editAction
            ->setAccess($this, Access::CAN_EDIT)
            ->execute($this, CategoryEntity::class, CategoryActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with(
                [
                    'cat' => $this->toArray($this->findOr404())
                ]
            )
            ->form($this->categoryForm)
            ->end();
    }

    protected function copyAction()
    {
        $this->copyAction 
            ->setAccess($this, Access::CAN_COPY)
            ->execute($this, CategoryEntity::class, CategoryActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form()
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
            ->execute($this, NULL, CategoryActionEvent::class, NULL, __METHOD__, [], [], CategorySchema::class)
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
        ->execute($this, CategoryEntity::class, CategoryActionEvent::class, NULL, __METHOD__,[], [],['deleted_at' => 0])
        ->endAfterExecution();

    }

    // protected function hardDeleteAction()
    // {
    //     $this->deleteAction
    //         ->setAccess($this, Access::CAN_DELETE)
    //         ->execute($this, NULL, CategoryActionEvent::class, NULL, __METHOD__)
    //         ->endAfterExecution();

    // }


}

