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

use App\Model\UserModel;
use MagmaCore\CommanderBar\ApplicationCommanderTrait;
use MagmaCore\CommanderBar\ApplicationCommanderInterface;

class TeamCommander extends UserModel implements ApplicationCommanderInterface
{

    use ApplicationCommanderTrait;

    /**
     * Return an array of all the inner routes within the user model
     * @var array
     */
    protected const INNER_ROUTES = [
        'index',
        'new',
        'edit',
        'assigned'
    ];

    /**
     * Get the specific yaml file which helps to render some text within the specified
     * html template.
     *
     * @return array
     */
    public function getYml(): array
    {
        return $this->findYml('team');
    }

    /**
     * Display a sparkline graph for this controller index route 
     *
     * @return string
     */
    public function getGraphs(): string
    {
        return '<div id="sparkline"></div>';
    }

    /**
     * Dynamically change commander bar header based on the current route
     *
     * @param object $controller
     * @return string
     */
    public function getHeaderBuild(object $controller): string
    {
        $this->getHeaderBuildException($controller, self::INNER_ROUTES);

        $this->controller = $controller;
        return match ($controller->thisRouteAction()) {
            'index' => $this->getStatusColumnFromQueryParams($controller),
            'new' => 'Create New Role',
            'edit' => "Edit " . $this->getHeaderBuildEdit($controller, 'role_name'),
            'assigned' => 'Role Assignment',
            default => "Unknown"
        };
    }
}
