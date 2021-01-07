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

namespace App\EventSubscribers;

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
            FlashMessagesEvent::NAME => [
                ['onSuccess'],
                ['onFail'],
                ['onInvalidCsrf'],
                ['onInvalidRequest']
            ],
        ];

    }

    /** */
    public function onSuccess(FlashMessagesEvent $event)
    {
        if ($event->isValid()) {
            $flash = $event->flash()->flashMessage('Successfully created');
            if ($flash) {
                return $flash;
            }    
        }
        return false;
    }

    /** */
    public function onFail(FlashMessagesEvent $event)
    {
        if ($event->isValid()) {
            $flash = $event->flash()->flashMessage('Changes not saved.', $event->flash()->flashWarning());
            if ($flash) {
                return $flash;
            }    
        }
        return false;
    }

    /** */
    public function onInvalidCsrf(FlashMessagesEvent $event)
    {
        if ($event->isValid()) {
            $flash = $event->flash()->flashMessage('Invalid Csrf token', $event->flash->flashDanger());
            if ($flash) {
                return $flash;
            }    
        }
        return false;
    }

    /** */
    public function onInvalidRequest(FlashMessagesEvent $event)
    {
        if ($event->isValid()) {
            $flash = $event->flash()->flashMessage('Invalid Request.', $event->flash()->flashWarning());
            if ($flash) {
                return $flash;
            }    
        }
        return false;
    }

}