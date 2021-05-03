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
use App\Entity\PermissionEntity;
use App\Schema\PermissionSchema;
use App\Event\PermissionActionEvent;

class PermissionController extends AdminController
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
         * [ PermissionModel => \App\Model\PermissionModel::class ]. Where the key becomes the 
         * property for the PermissionModel object like so $this->PermissionModel->getRepo();
         */
        $this->diContainer(
            [
                'repository' => \App\Model\PermissionModel::class,
                'entity' => \App\Entity\PermissionEntity::class,
                'column' => \App\DataColumns\PermissionColumn::class,
                'formPermission' => \App\Forms\Admin\Permission\PermissionForm::class
            ]
        );
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
            ->execute($this, NULL, NULL, PermissionSchema::class, __METHOD__)
                ->render()
                    ->with(
                        [
                            'form' => $this->formPermission->createForm($this->getRoute('new', $this))
                        ]
                    )->table()
                        ->end();
    }

    /**
     * The new action request. is responsible for creating a new permission. By sending
     * post data to the relevant model. Which is turns sanitize and validate the the 
     * incoming data. An event will be dispatched when a new permission is created.
     *
     * @return void
     */
    protected function newAction(): void
    {
        $this->newAction
            ->execute($this, PermissionEntity::class, PermissionActionEvent::class, NULL, __METHOD__);
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
            ->execute($this, PermissionEntity::class, PermissionActionEvent::class, NULL, __METHOD__);
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
        $this->deleteAction
            ->execute($this, NULL, PermissionActionEvent::class, NULL, __METHOD__);
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
        $this->redirect($this->selfPath('table-settings-insert'));
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
        $this->redirect($this->selfPath('table-settings-update'));
        return true;
    }
}
