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
use MagmaCore\Base\Traits\ControllerCommonTrait;
use MagmaCore\Administrator\Model\ControllerSessionBackupModel;

class LeaveController extends \MagmaCore\Administrator\Controller\AdminController
{

    use ControllerCommonTrait;

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
                'rawSchema' => LeaveTypeSchema::class

            ]
        );
    }

    public function schemaAsString()
    {
        return LeaveTypeColumn::class;
    }

    protected function indexAction()
    {
        $this->indexAction
        //?->setAccess($this, Access::CAN_VIEW)
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
            //?->setAccess($this, Access::CAN_VIEW)
            ->execute($this, LeaveTypeEntity::class, LeaveTypeActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form($this->leaveForm)
            ->end();
    }

    protected function editAction(): void
    {
        $this->editAction
            //->setAccess($this, Access::CAN_EDIT)
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
     * settings page
     *
     * @return Response
     */
    protected function settingsAction()
    {
        $sessionData = $this->getSession()->get($this->thisRouteController() . '_settings');
        $this->sessionUpdateAction
            //->setAccess($this, Access::CAN_MANANGE_SETTINGS)
            ->execute($this, NULL, LeaveTypeActionEvent::class, NULL, __METHOD__, [], [], ControllerSessionBackupModel::class)
            ->render()
            ->with(
                [
                    'session_data' => $sessionData,
                    'page_title' => 'Leave Type Settings',
                    'last_updated' => $this->controllerSessionBackupModel
                        ->getRepo()
                        ->findObjectBy(['controller' => $this->thisRouteController() . '_settings'], ['created_at'])->created_at
                ]
            )
            ->form($this->controllerSettingsForm, null, $this->toObject($sessionData))
            ->end();
    }

}