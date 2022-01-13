<?php
/*
 * controller file is part of the MagmaCore package.
 *
 * (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with controller source code.
 */

declare(strict_types=1);

namespace App\Resource;

use MagmaCore\Utility\Yaml;
use MagmaCore\UserManager\UserModel;

class UserResource extends UserModel
{

    public function apiRead(?object $controller = null)
    {
        $args = Yaml::file('controller')[$controller->thisRouteController()];
        $args['records_per_page'] = 5;
        $repository = $controller->repository->getRepo()->findWithSearchAndPaging($controller->request->handler(), $args);

        if ($repository) {
            $arr = [];
            $arr['records'] = [];
            array_push($arr['records'], $repository);
            $controller->tableGrid->create($controller->column, $repository, $args, [], $controller, $controller->request)->table();

            $arr['total_pages'] = $controller->tableGrid->getTotalPages();
            $arr['current_page'] = $controller->tableGrid->getCurrentPage();
            $arr['total_records'] = $controller->tableGrid->getTotalRecords();
            $arr['table_columns'] = $controller->tableGrid->getDataColumns();
            $arr['column'] = $controller->tableGrid->getColumns();
            $arr['query_status'] = $controller->tableGrid->getQueriedStatus();
            $arr['status'] = $controller->tableGrid->getStatus();

            $response = $controller->restful->response($arr);
            echo $response;
        } else {
            $message = ['error' => 'No user found!'];
            $response = $controller->restful->response($message, 404);
            echo $response;

        }

    }

    public function apiCreate(){}
    public function apiUpdate() {}
    public function apiDelete() {}

}