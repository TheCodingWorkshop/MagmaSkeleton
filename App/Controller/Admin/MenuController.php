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

use App\Commander\MenuCommander;
use App\DataColumns\MenuColumn;
use App\Schema\MenuSchema;
use App\Forms\Admin\Menu\MenuForm;
use MagmaCore\Auth\Entity\MenuEntity;
use MagmaCore\Auth\Model\MenuModel;
use MagmaCore\Auth\Model\MenuItemModel;
use MagmaCore\Base\Exception\BaseInvalidArgumentException;
use MagmaCore\DataObjectLayer\DataLayerTrait;

class MenuController extends AdminController
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
                'repository' => MenuModel::class,
                'commander' => MenuCommander::class,
                'column' => MenuColumn::class,
                'entity' => MenuEntity::class,
                'formMenu' => MenuForm::class,
                'menuItem' => MenuItemModel::class
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

    protected function indexAction()
    {
        $this->indexAction
            ->setAccess($this, 'can_view')
            ->execute($this, NULL, NULL, MenuSchema::class, __METHOD__)
            ->render()
            ->with()
            ->table()
            ->end();
    }

    protected function newAction()
    {
        $this->indexAction
            ->setAccess($this, 'can_add')
            ->execute($this, NULL, NULL, MenuSchema::class, __METHOD__)
            ->render()
            ->with(
                [

                ]
            )
            ->form($this->formMenu)
            ->end();
    }

    protected function editAction()
    {
        $this->showAction
            ->setAccess($this, 'can_edit')
            ->execute($this, NULL, NULL, NULL, __METHOD__)
            ->render()
            ->with(
                [
                    'parent_menu' => $this->toArray($this->findOr404()),
                    'menu_items' => $this->menuItem->getRepo()->findBy(['*'], ['item_original_id' => $this->thisRouteID(), 'item_usable' => 1]),
                ]
            )
            ->form($this->formMenu)
            ->end();
    }



}

