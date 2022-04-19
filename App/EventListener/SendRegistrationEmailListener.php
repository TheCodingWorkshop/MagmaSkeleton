<?php
/*
 * This file is part of the MagmaCore package.
 *
 * (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace App\EventListener;

use App\Event\UserActionEvent;
use MagmaCore\EventDispatcher\EventDispatcherTrait;

final class SendRegistrationEmailListener
{

    use EventDispatcherTrait;

    public const NAME = 'app.event.listener.send_registration_email_listener';

    public function __invoke(UserActionEvent $event)
    {
//        if ($this->onRoute($event, 'new') || $this->onRoute($event, 'register')) {
//            if ($event) {
//                $user = $event->getcontext();
//                if (is_array($user) && count($user) > 0) {
//                    $mail = (new MailerFacade())->basicMail(
//                        'New Account',
//                        'admin@example.com',
//                        $user['email'],
//                        'testing'(new BaseView())->templateRender(
//                        'client/registration/email_template.html',
//                        [
//                            'activation_link' => $event->getObject()->getSiteUrl('/activation/activate/' . $user['activation_hash']),
//                            'accountee_name' => $user['firstname'] . " " . $user['lastname'],
//                            'website' => 'LavaStudio',
//                            'random_pass' => $user['random_pass'] ? $user['random_pass'] : []
//                        ]
//                    )
//                    )
//                    if ($mail) {
//                        return true;
//                    }
//                }
//            }
//        }
    }
}
