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
use App\Model\HolidayModel;
use App\Entity\HolidayEntity;
use App\Schema\HolidaySchema;
use App\Event\HolidayActionEvent;
use App\DataColumns\HolidayColumn;
use App\Commander\HolidayCommander;
use App\Forms\Admin\Holidays\HolidayForm;
use MagmaCore\Base\Traits\ControllerCommonTrait;
use MagmaCore\Administrator\Model\ControllerSessionBackupModel;

class HolidayController extends \MagmaCore\Administrator\Controller\AdminController
{

    use ControllerCommonTrait;

    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);

        $this->addDefinitions(
            [
                'repository' => HolidayModel::class,
                'column' => HolidayColumn::class,
                'commander' => HolidayCommander::class,
                'entity' => HolidayEntity::class,
                'holidayForm' => HolidayForm::class,
                'schema' => HolidaySchema::class,
                'rawSchema' => HolidaySchema::class

            ]
        );
    }

    public function schemaAsString()
    {
        return HolidaySchema::class;
    }

    protected function indexAction()
    {
        // $holidays = $this->repository->calculateBankHolidays(2023);
        // var_dump($holidays);
        // die;
        $this->indexAction
        ?->setAccess($this, Access::CAN_VIEW)
        ?->execute($this, NULL, NULL, HolidaySchema::class, __METHOD__)
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
            ->execute($this, HolidayEntity::class, HolidayActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form($this->holidayForm)
            ->end();
    }

    protected function editAction(): void
    {
        $this->editAction
            ->setAccess($this, Access::CAN_EDIT)
            ->execute($this, HolidayEntity::class, HolidayActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with(
                [
                    'holiday' => $this->toArray($this->findOr404())
                ]
            )
            ->form($this->holidayForm)
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
            ->setAccess($this, Access::CAN_MANANGE_SETTINGS)
            ->execute($this, NULL, HolidayActionEvent::class, NULL, __METHOD__, [], [], ControllerSessionBackupModel::class)
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