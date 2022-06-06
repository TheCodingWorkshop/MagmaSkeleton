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
use App\Model\TimesheetModel;
use App\Entity\TimesheetEntity;
use App\Schema\TimesheetSchema;
use App\Event\TimesheetActionEvent;
use App\DataColumns\TimesheetColumn;
use App\Commander\TimesheetCommander;
use App\Forms\Admin\Timesheet\TimesheetForm;

class TimesheetController extends \MagmaCore\Administrator\Controller\AdminController
{

    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);
        $this->addDefinitions(
            [
                'repository' => TimesheetModel::class,
                'column' => TimesheetColumn::class,
                'commander' => TimesheetCommander::class,
                'entity' => TimesheetEntity::class,
                'timesheetForm' => TimesheetForm::class,
                'schema' => TimesheetSchema::class,
                'rawSchema' => TimesheetSchema::class,
                'actionEvent' => TimesheetActionEvent::class

            ]
        );
    }

    protected function indexAction()
    {
        $this->indexAction
        ?->setAccess($this, Access::CAN_VIEW)
        ?->execute($this, NULL, NULL, TimesheetSchema::class, __METHOD__)
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
            ->execute($this, TimesheetEntity::class, TimesheetActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form($this->timesheetForm)
            ->end();
    }

    protected function editAction(): void
    {
        $this->editAction
            ->setAccess($this, Access::CAN_EDIT)
            ->execute($this, TimesheetEntity::class, TimesheetActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with(
                [
                    'timesheet' => $this->toArray($this->findOr404())
                ]
            )
            ->form($this->timesheetForm)
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
            ->execute($this, NULL, TimesheetActionEvent::class, NULL, __METHOD__, [], [], TimesheetSchema::class)
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
        ->execute($this, TimesheetEntity::class, TimesheetActionEvent::class, NULL, __METHOD__,[], [],['deleted_at' => 0])
        ->endAfterExecution();

    }

    protected function hardDeleteAction()
    {
        $this->deleteAction
            ->setAccess($this, Access::CAN_DELETE)
            ->execute($this, NULL, TimesheetActionEvent::class, NULL, __METHOD__)
            ->endAfterExecution();

    }

    /**
     * @return void
     */
    protected function activeAction()
    {
        $this->changeStatusAction
        ->setAccess($this, Access::CAN_UNTRASH)
        ->execute($this, TimesheetEntity::class, TimesheetActionEvent::class, NULL, __METHOD__,[], [],['status' => 'active'])
        ->endAfterExecution();

    }

    /**
     * @return void
     */
    protected function deactiveAction()
    {
        $this->changeStatusAction
        ->setAccess($this, Access::CAN_UNTRASH)
        ->execute($this, TimesheetEntity::class, TimesheetActionEvent::class, NULL, __METHOD__,[], [],['status' => 'deactive'])
        ->endAfterExecution();

    }


}