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

use App\Event\RoleActionEvent;
use MagmaCore\EventDispatcher\EventSubscriberInterface;

/**
 * Note: If we want to flash other routes then they must be declared within the ACTION_ROUTES
 * protected constant
 */
class RoleActionSubscriber implements EventSubscriberInterface
{

    /** @var int - we want this to execute last so it doesn't interupt other process */
    private const FLASH_MESSAGE_PRIOIRTY = -1000;
    /** @var string - default flash message */
    private const FLASH_DEFAULT = '<strong class="">Attention!</strong> This is a default message';
    /** @var string */
    protected const REDIRECT_DELETE = '/admin/role/index';

    /**
     * Add other route index here in order for that route to flash properly. this array is index array
     * which means the first item starts at 0. See AcTION_ROUTES constant for correct order of how to 
     * load other routes for flashing
     * @var int
     */
    protected const NEW_ACTION = 'new';
    protected const EDIT_ACTION = 'edit';
    protected const DELETE_ACTION = 'delete';

    protected const ACTION_ROUTES = [
        'App\Controller\Admin\RoleController::newAction' => ['msg' => 'New Role Added!'],
        'App\Controller\Admin\RoleController::editAction' => ['msg' => 'Role updated!'],
        'App\Controller\Admin\RoleController::deleteAction' => ['msg' => 'Role Deleted!', 'redirect' => self::REDIRECT_DELETE],
    ];

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
            RoleActionEvent::NAME => [
                ['flashing', self::FLASH_MESSAGE_PRIOIRTY],
            ]
        ];
    }

    /**
     * Helper method which allows filtering of the various routes. This enables us to 
     * execute the method only on the routes we need to execute the method on.
     *
     * @param Object $event
     * @param string $route
     * @return boolean
     */
    public function onRoute(Object $event, string $route): bool
    {
        return ($event->getObject()->thisRouteAction() === $route) ? true : false;
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
    public function flashing(RoleActionEvent $event)
    {
        if (!empty($event->getMethod())) {
            if (in_array($event->getMethod(), array_keys(self::ACTION_ROUTES), true)) {
                if ($event) {
                    $_msg = self::ACTION_ROUTES[$event->getMethod()]['msg'];
                    $event->getObject()->flashMessage($_msg ? $_msg : self::FLASH_DEFAULT);
                    $event->getObject()
                        ->redirect('/admin/role/index');
                }
            }
        }
    }

}
