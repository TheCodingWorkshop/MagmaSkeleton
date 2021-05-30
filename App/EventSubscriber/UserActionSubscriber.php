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

use App\Model\UserRoleModel;
use MagmaCore\Base\BaseView;
use App\Event\NewActionEvent;
use App\Event\UserActionEvent;
use App\Model\UserMetaDataModel;
use MagmaCore\Mailer\MailerFacade;
use MagmaCore\EventDispatcher\EventDispatcherTrait;
use MagmaCore\Base\Contracts\BaseActionEventInterface;
use MagmaCore\EventDispatcher\EventSubscriberInterface;

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

    private MailerFacade $mailer;
    private BaseView $view;

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
     * Main constructor class
     *
     * @param MailerFacade $mailer
     * @param BaseView $view
     * @return void
     */
    public function __construct(MailerFacade $mailer, BaseView $view)
    {
        $this->mailer = $mailer;
        $this->view = $view;
    }

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
                ['assignedUserRole'],
                ['createUserLog'],
                ['sendActivationEmail'],
            ]
        ];
    }

    /**
     * Event flash allows flashing of any specified route defined with the ACTION_ROUTES constants
     * one can declare a message and a default route. if a default route isn't 
     * set then the script will
     * 
     * redirect back on it self using the onSelf() method. Delete route is automatically filtered to 
     * redirect back to the index page. As this is the only logical route to redirect to. after we
     * remove the object. failure to comply with this will result in 404 error as the script will
     * try to redirect to an object that no longer exists.
     * 
     * @param object $event
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
     * Undocumented function
     *
     * @param BaseActionEventInterface $event
     * @param array $user
     * @return string
     */
    private function templateMessage(BaseActionEventInterface $event, array $user): string
    {
        $link = $event->getObject()->getSiteUrl('/activation/activate/' . $user['activation_hash']);
        $html = '<div>';
        $html .= '<h1>Activate Your Account!</h1>';
        $html .= isset($user['random_pass']) ? '<p><strong>Temporary Password: </strong>' . $user['random_pass'] . '</p>' : '';
        $html .= 'Thanks for registering on LavaStudio. Please click the activation button below to activate your account in order to access your profile page.';
        $html .= '<a href="' . $link . '">Activate Now</a>';
        $html .= '</div>';
        return $html;
    }

    /**
     * Send an activation email to the registered email address each time a user
     * register for a new account.
     *
     * @param UserActionEvent $event
     * @return void
     */
    public function sendActivationEmail(UserActionEvent $event)
    {
        if ($this->onRoute($event, self::NEW_ACTION) || $this->onRoute($event, self::REGISTER_ACTION)) {
            if ($event) {
                $user = $event->getcontext();
                if (is_array($user) && count($user) > 0) {
                    $mail = $this->mailer->basicMail(
                        'New Account',
                        'admin@example.com',
                        $user['email'],
                        $this->templateMessage($event, $user)
                    );
                    if ($mail) {
                        return true;
                    }
                }
            }
        }
    }

    /**
     * Initialize a user log when a brand new user is created. Either from the
     * admin panel or created from the application front end. User log contains
     * meta data ie snail trail of a user activitie across the application
     *
     * @param UserActionEvent $event
     * @return bool
     */
    public function createUserLog(UserActionEvent $event): bool
    {
        if ($this->onRoute($event, self::NEW_ACTION) || $this->onRoute($event, self::REGISTER_ACTION)) {
            if ($event) {
                $user = $event->getContext();
                if ($user) {
                    $userLog = new UserMetaDataModel();
                    if ($userLog) {
                        $onLogin = ['last_login' => NULL, 'login_from' => NULL];
                        $onLogout = ['last_logout' => NULL, 'logout_from' => NULL];
                        $onBruteForce = ['failed_logins' => NULL, 'failed_login_timestamp' => NULL];
                        $push = $userLog->getRepo()
                            ->getEm()
                            ->getCrud()
                            ->create(
                                [
                                    'user_id' => $user['last_id'],
                                    'user_browser' => serialize(get_browser()),
                                    'login' => serialize($onLogin),
                                    'logout' => serialize($onLogout),
                                    'brute_force' => serialize($onBruteForce)
                                ]
                            );

                        return ($push) ? true : false;
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
