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

use MagmaCore\EventDispatcher\EventSubscriberInterface;
use App\Event\FlashMessagesEvent;

class FlashMessagesSubscriber implements EventSubscriberInterface
{

    /**
     * Subscibe multiple listeners to listen for the NewUserEvent. This will fire
     * each time a new user is added to the database. Listeners can then perform
     * addtitional tasks on that return object.
     *
     * @return array
     */
    public static function getSubscribedEvents() : array
    {
        return [
            FlashMessagesEvent::NAME => ['onSuccessRequestAction']
            
        ];

    }

    /** */
    public function onSuccessRequestAction(FlashMessagesEvent $event)
    {
        if ($event->isValid()) {
            $event->controller()->flashMessage('Successfully created');
            $event->controller()->redirect('/admin/user/index');
        } else {
            $event->controller()->flashMessage('Failed');
            $event->controller()->redirect('/admin/user/new');
        }
    }

    /** */
    public function onFailRequestAction(FlashMessagesEvent $event)
    {
        if ($event->isValid()) {
            $event->controller()->flashMessage('Changes not saved.', $event->controller()->flashWarning());
            $event->controller()->redirect('/admin/user/index');
        }
    }

    /** */
    public function onInvalidCsrfRequestAction(FlashMessagesEvent $event)
    {
        if ($event->isValid()) {
            $flash = $event->controller()->flashMessage('Invalid Csrf token', $event->controller()->flashDanger());
            if ($flash) {
                echo $flash;
            }    
        }
        return false;
    }

    /** */
    public function onInvalidRequestAction(FlashMessagesEvent $event)
    {
        if ($event->isValid()) {
            $flash = $event->controller()->flashMessage('Invalid Request.', $event->controller()->flashWarning());
            if ($flash) {
                echo $flash;
            }    
        }
        return false;
    }

}