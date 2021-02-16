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

use MagmaCore\Auth\Authorized;
use App\Event\FlashMessagesEvent;
use MagmaCore\EventDispatcher\EventSubscriberInterface;

class FlashMessagesSubscriber implements EventSubscriberInterface
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
            FlashMessagesEvent::NAME => ['onSuccessOrFailAction'],
        ];

    }

    public function onSuccessOrFailAction(FlashMessagesEvent $event)
    {
        if (!empty($event->get()->thisRouteAction())) {
            switch ($event->get()->thisRouteAction()):
                case 'new':
                    list(
                        $flash,
                        $redirect,
                        $type) = $this->onNewAction($event);
                    break;
                case 'edit':
                    list(
                        $flash,
                        $redirect,
                        $type) = $this->onEditAction($event);
                    break;
                case 'delete':
                    list(
                        $flash,
                        $redirect,
                        $type) = $this->onDeleteAction($event);
                    break;
                case 'register' :
                    list(
                        $flash,
                        $redirect,
                        $type) = $this->onRegisterAction($event);
                    break;
                case 'login' :
                list(
                    $flash,
                    $redirect,
                    $type) = $this->onLoginAction($event);
                    break;
            endswitch;
            
            if (is_array($flash) && count($flash) > 0) {
                $event->get()->flashMessage(count($flash) . " Error<br>" . implode('<br>', $flash), $type);
            } else {
                $event->get()->flashMessage($flash, $type);
            }
            $event->get()->redirect(Authorized::getReturnToPage());
        }
    }

    public function onNewAction(Object $event)
    {
        if ($event->isValid()['action'] === true) {
            $flash = $event->get()->locale('new_successful');
            if ($flash) {
                return [
                    $flash,
                    $event->get()->selfPath('new'),
                    "success"
                ];
            }
        } else {
            $flash = $event->isvalid()['errors'];
            if ($flash) {
                return [
                    $flash,
                    $event->get()->selfPath('new'),
                    "warning"
                ];
            }

        }
    }

    public function onEditAction(Object $event)
    {
        if ($event->isValid()['action'] === true) {
            $flash = $event->get()->locale('changes_saved');
            if ($flash) {
                return [
                    $flash,
                    $event->get()->selfPath('edit'),
                    "success"
                ];
            }
        } else {
            $flash = $event->isvalid()['errors'];
            if ($flash) {
                return [
                    $flash,
                    $event->get()->selfPath('edit'),
                    "warning"
                ];
            }

        }
    }

    public function onDeleteAction(Object $event)
    {
        if ($event->isValid()['action'] === true) {
            $flash = $event->get()->locale('item_deleted');
            if ($flash) {
                return [
                    $flash,
                    $event->get()->selfPath('index'),
                    "success"
                ];
            }
        } else {
            $flash = $event->isvalid()['errors'];
            if ($flash) {
                return [
                    $flash,
                    $event->get()->selfPath('index'),
                    "warning"
                ];
            }

        }
    }

    public function onRegisterAction(Object $event)
    {
        if ($event->isValid()['action'] === true) {
            $flash = $event->get()->locale('new_user_added');
            if ($flash) {
                return [
                    $flash,
                    "/register",
                    "success"
                ];
            }
        } else {
            $flash = $event->isvalid()['errors'];
            if ($flash) {
                return [
                    $flash,
                    "/register",
                    "warning"
                ];
            }

        }
    }

    public function onLoginAction(Object $event)
    {
        if ($event->isValid()['action'] === true) {
            $flash = "Welcome Back";
            if ($flash !=='') {
                return [
                    $flash,
                    "/login",
                    "success"
                ];
            }
        } else {
            $flash = $event->isvalid()['errors'];
            if ($flash) {
                return [
                    $flash,
                    "/login",
                    "warning"
                ];
            }

        }
    }


}
