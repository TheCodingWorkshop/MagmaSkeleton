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

use App\Commander\RoleCommander;
use App\DataColumns\RoleColumn;
use App\Entity\RoleEntity;
use App\Entity\RolePermissionEntity;
use App\Event\RoleActionEvent;
use App\Forms\Admin\Role\RoleAssignedForm;
use App\Forms\Admin\Role\RoleForm;
use App\Model\PermissionModel;
use App\Model\RoleModel as RM;
use App\Model\RolePermissionModel;
use App\Model\UserModel as UM;
use App\Model\UserRoleModel;
use App\Relationships\RoleRelationship;
use App\Schema\RoleSchema;
use App\Event\RolePermissionAssignedActionEvent;
use MagmaCore\Base\Exception\BaseInvalidArgumentException;
use MagmaCore\DataObjectLayer\DataLayerTrait;

class RoleController extends AdminController
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
         * [ roleModel => \App\Model\RoleModel::class ]. Where the key becomes the
         * property for the RoleModel object like so $this->roleModel->getRepo();
         */
        $this->addDefinitions(
            [
                'repository' => RM::class,
                'userRepository' => UM::class,
                'commander' => RoleCommander::class,
                'entity' => RoleEntity::class,
                'column' => RoleColumn::class,
                'formRole' => RoleForm::class,
                'formRoleAssigned' => RoleAssignedForm::class,
                'permission' => PermissionModel::class,
                'rolePerm' => RolePermissionModel::class,
                'userRole' => UserRoleModel::class,
                'relationship' => RoleRelationship::class
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

    /**
     * Entry method which is hit on request. This method should be implement within
     * all sub controller class as a default landing point when a request is
     * made.
     */
    protected function indexAction()
    {
        $this->indexAction
            ->execute($this, NULL, NULL, RoleSchema::class, __METHOD__)
            ->render()
            ->with()
            ->table()
            ->end();
    }

    /**
     * The new action request. is responsible for creating a new role. By sending
     * post data to the relevant model. Which is turns sanitize and validate the the
     * incoming data. An event will be dispatched when a new role is created.
     */
    protected function newAction(): void
    {
        $this->newAction
            ->execute($this, RoleEntity::class, RoleActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form($this->formRole)
            ->end();
    }

    /**
     * The edit action request. is responsible for updating a user record within
     * the database. User data will be sanitized and validated before upon re
     * submitting new data. An event will be dispatched on this action
     */
    protected function editAction(): void
    {
        $this->editAction
            ->execute($this, RoleEntity::class, RoleActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with(
                [
                    'role' => $this->toArray($this->findOr404())
                ]
            )
            ->form($this->formRole)
            ->end();
    }

    /**
     * The delete action request. is responsible for deleting a single record from
     * the database. This method is not a submittable method hence why this check has
     * been omitted. This a simple click based action. which is triggered within the
     * datatable. An event will be dispatch by this action
     *
     * @return void
     */
    protected function deleteAction(): void
    {
        $this->deleteAction
            ->execute($this, NULL, RoleActionEvent::class, NULL, __METHOD__);
    }

    /**
     * Undocumented function
     *
     * @return void
     */
    protected function assignedAction()
    {
        $this->blankAction
            ->execute($this, RolePermissionEntity::class, RolePermissionAssignedActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with(
                [
                    'role' => $this->toArray($this->findOr404()),
                    'permissions' => $this->permission->getRepo()->findAll(),
                    'role_perms' => $this->flattenArray($this->rolePerm->getRepo()->findBy(['permission_id'], ['role_id' => $this->thisRouteID()]))
                ]
            )
            ->form($this->formRoleAssigned)
            ->end();
    }

    protected function logAction()
    {
        $this->logIndexAction
            ->execute($this, NULL, NULL, RoleSchema::class, __METHOD__)
            ->render()
            ->with()
            ->table()
            ->end();
    }
}
