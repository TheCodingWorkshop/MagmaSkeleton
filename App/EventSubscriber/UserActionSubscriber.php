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

use MagmaCore\Base\BaseView;
use App\Event\NewActionEvent;
use App\Event\UserActionEvent;
use MagmaCore\Mailer\MailerFacade;
use MagmaCore\Auth\Model\UserRoleModel;
use MagmaCore\EventDispatcher\EventSubscriberInterface;
use MagmaCore\EventDispatcher\EventDispatcherTrait;

/**
 * Note: If we want to flash other routes then they must be declared within the ACTION_ROUTES
 * protected constant
 */
class UserActionSubscriber implements EventSubscriberInterface
{

    use EventDispatcherTrait;

    /** @var int - we want this to execute last so it doesn't interupt other process */
    private const FLASH_MESSAGE_PRIOIRTY = -1000;
    /** @var string - default flash message */
    private const FLASH_DEFAULT = '<strong class="">Attention!</strong> This is a default message';
    /** @var string */
    protected const REDIRECT_DELETE = '/admin/user/index';

    /**
     * Add other route index here in order for that route to flash properly. this array is index array
     * which means the first item starts at 0. See AcTION_ROUTES constant for correct order of how to 
     * load other routes for flashing
     * @var int
     */
    protected const NEW_ACTION = 'new';
    protected const EDIT_ACTION = 'edit';
    protected const DELETE_ACTION = 'delete';
    protected const BULK_ACTION = 'bulk';
    protected const REGISTER_ACTION = 'register';

    /**
     * Subscibe multiple listeners to listen for the NewActionEvent. This will fire
     * each time a new user is added to the database. Listeners can then perform
     * addtitional tasks on that return object.
     *
     * @return array
     */
    public static function getSubscribedEvents(): array
    {
        return [
            UserActionEvent::NAME => [
                ['flashUserEvent', self::FLASH_MESSAGE_PRIOIRTY],
                ['sendActivationEmail'],
                ['assignedUserRole'],
            ]
        ];
    }

    /**
     * Event flash allows flashing of any specified route defined with the ACTION_ROUTES constants
     * one can declare a message and a default route. if a default route isn't set then the script will 
     * redirect back on it self using the onSelf() method. Delete route is automatically filtered to 
     * redirect back to the index page. As this is the only logical route to redirect to. after we
     * remove the object. failure to comply with this will result in 404 error as the script will
     * try to redirect to an object that no longer exists.
     * 
     * @param Object $event
     * @param string $msg
     * @param string|null $redirect
     * @return void
     */
    public function flashUserEvent(UserActionEvent $event)
    {
        $this->flashingEvent(
            $event, 
            $this->trailingRoutes($event), 
            self::FLASH_DEFAULT
        );
    }

    /**
     * Send an activation email to the registered email address each time a user
     * register for a new account.
     *
     * @param NewActionEvent $event
     * @return void
     */
    public function sendActivationEmail(UserActionEvent $event)
    {
        if ($this->onRoute($event, self::NEW_ACTION) || $this->onRoute($event, self::REGISTER_ACTION)) {
            if ($event) {
                $user = $event->getcontext();
                if (is_array($user) && count($user) > 0) {
                    $mail = (new MailerFacade())->basicMail(
                        "New Account",
                        "admin@example.com",
                        $user['email'],
                        'testing'
                        // (new BaseView())->getTemplate(
                        //     "client/registration/email_template.html.twig",
                        //     [
                        //         "activation_link" => $event->getObject()->getSiteUrl("/activation/activate/" . $user['activation_hash']),
                        //         "accountee_name" => $user['firstname'] . " " . $user['lastname'],
                        //         "website" => "LavaStudio",
                        //         "random_pass" => $user['random_pass'] ? $user['random_pass'] : []
                        //     ]
                        // )
                    );
                    if ($mail) {
                        return true;
                    }
                }
            }
        }
    }

    /**
     * Assign the user the subscriber role on public registration and assigned
     * the selected role from the admin panel
     *
     * @param NewActionEvent $event
     * @return void
     */
    public function assignedUserRole(UserActionEvent $event)
    {
        if ($this->onRoute($event, self::NEW_ACTION)) {
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
}
