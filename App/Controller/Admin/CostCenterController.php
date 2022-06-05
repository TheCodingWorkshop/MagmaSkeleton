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
use App\Model\CostCenterModel;
use App\Entity\CostCenterEntity;
use App\Schema\CostCenterSchema;
use App\Event\CostCenterActionEvent;
use App\DataColumns\CostCenterColumn;
use App\Commander\CostCenterCommander;
use App\Forms\Admin\CostCenter\CostCenterForm;
use MagmaCore\Base\Traits\ControllerCommonTrait;
use MagmaCore\Administrator\Model\ControllerSessionBackupModel;

class CostCenterController extends \MagmaCore\Administrator\Controller\AdminController
{

    use ControllerCommonTrait;

    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);

        $this->addDefinitions(
            [
                'repository' => CostCenterModel::class,
                'column' => CostCenterColumn::class,
                'commander' => CostCenterCommander::class,
                'entity' => CostCenterEntity::class,
                'costCenterForm' => CostCenterForm::class,
                'schema' => CostCenterSchema::class,
                'rawSchema' => CostCenterSchema::class

            ]
        );
    }

    public function schemaAsString()
    {
        return CostCenterSchema::class;
    }

    protected function indexAction()
    {
        $this->indexAction
        //?->setAccess($this, Access::CAN_VIEW)
        ?->execute($this, NULL, NULL, CostCenterSchema::class, __METHOD__)
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
            //?->setAccess($this, Access::CAN_ADD)
            ->execute($this, CostCenterEntity::class, CostCenterActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form($this->costCenterForm)
            ->end();
    }

    protected function editAction(): void
    {
        $this->editAction
            ->setAccess($this, Access::CAN_EDIT)
            ->execute($this, CostCenterEntity::class, CostCenterActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with(
                [
                    'cost_center' => $this->toArray($this->findOr404())
                ]
            )
            ->form($this->costCenterForm)
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
            ->execute($this, NULL, CostCenterActionEvent::class, NULL, __METHOD__, [], [], CostCenterSchema::class)
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
        ->execute($this, CostCenterEntyity::class, CostCenterActionEvent::class, NULL, __METHOD__,[], [],['deleted_at' => 0])
        ->endAfterExecution();

    }


    protected function hardDeleteAction()
    {
        $this->deleteAction
            ->setAccess($this, Access::CAN_DELETE)
            ->execute($this, NULL, CostCenterActionEvent::class, NULL, __METHOD__)
            ->endAfterExecution();

    }

    /**
     * Bulk action route
     *
     * @return void
     */
    public function bulkAction()
    {
        $this->chooseBulkAction($this, CostCenterActionEvent::class);
    }

    /**
     * @return void
     */
    protected function activeAction()
    {
        $this->changeStatusAction
        ->setAccess($this, Access::CAN_UNTRASH)
        ->execute($this, CostCenterEntyity::class, CostCenterActionEvent::class, NULL, __METHOD__,[], [],['status' => 'active'])
        ->endAfterExecution();

    }

    /**
     * @return void
     */
    protected function deactiveAction()
    {
        $this->changeStatusAction
        ->setAccess($this, Access::CAN_UNTRASH)
        ->execute($this, CostCenterEntyity::class, CostCenterActionEvent::class, NULL, __METHOD__,[], [],['status' => 'deactive'])
        ->endAfterExecution();

    }


    /**
     * settings page
     *
     * @return Response
     */
    protected function settingsAction()
    {
        $sessionData = $this->getSession()->get($this->thisRouteController() . '_settings');
        $this->sessionUpdateAction
            ->setAccess($this, Access::CAN_MANANGE_SETTINGS)
            ->execute($this, NULL, CostCenterActionEvent::class, NULL, __METHOD__, [], [], ControllerSessionBackupModel::class)
            ->render()
            ->with(
                [
                    'session_data' => $sessionData,
                    'page_title' => ucwords($this->thisRouteController()) . ' Settings',
                    'last_updated' => $this->controllerSessionBackupModel
                        ->getRepo()
                        ->findObjectBy(['controller' => $this->thisRouteController() . '_settings'], ['created_at'])->created_at
                ]
            )
            ->form($this->controllerSettingsForm, null, $this->toObject($sessionData))
            ->end();
    }

}