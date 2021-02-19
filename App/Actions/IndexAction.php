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

namespace App\Actions;

use MagmaCore\Utility\Yaml;

/**
 * Class which handles the domain logic when adding a new item to the database
 * items are sanitize and validated before persisting to database. The class will 
 * also diaptched any validation error before persistence. The logic also implements
 * event dispatching which provide usable data for event listeners to perform other
 * necessary tasks and message flashing
 */
class IndexAction
{

    /** @return void - not currently being used */
    public function __construct()
    { }

    /**
     * execute logic for adding new items to the database()
     * 
     * @param Object $controller - The controller object implementing this object
     * @param string $eventDispatcher - the eventDispatcher for the current object
     * @return void
     */
    public function execute(Object $controller)
    {
        $controller->getSession()->set('redirect_parameters', $_SERVER['QUERY_STRING']);
        $args = Yaml::file('controller')[$controller->thisRouteController()];
        //$args['records_per_page'] = $controller->tableSettings($controller->thisRouteController());
        //$args['filter_by'] = $controller->tableSettings($controller->thisRouteController(), 'filter_by');
        $repository = $controller->repository->getRepo()->findWithSearchAndPaging($controller->request->handler(), $args);
        $tableData = $controller->tableGrid->create($controller->column, $repository, $args)->table();
        if ($tableData) {
            return [
                $repository,
                $tableData,
                $controller->tableGrid->pagination(),
                $controller->tableGrid->getColumns(),
                $controller->tableGrid->totalRecords(),
                $controller->request->handler()->query->getAlnum($args['filter_alias'])
            ];
        }
    }
}
