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

use App\Model\SettingModel;
use MagmaCore\CommanderBar\ApplicationCommanderTrait;
use MagmaCore\CommanderBar\ApplicationCommanderInterface;

class SettingCommander extends SettingModel implements ApplicationCommanderInterface
{

    use ApplicationCommanderTrait;

    /**
     * Return an array of all the inner routes within the user model
     * @var array
     */
    protected const INNER_ROUTES = [
        'index',
        'application',
        'general',
        'security',
        'purge',
        'backup_restore',
        'localisation',
        'branding',
        'extension'
    ];

    /**
     * Get the specific yaml file which helps to render some text within the specified
     * html template.
     *
     * @return array
     */
    public function getYml(): array
    {
        return $this->findYml('setting');
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
            'edit' => "Edit " . $this->getHeaderBuildEdit($controller, 'setting_name'),
            default => "Unknown"
        };
    }
}
