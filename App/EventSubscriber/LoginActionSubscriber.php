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

use MagmaCore\Auth\Authorized;
use App\Event\LoginActionEvent;
use MagmaCore\EventDispatcher\EventDispatcherTrait;
use MagmaCore\EventDispatcher\EventSubscriberInterface;

/**
 * Note: If we want to flash other routes then they must be declared within the ACTION_ROUTES
 * protected constant
 */
class LoginActionSubscriber implements EventSubscriberInterface
{

    use EventDispatcherTrait;

    /** @var int - we want this to execute last so it doesn't interupt other process */
    private const FLASH_MESSAGE_PRIOIRTY = -1000;
    /** @var string - default flash message */
    private const FLASH_DEFAULT = '<strong class="">Attention!</strong> This is a default message';

    /**
     * Add other route index here in order for that route to flash properly. this array is index array
     * which means the first item starts at 0. See AcTION_ROUTES constant for correct order of how to 
     * load other routes for flashing
     * @var int
     */
    protected const INDEX_ACTION = 'index';
    protected const LOGOUT_ACTION = 'logout';

    /**
     * Subscibe multiple listeners to listen for the NewActionEvent. This will fire
     * each time a new user is added to the database. Listeners can then perform
     * addtitional tasks on that return object.
     *
     * @return array
     */
    public static function getSubscribedEvents(): array
    {
        return [
            LoginActionEvent::NAME => [
                ['flashLoginEvent', self::FLASH_MESSAGE_PRIOIRTY],
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
     * @param Object $event
     * @param string $msg
     * @param string|null $redirect
     * @return void
     */
    public function flashLoginEvent(LoginActionEvent $event)
    {
        $this->flashingEvent($event, $this->trailingRoutes($event), self::FLASH_DEFAULT, null,
            /**
             * As we are dealing with modal for adding and editing roles we want to redirect
             * back to the role index page.
             */
            function ($cbEvent, $actionRoutes) {
                $cbEvent->getObject()->redirect(Authorized::getReturnToPage());
            }
        );
    }

}
