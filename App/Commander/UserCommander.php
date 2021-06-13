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
use Exception;
use MagmaCore\Utility\Stringify;
use MagmaCore\CommanderBar\ApplicationCommanderTrait;
use MagmaCore\CommanderBar\ApplicationCommanderInterface;

class UserCommander extends UserModel implements ApplicationCommanderInterface
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
        'show',
        'log',
        'hard-delete',
        'preferences',
        'privileges'
    ];
    private object $controller;

    /**
     * Get the specific yaml file which helps to render some text within the specified
     * html template.
     *
     * @return array
     * @throws Exception
     */
    public function getYml(): array
    {
        return $this->findYml('user');
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
     * @throws Exception
     */
    public function getHeaderBuild(object $controller): string
    {
        $this->getHeaderBuildException($controller, self::INNER_ROUTES);
        $this->controller = $controller;
        $suffix = $this->getHeaderBuildEdit($controller, 'firstname');

        return match ($controller->thisRouteAction()) {
            'index' => $this->getStatusColumnFromQueryParams($controller),
            'new' => 'Create New',
            'edit' => "Edit " . $this->getHeaderBuildEdit($controller, 'firstname'),
            'show' => "Viewing " . $suffix,
            'log' => Stringify::capitalize($controller->thisRouteController()) . ' Log',
            'hard-delete' => "Deleting " . $suffix,
            'preferences' => $suffix . " Preferences",
            'privileges' => $suffix . " Privileges",
            default => "Unknown"
        };
    }
}
