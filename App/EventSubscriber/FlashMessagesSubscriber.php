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

    const SUCCESS_MSG = 'Successful';
    const UPDATE_MSG = 'Updated';
    const DELETE_MSG = 'Deleted';

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
            /* What action route */
            if (!empty($event->get()->thisRouteAction())) {
                switch ($event->get()->thisRouteAction()) :
                    case 'new' :
                        $locale = $event->get()->locale('new_success');
                        $redirect = $event->get()->onSelf();
                        break;
                endswitch;

                $event->get()->flashMessage($locale);
                $event->get()->redirect('/admin/user/index');
            }
        }
    }


}