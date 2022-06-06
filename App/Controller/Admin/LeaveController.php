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
use App\Model\LeaveTypeModel;
use App\Entity\LeaveTypeEntity;
use App\Schema\LeaveTypeSchema;
use App\Event\LeaveTypeActionEvent;
use App\DataColumns\LeaveTypeColumn;
use App\Commander\LeaveTypeCommander;
use App\Forms\Admin\Leaves\LeaveForm;

class LeaveController extends \MagmaCore\Administrator\Controller\AdminController
{

    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);

        $this->addDefinitions(
            [
                'repository' => LeaveTypeModel::class,
                'column' => LeaveTypeColumn::class,
                'commander' => LeaveTypeCommander::class,
                'entity' => LeaveTypeEntity::class,
                'leaveForm' => LeaveForm::class,
                'schema' => LeaveTypeSchema::class,
                'rawSchema' => LeaveTypeSchema::class,
                'actionEvent' => LeaveTypeActionEvent::class

            ]
        );
    }

    protected function indexAction()
    {
        $this->indexAction
        ->setAccess($this, Access::CAN_VIEW)
        ?->execute($this, NULL, NULL, LeaveTypeSchema::class, __METHOD__)
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
            ->setAccess($this, Access::CAN_VIEW)
            ->execute($this, LeaveTypeEntity::class, LeaveTypeActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form($this->leaveForm)
            ->end();
    }

    protected function editAction(): void
    {
        $this->editAction
            ->setAccess($this, Access::CAN_EDIT)
            ->execute($this, LeaveTypeEntity::class, LeaveTypeActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with(
                [
                    'leave' => $this->toArray($this->findOr404())
                ]
            )
            ->form($this->leaveForm)
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
            ->execute($this, NULL, LeaveTypeActionEvent::class, NULL, __METHOD__, [], [], LeaveTypeSchema::class)
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
        ->execute($this, LeaveTypeEntity::class, LeaveTypeActionEvent::class, NULL, __METHOD__,[], [],['deleted_at' => 0])
        ->endAfterExecution();

    }


    protected function hardDeleteAction()
    {
        $this->deleteAction
            ->setAccess($this, Access::CAN_DELETE)
            ->execute($this, NULL, LeaveTypeActionEvent::class, NULL, __METHOD__)
            ->endAfterExecution();

    }


}