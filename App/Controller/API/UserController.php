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

namespace App\Controller\API;

use App\Controller\Admin\UserController as APIUserController;
use App\Entity\UserEntity;
use App\Event\UserActionEvent;
use App\Schema\UserSchema;

class UserController extends APIUserController
{

    protected function indexAction()
    {
        $this->indexAction
            ->execute($this, NULL, NULL, UserSchema::class, __METHOD__)
            ->render('/admin/user/index.html')
            ->with()
            ->table()
            ->indexApiEndpoint();

    }

    protected function rowsAction()
    {
        $globalValue = $this->settings->get('global_table_rows_per_page') ?? 0;
        $controllerTableValue = $this->controllerSettings
                ->getRepo()
                ->findObjectBy(['controller_name' => $this->thisRouteController()], ['records_per_page']) ?? 0;
        $rows = (isset($controllerTableValue) && $controllerTableValue !==0) ? $controllerTableValue : $globalValue;
        echo json_encode(array('results' => $rows));

    }

}
