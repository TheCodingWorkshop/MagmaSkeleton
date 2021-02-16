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

use App\Event\NewUserEvent;
use MagmaCore\Base\BaseView;
use MagmaCore\Mailer\MailerFacade;
use MagmaCore\Auth\Model\UserRoleModel;
use MagmaCore\EventDispatcher\EventSubscriberInterface;

class NewUserSubscriber implements EventSubscriberInterface
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
            NewUserEvent::NAME => [
                ['sendActivationEmail', -10],
                ['assignedUserRole', 20],
            ],
        ];

    }
    
    /**
     * Send an activation email to the registered email address each time a user 
     * register for a new account.
     *
     * @param NewUserEvent $event
     * @return void
     */
    public function sendActivationEmail(NewUserEvent $event)
    {
        if ($event) {
            $user = $event->getcontext();
            if (is_array($user) && count($user) > 0) {
                $mail = (new MailerFacade())->basicMail(
                    "New Account",
                    "admin@example.com",
                    $user['email'],
                    (new BaseView())->getTemplate(
                        "client/registration/email_template.html.twig",
                            [
                                "activation_link" => $event->getObject()->getSiteUrl("/activation/activate/" . $user['activation_hash']),
                                "accountee_name" => $user['firstname'] . " " . $user['lastname'],
                                "website" => "LavaStudio",
                                "random_pass" => $user['random_pass'] ? $user['random_pass'] : []
                            ]
                        )
                );
                if ($mail) {
                    return true;
                }
            }
        }
    }

    /**
     * Assign the user the subscriber role on public registration and assigned
     * the selected role from the admin panel
     *
     * @param NewUserEvent $event
     * @return void
     */
    public function assignedUserRole(NewUserEvent $event)
    {
        if ($event) {
            $user = $event->getContext();
            if (is_array($user) && count($user) > 0 && !empty($user['role_id'])) {
                $userRole = new UserRoleModel();
                if ($userRole) {
                    $push = $userRole->getRepo()
                    ->getEm()
                    ->getCrud()
                    ->create(['user_id' => $user['last_id'], 'role_id' => $user['role_id']]);
                    return ($push) ? true : false;
                }
            }
        }
    }


}
