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

use App\Commander\UserCommander;
use App\DataColumns\UserColumn;
use App\Entity\UserEntity;
use App\Event\UserActionEvent;
use App\Forms\Admin\Settings\TableSettingsForm;
use App\Forms\Admin\User\SettingsForm;
use App\Forms\Admin\User\UserForm;
use App\Forms\Admin\User\UserPreferencesForm;
use App\Model\RoleModel as RM;
use App\Model\RolePermissionModel;
use App\Model\UserMetaDataModel;
use App\Model\UserModel as UM;
use App\Model\UserPreferenceModel;
use App\Relationships\UserRelationship;
use App\Schema\UserSchema;
use MagmaCore\Base\Exception\BaseException;
use MagmaCore\Base\Exception\BaseInvalidArgumentException;
use MagmaCore\DataObjectLayer\DataLayerTrait;
use MagmaCore\Utility\Yaml;
use Exception;

class UserController extends AdminController
{

    use DataLayerTrait;

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
         * [ userModel => \App\Model\UserModel::class ]. Where the key becomes the
         * property for the userModel object like so $this->userModel->getRepo();
         */
        $this->addDefinitions(
            [
                'repository' => UM::class,
                'commander' => UserCommander::class,
                'rolePermission' => RolePermissionModel::class,
                'userMeta' => UserMetaDataModel::class,
                'entity' => UserEntity::class,
                'column' => UserColumn::class,
                'formUser' => UserForm::class,
                'userPreferenceRepo' => UserPreferenceModel::class,
                'userPreferencesForm' => UserPreferencesForm::class,
                'formSettings' => SettingsForm::class,
                'tableSettings' => TableSettingsForm::class,
                'relationship' => UserRelationship::class
            ]
        );
        /** Initialize database with table settings */
    }

    /**
     * Returns a 404 error page if the data is not present within the database
     * else return the requested object
     *
     * @return mixed
     */
    public function findOr404(): mixed
    {
        if (isset($this)) {
            return $this->repository->getRepo()
                ->findAndReturn($this->thisRouteID())
                ->or404();
        }
    }

    /**
     * Entry method which is hit on request. This method should be implement within
     * all sub controller class as a default landing point when a request is
     * made.
     */
    protected function indexAction()
    {
        $this->indexAction
            ->execute($this, NULL, NULL, UserSchema::class, __METHOD__)
            ->mergeRelationship(function ($repository, $relationship) {
                return $relationship->type()
                    ->manyToMany(UM::REL_FIELDS, RM::REL_FIELDS)->where(UM::REL_ASSOC)
                    ->and(RM::REL_ASSOC)
                    ->all();
            })
            ->render()
            ->with(
                [
                    UM::COLUMN_STATUS
                ])
            ->table()
            ->end();
    }

    /**
     * The show action request displays singular information about a user. This is a
     * read only request. Information here cannot be edited.
     */
    protected function showAction()
    {
        $this->showAction
            ->execute($this, NULL, NULL, NULL, __METHOD__)
            ->render()
            ->with(
                [
                    'user_log' => $this->userMeta->unserializeData(
                        ['user_id' => $this->thisRouteID()],
                        [
                            'login', /* array index 0 */
                            'logout', /* array index 1 */
                            'brute_force', /* index 2 */
                            'user_browser' /* index 3 */
                        ]
                    )
                ]
            )
            ->singular()
            ->end();
    }

    /**
     * The new action request. is responsible for creating a new user. By sending
     * post data to the relevant model. Which is turns sanitize and validate the the
     * incoming data. An event will be dispatched when a new user is created.
     * @throws Exception
     */
    protected function newAction()
    {
        $this->newAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with(['userYml' => Yaml::file('user')])
            ->form($this->formUser)
            ->end();
    }

    /**
     * The edit action request. is responsible for updating a user record within
     * the database. User data will be sanitized and validated before upon re
     * submitting new data. An event will be dispatched on this action
     */
    protected function editAction()
    {
        $this->editAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__, [], ['user_id' => $this->thisRouteID()])
            ->render()
            ->with(['user' => $this->toArray($this->findOr404())])
            ->form($this->formUser)
            ->end();
    }

    /**
     * The delete action request. is responsible for deleting a single record from
     * the database. This method is not a submittable method hence why this check has
     * been omitted. This a simple click based action. which is triggered within the
     * datatable. An event will be dispatch by this action
     */
    protected function deleteAction()
    {
        $this->deleteAction
            ->execute($this, NULL, UserActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->singular()
            ->end();

    }

    protected function hardDeleteAction()
    {
        $this->showAction
            ->execute($this, NULL, NULL, NULL, __METHOD__)
            ->render()
            ->with()
            ->singular()
            ->end();

    }

    /**
     * The bulk delete action request. is responsible for deleting multiple record from
     * the database. This method is not a submittable method hence why this check has
     * been omitted. This a simple click based action. which is triggered within the
     * datatable. An event will be dispatch by this action
     */
    protected function bulkAction()
    {
        $this->bulkDeleteAction
            ->execute($this, NULL, UserActionEvent::class, NULL, __METHOD__);
    }

    protected function cloneAction()
    {
        $this->newAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->singular()
            ->end();
    }

    protected function lockAction()
    {
        $this->editAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->singular()
            ->end();
    }

    protected function trashAction()
    {
        $this->newAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->singular()
            ->end();
    }

    protected function preferencesAction()
    {
        $this->newAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with(
                [
                    'user_preference' => $this->userPerferenceRepo->getRepo()->findObjectBy(['user_id' => $this->thisRouteID()])
                ]
            )
            ->form($this->userPerferencesForm)
            ->end();
    }

    protected function privilegesAction()
    {
        $this->newAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->singular()
            ->end();
    }

    protected function logAction()
    {
        $this->indexAction
            ->execute($this, NULL, NULL, UserSchema::class, __METHOD__)
            ->render()
            ->with()
            ->table()
            ->end();
    }


}
