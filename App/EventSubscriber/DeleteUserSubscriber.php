<?php
/*
 * This file is part of the MagmaCore package.
 *
 * (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
declare (strict_types = 1);

namespace App\EventSubscriber;

use App\Event\DeleteUserEvent;
use MagmaCore\EventDispatcher\EventSubscriberInterface;

class DeleteUserSubscriber implements EventSubscriberInterface
{

    /**
     * Subscibe multiple listeners to listen for the NewUserEvent. This will fire
     * each time a new user is added to the database. Listeners can then perform
     * addtitional tasks on that return object.
     *
     * @return array
     */
    public static function getSubscribedEvents(): array
    {
        return [
            DeleteUserEvent::NAME => [
                ['flashMessageEvent', -1000],
            ],
        ];

    }

    public function flashMessageEvent(DeleteUserEvent $event)
    {
        if ($event) {
            $event->getObject()->flashMessage('User Account deleted!');
            $event->getObject()->redirect('/admin/user/index');
        }
    }



}
