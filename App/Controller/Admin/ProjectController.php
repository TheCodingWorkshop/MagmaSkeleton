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

use App\Commander\ProjectCommander;
use App\DataColumns\ProjectColumn;
use App\Entity\ProjectEntity;
use App\Event\ProjectActionEvent;
use App\Model\ProjectModel;
use App\Schema\ProjectSchema;
use MagmaCore\Base\Exception\BaseException;
use MagmaCore\Base\Exception\BaseInvalidArgumentException;

class ProjectController extends AdminController
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
     * @throws BaseInvalidArgumentException|BaseException
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
                'repository' => ProjectModel::class,
                'column' => ProjectColumn::class,
                'commander' => ProjectCommander::class
            ]
        );
        /** Initialize database with table settings */
         $this->initializeControllerSettings(
             'project',
             $this->column
         );

    }

    protected function indexAction()
    {
        $this->indexAction
            ->execute($this, ProjectEntity::class, ProjectActionEvent::class, ProjectSchema::class, __METHOD__)
            ->render()
            ->with()
            ->table()
            ->end();
    }


}
