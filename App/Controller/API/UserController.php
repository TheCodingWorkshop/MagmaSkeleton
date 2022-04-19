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
use App\Resource\UserResource;
use Exception;
use MagmaCore\CurlApi\Exception\CurlException;

class UserController extends APIUserController
{

    public function __construct($routeParams)
    {
        parent::__construct($routeParams);
        $this->addDefinitions(['userResource' => UserResource::class]);
    }

    /**
     * @throws CurlException
     * @throws Exception
     */
    protected function indexAction()
    {

        $this->userResource->apiRead($this);

    }

//    protected function rowsAction()
//    {
//        $globalValue = $this->settings->get('global_table_rows_per_page') ?? 0;
//        $controllerTableValue = $this->controllerSettings
//                ->getRepo()
//                ->findObjectBy(['controller_name' => $this->thisRouteController()], ['records_per_page']) ?? 0;
//        $rows = (isset($controllerTableValue) && $controllerTableValue !==0) ? $controllerTableValue : $globalValue;
//        echo json_encode(array('results' => $rows));
//
//    }

}
