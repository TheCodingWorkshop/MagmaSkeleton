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

use App\Event\RegistrationActionEvent;
use App\Model\UserMetaDataModel;
use Exception;
use JetBrains\PhpStorm\ArrayShape;
use MagmaCore\Base\BaseView;
use MagmaCore\Base\Contracts\BaseActionEventInterface;
use MagmaCore\EventDispatcher\EventDispatcherTrait;
use MagmaCore\EventDispatcher\EventSubscriberInterface;
use MagmaCore\Mailer\Exception\MailerException;
use MagmaCore\Mailer\MailerFacade;

/**
 * Note: If we want to flash other routes then they must be declared within the ACTION_ROUTES
 * protected constant
 */
class RegistrationActionSubscriber implements EventSubscriberInterface
{

    use EventDispatcherTrait;
    private MailerFacade $mailer;
    private BaseView $view;


    /** @var int - we want this to execute last so it doesn't interrupt other process */
    private const FLASH_MESSAGE_PRIORITY = -1000;

    /**
     * Add other route index here in order for that route to flash properly. this array is index array
     * which means the first item starts at 0. See ACTION_ROUTES constant for correct order of how to
     * load other routes for flashing
     * @var int
     */
    protected const INDEX_ACTION = 'registered';

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
     * Subscribe multiple listeners to listen for the NewActionEvent. This will fire
     * each time a new user is added to the database. Listeners can then perform
     * additional tasks on that return object.
     *
     * @return array
     */
    #[ArrayShape([RegistrationActionEvent::NAME => "array"])] public static function getSubscribedEvents(): array
    {
        return [
            RegistrationActionEvent::NAME => [
                ['flashLoginEvent', self::FLASH_MESSAGE_PRIORITY],
                ['sendRegistrationActivationEmail'],
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
     * @param RegistrationActionEvent $event
     * @return void
     * @throws Exception
     */
    public function flashLoginEvent(RegistrationActionEvent $event)
    {
        $this->flashingEvent(
            $event,
            $this->trailingRoutes($event),
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
     * @param RegistrationActionEvent $event
     * @return bool
     * @throws MailerException
     */
    public function sendRegistrationActivationEmail(RegistrationActionEvent $event): bool
    {
        if ($this->onRoute($event, 'register')) {
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
        return false;
    }


}
