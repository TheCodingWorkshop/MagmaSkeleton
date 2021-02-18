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
use App\Event\NewActionEvent;

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
        $this->container(
            [
                "repository" => \MagmaCore\Auth\Model\RoleModel::class,
                "column" => \App\DataColumns\RoleColumn::class,
                "formRole" => \App\Forms\Admin\Role\RoleForm::class,
                "permissionModel" => \MagmaCore\Auth\Model\PermissionModel::class,
                "rolePerm" => \MagmaCore\Auth\Model\RolePermissionModel::class,
            ]
        );
    }

    /**
     * helper function which returns the current roleModel object as the
     * role repository. This method is used many times throughout the file
     * this just provide a central method which can be used instead
     *
     * @return object
     */
    private function roleRepository(): Object
    {
        $repository = $this->repository->getRepo();
        if (null !== $repository) {
            return $repository;
        }
    }

    /**
     * [roleEntity description]
     * @return Object [description]
     */
    private function roleEntity(): Object
    {
        if (isset($this->formBuilder)) {
            $entity = new RoleEntity($this->formBuilder->getData());
            if ($entity) {
                return $entity;
            }
        }
    }

    /**
     * Returns a 404 error page if the data is not present within the database
     * else return the requested object
     *
     * @return mixed
     */
    private function findRoleOr404()
    {
        $repository = $this->roleRepository()
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

        /**
         * the two block below provides a mean of overriding the default settings
         * within the controller.yml file. So from the admin panel we can override
         * the records_per_page and the filter_by options dynamically
         */
        $args = Yaml::file('controller')[$this->thisRouteController()];
        $args['records_per_page'] = $this->tableSettings($this->thisRouteController(), 'records_per_page');
        $args['filter_by'] = $this->tableSettings($this->thisRouteController(), 'filter_by');

        $repository = $this->roleRepository()->findWithSearchAndPaging($this->request->handler(), $args);
        $tableData = $this->tableGrid->create($this->column, $repository, $args)->table();

        $this->render(
            'admin/role/index.html.twig',
            [
                "this" => $this,
                "form" => $this->formRole->createForm("/admin/role/new"),
                "table" => $tableData,
                "pagination" => $this->tableGrid->pagination(),
                "total_records" => $this->tableGrid->totalRecords(),
                "columns" => $this->tableGrid->getColumns(),
                "results" => $repository,
                "search_query" => $this
                    ->request
                    ->handler()
                    ->query->getAlnum(
                        $args['filter_alias']
                    ),
                "help_block" => ""
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
    protected function newAction()
    {
        if (isset($this->formBuilder)) :
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('new-' . $this->thisRouteController())) {
                if ($this->formBuilder->csrfValidate()) {
                    $action = $this->roleRepository()
                        ->validateRepository($this->roleEntity())->persistAfterValidation();
                    if ($this->error) {
                        $this->error->addError($this->roleRepository()->getValidationErrors(), $this)->dispatchError($this->onSelf());
                    }
                    if ($action) {
                        if ($this->eventDispatcher) {
                            $this->eventDispatcher->dispatch(
                                new NewActionEvent(
                                    $this->roleRepository()->validatedDataBag(),
                                    $this
                                ),
                                NewActionEvent::NAME
                            );
                        }
                    }
                }
            }
        endif;
    }

    /**
     * The edit action request. is responsible for updating a user record within
     * the database. User data wille be sanitized and validated before upon re
     * submitting new data. An event will be dispatched on this action
     *
     * @return void
     */
    protected function editAction()
    {
        if (isset($this->formBuilder)) {
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('edit-' . $this->thisRouteController())) {
                if ($this->formBuilder->csrfValidate()) {
                    $action = $this->roleRepository()
                        ->validateRepository(
                            new RoleEntity($this->formBuilder->getData()),
                            $this->roleRepository()
                        )
                        ->saveAfterValidation(['id' => $this->thisRouteID()]);
                    $actionEvent = ['action' => $action, 'errors' => $this->roleRepository()->getValidationErrors()];

                    $this->getFlashEvent($actionEvent);
                }
            }
        }
    }

    /**
     * The delete action request. is responsible for deleting a single record from
     * the database. This method is not a submittable method hence why this check has
     * been omitted. This a simple click based action. which is triggered within the
     * datatable. An event will be dispatch by this action
     *
     * @return void
     */
    protected function deleteAction()
    {
        if (isset($this->formBuilder)) {
            if ($this->formBuilder->canHandleRequest()) {
                $action = $this->roleRepository()->findByIdAndDelete(['id' => $this->thisRouteID()]);
                $actionEvent = ['action' => $action];
                $this->getFlashEvent($actionEvent);
            }
        }
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
