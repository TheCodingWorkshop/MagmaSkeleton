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

use App\Event\CategoryActionEvent;
use Exception;
use MagmaCore\EventDispatcher\EventDispatcherTrait;
use MagmaCore\EventDispatcher\EventSubscriberInterface;

/**
 * Note: If we want to flash other routes then they must be declared within the ACTION_ROUTES
 * protected constant
 */
class CategoryActionSubscriber implements EventSubscriberInterface
{

    use EventDispatcherTrait;

    /** @var int - we want this to execute last so it doesn't interrupt other process */
    private const FLASH_MESSAGE_PRIORITY = -1000;

    /**
     * Add other route index here in order for that route to flash properly. this array is index array
     * which means the first item starts at 0. See ACTION_ROUTES constant for correct order of how to
     * load other routes for flashing
     * @var int
     */
    protected const NEW_ACTION = 'new';
    protected const EDIT_ACTION = 'edit';
    protected const DELETE_ACTION = 'delete';
    protected const STARRED_ACTION = 'starred';
    protected const BULK_ACTION = 'bulk';

    /**
     * Subscribe multiple listeners to listen for the NewActionEvent. This will fire
     * each time a new user is added to the database. Listeners can then perform
     * additional tasks on that return object.
     * @return array
     */

    public static function getSubscribedEvents(): array
    {
        return [
            CategoryActionEvent::NAME => [
                ['flashMessageEvent', self::FLASH_MESSAGE_PRIORITY],
                ['categoryNotification']
            ]
        ];
    }

    /**
     * Event flash allows flashing of any specified route defined with the ACTION_ROUTES constants
     * one can declare a message and a default route. if a default route isn't
     * set then the script will
     *
     * redirect back on itself using the onSelf() method. Delete route is automatically filtered to
     * redirect back to the index page. As this is the only logical route to redirect to. after we
     * remove the object. failure to comply with this will result in 404 error as the script will
     * try to redirect to an object that no longer exists.
     *
     * @param CategoryActionEvent $event
     * @return void
     * @throws Exception
     */
    public function flashMessageEvent(CategoryActionEvent $event)
    {
        $this->flashingEvent($event);
    }

    /**
     * Add a system notification each time a request has been made from the user controller
     * @param CategoryActionEvent $event
     * @throws Exception
     */
    public function categoryNotification(CategoryActionEvent $event)
    {
        $this->notify($event, CategoryActionEvent::NAME, function($event, $trait) {
            $method = $event->getMethod();
            /* Get the ID of the currently logged-in user */
            $currentUserID = $event->getObject()->getSession()->get('user_id');
            /* Get object of the currently logged-in user */
            //$user = $event->getObject()->repository->getUser($currentUserID);

            $preActionEditSession = $event->getObject()->getSession()->get('pre_action_edit_category');
            unset(
                $preActionEditSession['_CSRF_INDEX'],
                $preActionEditSession['_CSRF_TOKEN'],
                $preActionEditSession['edit-category'],
                $preActionEditSession['new-category'],
            );

            list($desc, $title) = $trait->resolveContextForDescription($event, $preActionEditSession, $method, null);
            return [
                'notify_title' => $title,
                'notify_description' => $desc,
                'notify_type' => 'system',
                'notifier' => 'dunno yet',
                'created_byid' => $currentUserID,
            ];

        });
    }


}

