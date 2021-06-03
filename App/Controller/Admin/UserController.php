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

use App\Model\RoleModel as RM;
use App\Model\UserModel as UM;
use App\Entity\UserEntity;
use App\Schema\UserSchema;
use MagmaCore\Utility\Yaml;
use App\Event\UserActionEvent;
use MagmaCore\DataObjectLayer\DataLayerTrait;

class UserController extends AdminController
{

    use DataLayerTrait;

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
         * [ userModel => \App\Model\UserModel::class ]. Where the key becomes the
         * property for the userModel object like so $this->userModel->getRepo();
         */
        $this->addDefinitions(
            [
                'repository' => \App\Model\UserModel::class,
                'commander' => \App\Commander\UserCommander::class,
                'rolePermission' => \App\Model\RolePermissionModel::class,
                'userMeta' => \App\Model\UserMetaDataModel::class,
                'entity' => \App\Entity\UserEntity::class,
                'column' => \App\DataColumns\UserColumn::class,
                'formUser' => \App\Forms\Admin\User\UserForm::class,
                'userPerferenceRepo' => \App\Model\UserPerferenceModel::class,
                'userPerferencesForm' => \App\Forms\Admin\User\UserPerferencesForm::class,
                'formSettings' => \App\Forms\Admin\User\SettingsForm::class,
                'tableSettings' => \App\Forms\Admin\Settings\TableSettingsForm::class,
                'relationship' => \App\Relationships\UserRelationship::class
            ]
        );
        /** Initialize database with table settings */
        $this->initializeControllerSettings(
            'user',
            $this->column
        );

    }

    /**
     * Returns a 404 error page if the data is not present within the database
     * else return the requested object
     *
     * @return mixed
     */
    public function findOr404(): Object
    {
        $repository = $this->repository->getRepo()
            ->findAndReturn($this->thisRouteID())
            ->or404();

        return $repository;
    }

    /**
     * Entry method which is hit on request. This method should be implement within
     * all sub controller class as a default landing point when a request is
     * made.
     *
     * @return Response
     * @throws LoaderError
     */
    protected function indexAction()
    {           
        $this->indexAction
            ->execute($this, NULL, NULL, UserSchema::class, __METHOD__)
                ->mergeRelationship(function($repository, $relationship){
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
     * The show action request displays singluar information about a user. This is a
     * read only request. Information here cannot be editted.
     *
     * @return Response
     * @throws LoaderError
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
     *
     * @return Response
     * @throws LoaderError
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
     * the database. User data wille be sanitized and validated before upon re
     * submitting new data. An event will be dispatched on this action
     *
     * @return Response
     * @throws LoaderError
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
     *
     * @return Response
     * @throws LoaderError
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
     *
     * @return Response
     * @throws LoaderError
     */
    protected function bulkAction()
    {
        $this->bulkDeleteAction
            ->execute($this, NULL, UserActionEvent::class, NULL, __METHOD__);
    }

    /**
     * @return Response
     * @throws LoaderError
     */
    protected function cloneAction()
    {
        $this->newAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__)
                ->render()
                    ->with()
                        ->singular()
                            ->end();
    }

    /**
     * @return Response
     * @throws LoaderError
     */
    protected function lockAction()
    {
        $this->editAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__)
                ->render()
                    ->with()
                        ->singular()
                            ->end();
    }

    /**
     * @return Response
     * @throws LoaderError
     */
    protected function trashAction()
    {
        $this->newAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__)
                ->render()
                    ->with()
                        ->singular()
                            ->end();
    }

    /**
     * @return Response
     * @throws LoaderError
     */
    protected function perferencesAction()
    {
        $this->newAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__)
                ->render()
                    ->with(
                        [
                            'user_perference' => $this->userPerferenceRepo->getRepo()->findObjectBy(['user_id' => $this->thisRouteID()])
                        ]
                        )
                        ->form($this->userPerferencesForm)
                            ->end();
    }

    /**
     * @return Response
     * @throws LoaderError
     */
    protected function privilegesAction()
    {
        $this->newAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__)
                ->render()
                    ->with()
                        ->singular()
                            ->end();
    }


}
