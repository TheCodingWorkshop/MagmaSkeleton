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

namespace App\Event;

use MagmaCore\EventDispatcher\Event;

class DeleteActionEvent extends Event
{

    /** @var string - name of the event */
    public const NAME = 'app.event.delete_action_event';
    /** @var array */
    private array $context;
    /** @var Object - the current controller object */
    private Object $controller;

    /**
     * Main class constructor method. assigning properties to constructor arguments
     *
     * @param array $context - the usable data as an array
     * @param Object $controllerObject
     */
    public function __construct(array $context, Object $controllerObject)
    {
        $this->context = $context;
        $this->controller = $controllerObject;
    }

    /**
     * Returns the contextual data from the method
     * 
     * @return array
     */
    public function getContext(): array
    {
        return $this->context;
    }

    /**
     * Returns the current controller object with access to all its methods and property
     *
     * @return Object
     */
    public function getObject(): Object
    {
        return $this->controller;
    }
}
