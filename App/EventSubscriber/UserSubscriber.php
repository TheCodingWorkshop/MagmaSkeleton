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
use App\Event\NewUserEvent;
use App\Event\UserEdittedEvent;
use App\Event\UserDeletedEvent;


class UserSubscriber implements EventSubscriberInterface
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
            NewUserEvent::NAME => ['onUserCreatedAction'],
            UserDeletedEvent::NAME => ['onUserDeletedAction', 300],
            UserEdittedEvent::NAME =>['onUserEdittedAction', -255],
        ];

    }

    /** @Listener */
    public function onUserCreatedAction(?NewUserEvent $event = null)
    {
        $user = $event->getUser();
        var_dump($user);
    }

    public function onUserEdittedAction(?UserEdittedEvent $event = null)
    { 
        echo $event->getUser();
    }

    public function onUserDeletedAction(?UserDeletedEvent $event = null)
    { 
        echo $event->getUser();
    }



}