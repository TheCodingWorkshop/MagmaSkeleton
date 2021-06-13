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

namespace App\EventSubscriber;

use App\Event\ControllerSettingsActionEvent;
use JetBrains\PhpStorm\ArrayShape;
use MagmaCore\EventDispatcher\EventDispatcherTrait;
use MagmaCore\EventDispatcher\EventDispatcherDefaulter;
use MagmaCore\EventDispatcher\EventSubscriberInterface;

/**
 * Note: If we want to flash other routes then they must be declared within the ACTION_ROUTES
 * protected constant
 */
class ControllerSettingsActionSubscriber extends EventDispatcherDefaulter implements EventSubscriberInterface
{

    use EventDispatcherTrait;

    /** @var int - we want this to execute last so it doesn't interrupt other process */
    private const FLASH_MESSAGE_PRIORITY = -1000;
    /** @var string */
    protected const REDIRECT_DELETE = '/admin/user/index';

    /**
     * Subscribe multiple listeners to listen for the NewActionEvent. This will fire
     * each time a new user is added to the database. Listeners can then perform
     * additional tasks on that return object.
     *
     * @return array
     */
    public static function getSubscribedEvents(): array
    {
        return [
            ControllerSettingsActionEvent::NAME => [
                ['flashActivateEvent', self::FLASH_MESSAGE_PRIORITY],
            ]
        ];
    }

    /**
     * Event flash allows flashing of any specified route defined with the ACTION_ROUTES constants
     * one can declare a message and a default route. if a default route isn't set then the script will
     * redirect back on it self using the onSelf() method. Delete route is automatically filtered to
     * redirect back to the index page. As this is the only logical route to redirect to. after we
     * remove the object. failure to comply with this will result in 404 error as the script will
     * try to redirect to an object that no longer exists.
     *
     * @param ControllerSettingsActionEvent $event
     * @return void
     */
    public function flashActivateEvent(ControllerSettingsActionEvent $event): void
    {
        $this->flashingEvent(
            $event, 
            $this->trailingRoutes($event), 
            NULL, 
            NULL, /* We will just let the script redirect back onSelf() */
            NULL /* Not using a Closure ie a callback function */
        );
    }

}
