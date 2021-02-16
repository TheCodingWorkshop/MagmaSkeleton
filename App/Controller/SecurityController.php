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

namespace App\Controller;

use LoaderError;
use SyntaxError;
use RuntimeError;
use MagmaCore\Auth\Authorized;
use App\Event\FlashMessagesEvent;
use MagmaCore\Base\BaseController;

class SecurityController extends BaseController
{

    protected bool $isLoggedIn = false;

    /**
     * Extends the base constructor method. Which gives us access to all the base
     * methods inplemented within the base controller class.
     * Class dependency can be loaded within the constructor by calling the
     * container method and passing in an associative array of dependency to use within
     * the class
     *
     * @param array $routeParams
     * @return void
     * @throws BaseInvalidArgumentException
     */
    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);
        /**
         * Dependencies are defined within a associative array like example below
         * [ userModel => \App\Model\UserModel::class ]. Where the key becomes the
         * property for the userModel object like so $this->userModel->getRepo();
         */
        $this->container(
            [
                "loginForm" => \App\Forms\Client\Security\LoginForm::class,
                "authenticator" => \MagmaCore\Auth\Authenticator::class,
            ]
        );
    }

    /**
     * Middleware which are executed before any action methods is called
     * middlewares are return within an array as either key/value pair. Note
     * array keys should represent the name of the actual class its loading ie
     * upper camel case for array keys. alternatively array can be defined as
     * an index array omitting the key entirely
     *
     * @return array
     */
    protected function callBeforeMiddlewares(): array
    {
        return [
            'HasConnection' => \App\Middleware\Before\HasConnection::class,
            'isUserAccountActivated' => \App\Middleware\Before\isUserAccountActivated::class,
            'isAlreadyLogin' => \App\Middleware\Before\isAlreadyLogin::class,
        ];
    }

    /**
     * Middleware which are executed before any action methods is called
     * middlewares are return within an array as either key/value pair. Note
     * array keys should represent the name of the actual class its loading ie
     * upper camel case for array keys. alternatively array can be defined as
     * an index array omitting the key entirely
     *
     * @return array
     */
    protected function callAfterMiddlewares(): array
    {
        return [
            'SessionExpiresCleanUp' => \App\Middleware\After\SessionExpiresCleanUp::class,
        ];
    }


    /**
     * Entry method which is hit on request. This method should be implement within
     * all sub controller class as a default landing point when a request is
     * made.
     *
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function indexAction()
    {

        if (isset($this->loginForm)) {
            $this->render(
                "client/security/index.html.twig",
                [
                    "form" => $this->loginForm->createForm("/security/login"),
                ]
            );
        }
    }

    /**
     * Security login process.
     *
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function loginAction()
    {
        if (isset($this->formBuilder)) :
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('signin')) {
                if ($this->formBuilder->csrfValidate()) {
                    if ($this->getAuthUser()) {
                        $this->getLogin($this->getAuthUser(), $this->isRememberingLogin());
                        if ($this->error) {
                            $this->error->addError($this->authenticator->getErrors(), $this)->dispatchError($this->onSelf());
                        }
                        if ($this->authenticator->getAction() === true) {
                            $this->flashMessage('Login Successfully');
                            $this->redirect(Authorized::getReturnToPage());
                        }
                    }
                } else {
                    $this->isLoggedIn = false;
                    $this->flashMessage($this->locale('fail_csrf_validation', $this->flashDanger()));
                    $this->redirect($this->onSelf());
                }
            }
        endif;
    }

    /**
     * Authorized logging out the current user. This will destroy the entire user
     * session and clear the remembered_logins database table of any cookies
     *
     * @return void
     */
    protected function logoutAction(): void
    {
        $this->render("client/security/logout.html.twig");
    }

    protected function doLogoutAction(): void
    {
        if (isset($this->formBuilder)) {
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('signout')) {
                Authorized::logout();
                $this->redirect("/security/show-logout-message");
            }
        }
        $this->render("client/security/logout.html.twig");
    }


    /**
     * Show a "logged out" flash message and redirect to the homepage.
     * Necessary to use the flash messages as they use the session and
     * at the end of the logout method (destroyAction) the session is destroyed
     * so a new action needs to be called in order to use the session.
     *
     * @return void
     * @throws Exception
     */
    protected function showLogoutMessageAction()
    {
        $this->flashMessage('Youv\'e successfully logged out', $this->flashInfo());
        $this->redirect('/');
    }

    /**
     * Returns the required user object or returns an array of errors if the user
     * object doesn't exists or if the credentials typed in is not correct
     *
     * @return mixed
     */
    private function getAuthUser()
    {
        $user = $this->authenticator
            ->authenticate(
                $this->request->handler()->get('email'),
                $this->request->handler()->get('password_hash'),
                $this
            );

        if (!$user) {
            $actionEvent = [
                'action' => $this->authenticator->getAction(),
                'errors' => $this->authenticator->getErrors()
            ];
            if ($this->eventDispatcher) {
                $this->eventDispatcher->dispatch(new FlashMessagesEvent($actionEvent, $this), FlashMessagesEvent::NAME);
            }
        }

        return $user;
    }

    /**
     * Carry out other actions if the remember_me checkbox was checked.
     *
     * @return boolean
     */
    private function isRememberingLogin()
    {
        $remember = $this->request->handler()->get('remember_me');
        if ($remember) {
            return $remember;
        }
    }

    /**
     * Returns the authenticated user as an object
     *
     * @param Object $authenticatedUser - returns the authicated user Object
     * @param bool $remember
     * @return void
     */
    private function getLogin(Object $authenticatedUser, mixed $remember): void
    {
        Authorized::login($authenticatedUser, $remember);
    }
}
