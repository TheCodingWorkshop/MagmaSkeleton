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

use LoaderError;
use SyntaxError;
use RuntimeError;
use App\Entity\UserEntity;
use App\Schema\UserSchema;
use App\Event\UserActionEvent;
use MagmaCore\Auth\Roles\Roles;
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
        $this->diContainer(
            [
                'repository' => \App\Model\UserModel::class,
                'rolePermission' => \App\Model\RolePermissionModel::class,
                'entity' => \App\Entity\UserEntity::class,
                'column' => \App\DataColumns\UserColumn::class,
                'formUser' => \App\Forms\Admin\User\UserForm::class,
                'perferencesForm' => \App\Forms\Admin\User\PerferencesForm::class,
                'formSettings' => \App\Forms\Admin\User\SettingsForm::class,
            ]
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
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function indexAction()
    {
        // $real = $this->rolePermission
        //     ->hasRelationship()
        //         ->manyToMany('id', 'permission_name', ['id', 'role_name'])
        //             ->fetchAsCollection();

        // var_dump($real->all());
        // die;
        //$timeStart = microtime(true);
        $this->indexAction
            ->execute($this, NULL, NULL, UserSchema::class, __METHOD__)
                ->render()
                    ->with(['status' => ['pending', 'active', 'suspended', 'lock']])
                        ->table()
                            ->end();
       // $timeEnd = microtime(true);
       // print_r($timeEnd - $timeStart);
    }

    /**
     * The show action request displays singluar information about a user. This is a
     * read only request. Information here cannot be editted.
     *
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function showAction()
    {
        $this->showAction
            ->execute($this, NULL, NULL, NULL, __METHOD__)
                ->render()
                    ->with()
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
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function newAction()
    {
        $this->newAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__)
                ->render()
                    ->with()
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
     * @throws RuntimeError
     * @throws SyntaxError
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
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function deleteAction()
    {
        $this->deleteAction
            ->execute($this, NULL, UserActionEvent::class, NULL, __METHOD__);
    }

    /**
     * The bulk delete action request. is responsible for deleting multiple record from
     * the database. This method is not a submittable method hence why this check has
     * been omitted. This a simple click based action. which is triggered within the
     * datatable. An event will be dispatch by this action
     *
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function bulkAction()
    {
        $this->bulkDeleteAction
            ->execute($this, NULL, UserActionEvent::class, NULL, __METHOD__);
    }

    /**
     * The perferences action request. is responsible for updating setting and updating
     * user perferences whatever that might be
     *
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function perferencesAction()
    {
        $this->editAction
            ->execute($this, NULL, NULL, NULL, __METHOD__)
                ->render()
                    ->with(['user' => $this->toArray($this->findOr404())])
                        ->form($this->perferencesForm)
                            ->end();

    }

    /**
     * Undocumented function
     *
     * @return void
     */
    protected function settingsAction()
    {
        $this->newAction
            ->execute($this, NULL, NULL, NULL, __METHOD__)
                ->render()
                    ->with()
                        ->form($this->formSettings)
                            ->end();
    }

    protected function LogAction()
    {
        $this->indexAction
            ->execute($this, NULL, NULL, NULL, __METHOD__)
                ->render()
                    ->with()
                        ->table(/* table_params, new_column_obj, new_repo_obj, table_data */)
                            ->end();
    }

    /**
     * The table settings insert action request. Simple adds per table related
     * configurable data. This provides customizable settings for each datatable
     *
     * @return bool
     */
    public function tableSettingsInsertAction(): bool
    {
        $this->tableSettingsInit($this->thisRouteController());
        $this->flashMessage('Changes Saved!');
        $this->redirect('/admin/user/index');
        return true;
    }

    /**
     * table settings for updating this entity. Stored in flat file database
     *
     * @return boolean
     */
    public function tableSettingsUpdateAction(): bool
    {
        $this->tableSettingsUpdateInit($this->thisRouteController());
        $this->flashMessage('Settings Updated!');
        $this->redirect('/admin/user/index');
        return true;
    }
}
