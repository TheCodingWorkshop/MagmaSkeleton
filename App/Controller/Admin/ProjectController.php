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
use App\Model\ProjectModel;
use App\Entity\ProjectEntity;
use App\Schema\ProjectSchema;
use App\Event\ProjectActionEvent;
use App\DataColumns\ProjectColumn;
use App\Commander\ProjectCommander;
use App\Forms\Admin\Project\ProjectForm;
use MagmaCore\Base\Traits\ControllerCommonTrait;
use MagmaCore\Administrator\Model\ControllerSessionBackupModel;

class ProjectController extends \MagmaCore\Administrator\Controller\AdminController
{

    use ControllerCommonTrait;

    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);

        $this->addDefinitions(
            [
                'repository' => ProjectModel::class,
                'column' => ProjectColumn::class,
                'commander' => ProjectCommander::class,
                'entity' => ProjectEntity::class,
                'projectForm' => ProjectForm::class,
                'schema' => ProjectSchema::class,
                'rawSchema' => ProjectSchema::class

            ]
        );
    }

    public function schemaAsString()
    {
        return ProjectSchema::class;
    }

    protected function indexAction()
    {
        $this->indexAction
        ?->setAccess($this, Access::CAN_VIEW)
        ?->execute($this, NULL, NULL, ProjectSchema::class, __METHOD__)
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
            ->execute($this, ProjectEntity::class, ProjectActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form($this->projectForm)
            ->end();
    }

    protected function editAction(): void
    {
        $this->editAction
            ->setAccess($this, Access::CAN_EDIT)
            ->execute($this, ProjectEntity::class, ProjectActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with(
                [
                    'project' => $this->toArray($this->findOr404())
                ]
            )
            ->form($this->projectForm)
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
            ->execute($this, NULL, ProjectActionEvent::class, NULL, __METHOD__, [], [], ProjectSchema::class)
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
        ->execute($this, ProjectEntity::class, ProjectActionEvent::class, NULL, __METHOD__,[], [],['deleted_at' => 0])
        ->endAfterExecution();

    }


    protected function hardDeleteAction()
    {
        $this->deleteAction
            ->setAccess($this, Access::CAN_DELETE)
            ->execute($this, NULL, ProjectActionEvent::class, NULL, __METHOD__)
            ->endAfterExecution();

    }

    /**
     * Bulk action route
     *
     * @return void
     */
    public function bulkAction()
    {
        $this->chooseBulkAction($this, ProjectActionEvent::class);
    }

    /**
     * @return void
     */
    protected function activeAction()
    {
        $this->changeStatusAction
        ->setAccess($this, Access::CAN_UNTRASH)
        ->execute($this, ProjectEntity::class, ProjectActionEvent::class, NULL, __METHOD__,[], [],['status' => 'active'])
        ->endAfterExecution();

    }

    /**
     * @return void
     */
    protected function deactiveAction()
    {
        $this->changeStatusAction
        ->setAccess($this, Access::CAN_UNTRASH)
        ->execute($this, ProjectEntity::class, ProjectActionEvent::class, NULL, __METHOD__,[], [],['status' => 'deactive'])
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
            ->execute($this, NULL, ProjectActionEvent::class, NULL, __METHOD__, [], [], ControllerSessionBackupModel::class)
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