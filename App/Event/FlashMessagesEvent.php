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

class FlashMessagesEvent extends Event
{

    /** @var string - name of the event */
    public const NAME = 'app.event.flash_messages_event';
    /** @var array */
    private array $action;
    /** @var Object - teh current controller object */
    private $controller;

    /**
     * Undocumented function
     *
     * @param array $action
     * @param Object $controllerObject
     */
    public function __construct(array $action, Object $controllerObject)
    { 
        $this->action = $action;
        $this->controller = $controllerObject;
    }

    /**
     * Returns teh current controller object with access to all its methods and property
     *
     * @return OPbject
     */
    public function get()
    {
        return $this->controller;
    }

    /**
     * Checks whether data submission was success or fail
     * 
     * @return bool
     */
    public function isValid()
    {
        return $this->action;
    }

}