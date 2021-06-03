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
use App\Model\UserModel as UM;
use App\Entity\RoleEntity;
use App\Schema\RoleSchema;
use App\Event\RoleActionEvent;
use App\Model\RoleModel as RM;
use App\Entity\RolePermissionEntity;
use MagmaCore\DataObjectLayer\DataLayerTrait;

class RoleController extends AdminController
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
         * [ roleModel => \App\Model\RoleModel::class ]. Where the key becomes the
         * property for the RoleModel object like so $this->roleModel->getRepo();
         */
        $this->addDefinitions(
            [
                'repository' => \App\Model\RoleModel::class,
                'userRepository' => \App\Model\UserModel::class,
                'commander' => \App\Commander\RoleCommander::class,
                'entity' => \App\Entity\RoleEntity::class,
                'column' => \App\DataColumns\RoleColumn::class,
                'formRole' => \App\Forms\Admin\Role\RoleForm::class,
                'formRoleAssigned' => \App\Forms\Admin\Role\RoleAssignedForm::class,
                'permission' => \App\Model\PermissionModel::class,
                'rolePerm' => \App\Model\RolePermissionModel::class,
                'userRole' => \App\Model\UserRoleModel::class,
                'relationship' => \App\Relationships\RoleRelationship::class
            ]
        );
        /** Initialize database with table settings */
        $this->initializeControllerSettings(
            'role',
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
     *
     * @return void
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
     * the database. User data wille be sanitized and validated before upon re
     * submitting new data. An event will be dispatched on this action
     *
     * @return void
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
        $this->newAction
            ->execute($this, RolePermissionEntity::class, NULL, NULL, __METHOD__)
            ->mergeRelationship(function ($_repo, $_rel) {
                return $_rel->type()
                    ->manyToMany(RM::REL_FIELDS, UM::REL_FIELDS)
                    ->where(RM::REL_ASSOC)
                    ->and(UM::REL_ASSOC)
                    ->limit(['id' => $this->thisRouteID()])
                    ->all();
            })
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
}
