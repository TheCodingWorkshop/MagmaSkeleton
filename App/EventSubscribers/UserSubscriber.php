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
use App\Event\NewUserEvent;

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
            NewUserEvent::NAME =>
            [
                ['onUserRegistrationAction', 2],
                ['']
            ]
        ];

    }

    /** */
    public function onUserRegistrationAction(NewUserEvent $event)
    {
        $user = $event->getUser();
    }

}