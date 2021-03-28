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
use MagmaCore\Utility\Yaml;
use App\Event\LoginActionEvent;
use MagmaCore\Base\BaseController;
use App\Middleware\Before\isAlreadyLogin;
use App\Middleware\After\SessionExpiresCleanUp;
use App\Middleware\Before\isUserAccountActivated;

class SecurityController extends BaseController
{

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
        $this->diContainer(
            [
                'loginForm' => \App\Forms\Client\Security\LoginForm::class,
                'logoutForm' => \App\Forms\Client\Security\LogoutForm::class,
                'authenticator' => \MagmaCore\Auth\Authenticator::class,
                'loginAction' => \MagmaCore\Base\Domain\Actions\LoginAction::class,
                'logoutAction' => \MagmaCore\Base\Domain\Actions\LogoutAction::class,
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
            'isUserAccountActivated' => isUserAccountActivated::class,
            'isAlreadyLogin' => isAlreadyLogin::class,
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
            'SessionExpiresCleanUp' => SessionExpiresCleanUp::class,
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
        $this->loginAction
            ->execute($this, NULL, LoginActionEvent::class, __METHOD__)
                ->render()
                    ->with()
                        ->form($this->loginForm)
                            ->end();

    }

    /**
     * Authorized logging out the current user. This will destroy the entire user
     * session and clear the remembered_logins database table of any cookies
     *
     * @return void
     */
    protected function logoutAction(): void
    {
        $this->logoutAction
            ->execute($this, NULL, LoginActionEvent::class, __METHOD__)
                ->render()
                    ->with()
                        ->form($this->logoutForm)
                            ->end();
    }

}
