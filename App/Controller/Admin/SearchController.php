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

use MagmaCore\Base\Domain\Actions\SearchAction;
use App\Entity\SearchEntity;
use App\Forms\Admin\Search\SearchForm;
use App\Event\SearchActionEvent;
use MagmaCore\UserManager\UserModel;

class SearchController extends \MagmaCore\Administrator\Controller\AdminController
{

    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);

        $this->addDefinitions(
            [
                'searchAction' => SearchAction::class,
                'searchForm' => SearchForm::class,
                'repository' => UserModel::class
            ]
        );
    }

    protected function searchAction()
    {
        $this->searchAction
            ->execute($this, SearchEntity::class, SearchActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form($this->searchForm)
            ->end();
    }


}
