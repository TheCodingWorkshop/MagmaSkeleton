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

use App\Commander\SettingCommander;
use App\DataColumns\SettingColumn;
use App\Entity\SettingEntity;
use App\Event\SettingActionEvent;
use App\Forms\Admin\Settings\ApplicationSettingForm;
use App\Forms\Admin\Settings\AvatarSettingForm;
use App\Forms\Admin\Settings\BrandingSettingForm;
use App\Forms\Admin\Settings\DatetimeSettingForm;
use App\Forms\Admin\Settings\DefaultSettingForm;
use App\Forms\Admin\Settings\ExtensionSettingForm;
use App\Forms\Admin\Settings\FormattingSettingForm;
use App\Forms\Admin\Settings\GeneralSettingForm;
use App\Forms\Admin\Settings\LocalisationSettingForm;
use App\Forms\Admin\Settings\PurgeSettingForm;
use App\Forms\Admin\Settings\SecuritySettingForm;
use App\Forms\Admin\Settings\ToolsSettingForm;
use App\Model\SettingModel;
use MagmaCore\Base\Domain\Actions\ConfigAction;
use MagmaCore\Base\Domain\Actions\PurgeAction;
use MagmaCore\Base\Exception\BaseException;
use MagmaCore\Base\Exception\BaseInvalidArgumentException;
use MagmaCore\Settings\Settings;

class SettingController extends AdminController
{

    /**
     * Extends the base constructor method. Which gives us access to all the base
     * methods implemented within the base controller class.
     * Class dependency can be loaded within the constructor by calling the
     * container method and passing in an associative array of dependency to use within
     * the class
     *
     * @param array $routeParams
     * @return void
     * @throws BaseInvalidArgumentException
     */
    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);
        /**
         * Dependencies are defined within a associative array like example below
         * [ PermissionModel => \App\Model\EventModel::class ]. Where the key becomes the
         * property for the PermissionModel object like so $this->eventModel->getRepo();
         */
        $this->addDefinitions(
            [
                'repository' => SettingModel::class,
                'settingsRepository' => Settings::class,
                'column' => SettingColumn::class,
                'commander' => SettingCommander::class,
                'configAction' => ConfigAction::class,
                'purgeAction' => PurgeAction::class,
                'applicationSettingForm' => ApplicationSettingForm::class,
                'generalSettingForm' => GeneralSettingForm::class,
                'formattingSettingForm' => FormattingSettingForm::class,
                'avatarSettingForm' => AvatarSettingForm::class,
                'defaultSettingForm' => DefaultSettingForm::class,
                'datetimeSettingForm' => DatetimeSettingForm::class,
                'securitySettingForm' => SecuritySettingForm::class,
                'purgeSettingForm' => PurgeSettingForm::class,
                'toolsSettingForm' => ToolsSettingForm::class,
                'localisationSettingForm' => LocalisationSettingForm::class,
                'brandingSettingForm' => BrandingSettingForm::class,
                'extensionSettingForm' => ExtensionSettingForm::class,

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
        return $this->repository->getRepo()
            ->findAndReturn($this->thisRouteID())
            ->or404();
    }

    protected function indexAction()
    {
        $this->render('admin/setting/index.html');
    }


    protected function generalAction()
    {
        $this->configAction
            ->execute($this, SettingEntity::class, SettingActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with([
            ])
            ->form($this->generalSettingForm)
            ->end();
    }

    protected function securityAction()
    {
        $this->configAction
            ->execute($this, SettingEntity::class, SettingActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with([])
            ->form($this->securitySettingForm)
            ->end();
    }

    protected function purgeAction()
    {
        $this->purgeAction
            ->execute($this, SettingEntity::class, SettingActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with([
                'template_files' => scandir(TEMPLATE_CACHE)
            ])
            ->form($this->purgeSettingForm)
            ->end();
    }

    protected function toolsAction()
    {
        $this->configAction
            ->execute($this, SettingEntity::class, SettingActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with([])
            ->form($this->toolsSettingForm)
            ->end();
    }

    protected function localisationAction()
    {
        $this->configAction
            ->execute($this, SettingEntity::class, SettingActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with([])
            ->form($this->localisationSettingForm)
            ->end();
    }

    protected function brandingAction()
    {
        $this->configAction
            ->execute($this, SettingEntity::class, SettingActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with([])
            ->form($this->brandingSettingForm)
            ->end();
    }

    protected function extensionAction()
    {
        $this->configAction
            ->execute($this, SettingEntity::class, SettingActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with([])
            ->form($this->extensionSettingForm)
            ->end();
    }


    protected function applicationAction()
    {
        $this->configAction
            ->execute($this, SettingEntity::class, SettingActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form($this->applicationSettingForm)
            ->end();
    }

}
