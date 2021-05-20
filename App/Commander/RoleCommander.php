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

namespace App\Commander;

use App\Model\RoleModel;
use MagmaCore\Utility\Yaml;
use MagmaCore\Utility\Stringify;
use MagmaCore\CommanderBar\ApplicationCommanderInterface;

class RoleCommander extends RoleModel implements ApplicationCommanderInterface
{

    /**
     * Return an array of all the inner routes within the user model
     * @var array
     */
    protected const INNER_ROUTES = [
        'index',
        'new',
        'edit',
        'show',
        'hard-delete',
        'perferences',
        'privileges'
    ];

    /**
     * Returns different variant of the controller name whether that be capitalize
     * pluralize or just a normal justify lower case controller name
     *
     * @param object $controller
     * @return string
     */
    public function getName(object $controller, string $type = 'lower'): string
    {
        if ($controller) {
            $name = $controller->thisRouteController();
            return match ($type) {
                'caps' => Stringify::capitalize($name),
                'pluralize' => Stringify::capitalize(Stringify::pluralize($name)),
                'lower' => Stringify::justify($name, 'strtolower')
            };
        }
    }

    /**
     * Return the query column value from the relevant controller settings row
     * if available. Not all table will have a query column
     *
     * @param object $controller
     * @return string|null
     */
    public function getStatusColumn(object $controller): string
    {
        $queryColumn = $controller->controllerRepository->getRepo()->findObjectBy(
            ['controller_name' => $this->getName($controller)],
            ['query']
        );
        if ($queryColumn) {
            return $queryColumn->query;
        }
    }

    /**
     * Dynamically get the queried value based on the query parameter. Using the 
     * status column return from the controller settings table for the relevant 
     * controller.
     *
     * @param object $controller
     * @return mixed
     */
    public function getStatusColumnFromQueryParams(object $controller): mixed
    {
        $queriedValue = $this->getStatusColumn($controller);
        if (isset($_GET[$queriedValue]) && $_GET[$queriedValue] !== '') {
            return $this->getName($controller, 'pluralize') . ' ' . Stringify::capitalize($_GET[$queriedValue]);
        } else {
            return $this->getName($controller, 'pluralize') . ' Listing';
        }
    }

    /**
     * Undocumented function
     *
     * @return void
     */
    public function getUserYml()
    {
        if ($list = Yaml::file('role')) {
            return ($this->controller->thisRouteAction() === 'index') ? $list['index'] : $list['not_index'];
        }
    }

    /**
     * Undocumented function
     *
     * @return string
     */
    public function getGraphs(): string
    {
        return '<div id="sparkline"></div>';
    }

    /**
     * Undocumented function
     *
     * @param object $controller
     * @return string
     */
    public function getHeaderBuild(object $controller): string
    {
        if (!in_array($action = $controller->thisRouteAction(), self::INNER_ROUTES)) {
            throw new \Exception('Invalid route');
        }
        if ($controller->thisRouteID()) {
            $nameSuffix = method_exists($controller, 'findOr404') ? $controller->findOr404()->firstname : 'Unknown Object';
        }

        $this->controller = $controller;

        return match ($action) {
            'index' => $this->getStatusColumnFromQueryParams($controller),
            'new' => 'Create New Role',
            'edit' => "Edit {$nameSuffix}",
            'show' => "Viewing {$nameSuffix}",
            default => "Unknown"
        };
    }
}
