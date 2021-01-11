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
            FlashMessagesEvent::NAME => ['onSuccessOrFailAction']
            
        ];

    }

    public function onSuccessOrFailAction(FlashMessagesEvent $event)
    {
        if (!empty($event->get()->thisRouteAction())) {
            switch ($event->get()->thisRouteAction()) :
                case 'new' :
                        list(
                            $flash, 
                            $redirect) = $this->onNewAction($event);
                    break;
                case 'edit' :
                    list(
                        $flash, 
                        $redirect) = $this->onEditAction($event);
                break;   
                case 'delete' :
                    list(
                        $flash, 
                        $redirect) = $this->onDeleteAction($event);
                break;         
            endswitch;
            $event->get()->flashMessage($flash);
            //$event->get()->redirect($redirect);
        }
    }

    
    public function onNewAction(Object $event)
    {
        if ($event->isValid()) {
            $flash = $event->get()->locale('new_successful');
            if ($flash) {
                return [
                    $flash,
                    "/admin/user/new"
                ];
            }
        }
    }

    public function onEditAction(Object $event)
    {
        if ($event->isValid()) {
            $flash = $event->get()->locale('changes_saved');
            if ($flash) {
                return [
                    $flash,
                    "/admin/user/{$event->get()->thisRouteID()}/edit"
                ];
           }
        }
    }

    public function onDeleteAction(Object $event)
    {
                          /*if ($event->isValid()) {
            $flash = $event->get()->locale('item_deleted');
            if ($flash) {
                return [
                    $flash,
                    "/admin/user/index"
                ];
            }
        }*/
    }


}