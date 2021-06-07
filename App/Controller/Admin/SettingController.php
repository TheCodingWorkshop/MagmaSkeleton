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

use App\Entity\SettingEntity;
use App\Event\SettingActionEvent;

class SettingController extends AdminController
{

    /**
     * Extends the base constructor method. Which gives us access to all the base 
     * methods inplemented within the base controller class.
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
                'repository' => \App\Model\SettingModel::class,
                'settingsRepository' => \MagmaCore\Settings\Settings::class,
                'column' => \App\DataColumns\SettingColumn::class,
                'commander' => \App\Commander\SettingCommander::class,
                'configAction' => \MagmaCore\Base\Domain\Actions\ConfigAction::class,
                'purgeAction' => \MagmaCore\Base\Domain\Actions\PurgeAction::class,
                'applicationSettingForm' => \App\Forms\Admin\Settings\ApplicationSettingForm::class,
                'generalSettingForm' => \App\Forms\Admin\Settings\GeneralSettingForm::class,
                'formattingSettingForm' => \App\Forms\Admin\Settings\FormattingSettingForm::class,
                'avatarSettingForm' => \App\Forms\Admin\Settings\AvatarSettingForm::class,
                'defaultSettingForm' => \App\Forms\Admin\Settings\DefaultSettingForm::class,

                'datetimeSettingForm' => \App\Forms\Admin\Settings\DatetimeSettingForm::class,
                'securitySettingForm' => \App\Forms\Admin\Settings\SecuritySettingForm::class,
                'purgeSettingForm' => \App\Forms\Admin\Settings\PurgeSettingForm::class,
                'toolsSettingForm' => \App\Forms\Admin\Settings\ToolsSettingForm::class,
                'localisationSettingForm' => \App\Forms\Admin\Settings\LocalisationSettingForm::class,
                'brandingSettingForm' => \App\Forms\Admin\Settings\BrandingSettingForm::class,
                'extensionSettingForm' => \App\Forms\Admin\Settings\ExtensionSettingForm::class,

            ]
        );
        /** Initialize database with table settings */
        $this->initializeControllerSettings(
            'setting',
            $this->column
        );

    }

    /**
     * Returns a 404 error page if the data is not present within the database
     * else return the requested object
     *
     * @return mixed
     */
    public function findOr404()
    {
        $repository = $this->repository->getRepo()
            ->findAndReturn($this->thisRouteID())
            ->or404();

        return $repository;
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
                        'form_formatting' => $this->formattingSettingForm->createForm(
                            $this->getRoute('general', $this), 
                            null
                        ),
                        'form_avatar' => $this->avatarSettingForm->createForm(
                            $this->getRoute('avatar', $this)
                        ),
                        'form_default' => $this->defaultSettingForm->createForm(
                            $this->getRoute('default', $this)
                        ),
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
