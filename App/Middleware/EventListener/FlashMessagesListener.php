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

namespace App\EventListener;

use App\Event\FlashMessagesEvent;

class FlashMessagesListener
{
    /**
     * New user event dispatcher. Which pipes the user object arguement to 
     * the class property
     *
     * @param UserModel $user
     * @return void
     */
    public function onSubmissonSuccessOrOtherWise(FlashMessagesEvent $event)
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
                $event->get()->redirect($redirect);
            }
        }
    }

}