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

use MagmaCore\Base\Access;
use App\Model\CategoryModel;
use App\Entity\CategoryEntity;
use App\Schema\CategorySchema;
use App\Event\CategoryActionEvent;
use App\DataColumns\CategoryColumn;
use App\Commander\CategoryCommander;
use App\Forms\Admin\Category\CategoryForm;

class CategoryController extends \MagmaCore\Administrator\Controller\AdminController
{

    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);

        $this->addDefinitions(
            [
                'repository' => CategoryModel::class,
                'column' => CategoryColumn::class,
                'commander' => CategoryCommander::class,
                'entity' => CategoryEntity::class,
                'categoryForm' => CategoryForm::class,
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
        if (isset($this)) {
            return $this->repository->getRepo()
                ->findAndReturn($this->thisRouteID())
                ->or404();
        }
    }

    protected function indexAction()
    {

        $this->indexAction
            ?->setAccess($this, Access::CAN_VIEW)
            ?->execute($this, NULL, NULL, CategorySchema::class, __METHOD__)
            ?->render()
            ?->with(
                [
                ]
            )
            ?->table()
            ?->end();
    }

    protected function newAction()
    {
        $this->newAction
            ->execute($this, CategoryEntity::class, CategoryActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form($this->categoryForm)
            ->end();
    }

    protected function editAction(): void
    {
        $this->editAction
            ->setAccess($this, Access::CAN_EDIT)
            ->execute($this, CategoryEntity::class, CategoryActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with(
                [
                    'cat' => $this->toArray($this->findOr404())
                ]
            )
            ->form($this->categoryForm)
            ->end();
    }


}

