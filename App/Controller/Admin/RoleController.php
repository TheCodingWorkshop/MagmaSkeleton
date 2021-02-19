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
use App\Entity\RoleEntity;
use MagmaCore\Utility\Yaml;
use App\Event\RoleActionEvent;

class RoleController extends AdminController
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
         * [ roleModel => \App\Model\RoleModel::class ]. Where the key becomes the
         * property for the RoleModel object like so $this->roleModel->getRepo();
         */
        $this->diContainer(
            [
                "repository" => \MagmaCore\Auth\Model\RoleModel::class,
                "column" => \App\DataColumns\RoleColumn::class,
                "formRole" => \App\Forms\Admin\Role\RoleForm::class,
                "permissionModel" => \MagmaCore\Auth\Model\PermissionModel::class,
                "rolePerm" => \MagmaCore\Auth\Model\RolePermissionModel::class,
                "newAction" => \App\Actions\NewAction::class,
                "editAction" => \App\Actions\EditAction::class,
                "deleteAction" => \App\Actions\DeleteAction::class,
                "indexAction" => \App\Actions\IndexAction::class,
            ]
        );
    }

    /**
     * Returns a 404 error page if the data is not present within the database
     * else return the requested object
     *
     * @return mixed
     */
    private function findRoleOr404()
    {
        $repository = $this->roleRepository->getRepo()
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
        list($results, $tableData, $pagination, $columns, $totalRecords, $searchQuery) = $this->indexAction->execute($this);
        $this->render('admin/role/index.html.twig',
            [
                'form' => $this->formRole->createForm("/admin/role/new"),
                'this' => $this,
                'table' => $tableData,
                'pagination' => $pagination,
                'total_records' => $totalRecords,
                'columns' => $columns,
                'results' => $results,
                'search_query' => $searchQuery,
            ]
        );

    }

    /**
     * The new action request. is responsible for creating a new role. By sending
     * post data to the relevant model. Which is turns sanitize and validate the the
     * incoming data. An event will be dispatched when a new role is created.
     *
     * @return void
     */
    protected function newAction() : void
    {
        $this->newAction
            ->execute($this, RoleEntity::class, RoleActionEvent::class, __METHOD__);
    }

    /**
     * The edit action request. is responsible for updating a user record within
     * the database. User data wille be sanitized and validated before upon re
     * submitting new data. An event will be dispatched on this action
     *
     * @return void
     */
    protected function editAction() : void
    {
        $this->editAction
            ->execute($this, RoleEntity::class, RoleActionEvent::class, __METHOD__);
    }

    /**
     * The delete action request. is responsible for deleting a single record from
     * the database. This method is not a submittable method hence why this check has
     * been omitted. This a simple click based action. which is triggered within the
     * datatable. An event will be dispatch by this action
     *
     * @return void
     */
    protected function deleteAction() : void
    {
        $this->deleteAction
            ->execute($this, RoleActionEvent::class, __METHOD__);
    }

    protected function assignedAction()
    {
        if (isset($this->formBuilder)) {
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('edit-' . $this->thisRouteController())) {
                if ($this->formBuilder->csrfValidate()) {
                }
            }
        }
        $this->render(
            "/admin/role/assigned.html.twig",
            [
                "this" => $this,
                "role" => $this->toArray($this->findRoleOr404()),
                "permissions" => $this->permissionModel->getRepo()->findAll(),
                "role_perm" => $this->rolePerm->getRepo()->findObjectBy(['role_id' => $this->thisRouteID()])
            ]
        );
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
        $this->redirect('/admin/role/index');
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
        $this->redirect('/admin/role/index');
        return true;
    }
}
