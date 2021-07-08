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

namespace App\Controller\Profile;

use App\Entity\UserEntity;
use App\Event\UserActionEvent;
use App\Forms\Profile\DeleteAccountForm;
use App\Forms\Profile\EditEmailForm;
use App\Forms\Profile\EditNameForm;
use App\Forms\Profile\EditPasswordForm;
use App\Middleware\Before\AuthorizedIsNull;
use App\Middleware\Before\isAlreadyLogin;
use App\Middleware\Before\LoginRequired;
use App\Middleware\Before\SessionExpires;
use App\Model\UserProfileModel;
use App\Repository\ActivationRepository;
use JetBrains\PhpStorm\ArrayShape;
use MagmaCore\Auth\Roles\PrivilegedUser;
use MagmaCore\Base\BaseController;
use MagmaCore\Base\Domain\Actions\EditAction;
use MagmaCore\Base\Domain\Actions\ShowAction;
use MagmaCore\Base\Exception\BaseInvalidArgumentException;

/**
 * This class is responsible for allowing the user to control and edit their user account
 * i.e users can update their name, email address and change their password. Upon changing
 * their email address they will be automatically logged out and will be prompt to reactivate
 * their account again. For added security. Activation token is valid for 1 hour by default
 */
class AccountController extends BaseController
{

    /**
     * Extends the base constructor method. Which gives us access to all the base
     * methods implemented within the base controller class.
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
                'repository' => UserProfileModel::class,
                'entity' => UserEntity::class,
                'activateRepo' => ActivationRepository::class,
                'editNameForm' => EditNameForm::class,
                'editEmailForm' => EditEmailForm::class,
                'editPasswordForm' => EditPasswordForm::class,
                'deleteAccount' => DeleteAccountForm::class,
                'showAction' => ShowAction::class,
                'editAction' => EditAction::class,

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
    #[ArrayShape(['AuthorizedIsNull' => "string", 'LoginRequired' => "string", 'SessionExpires' => "string", 'isAlreadyLogin' => "string"])] protected function callBeforeMiddlewares(): array
    {
        return [
            'AuthorizedIsNull' => AuthorizedIsNull::class,
            'LoginRequired' => LoginRequired::class,
            'SessionExpires' => SessionExpires::class,
            'isAlreadyLogin' => isAlreadyLogin::class,
        ];
    }

    /**
     * Return the current user object based on the current session ID
     *
     * @return Object
     */
    public function findOr404(): object
    {
        return $this->repository
            ->getRepo()
            ->findAndReturn($this->getSession()->get('user_id') ?? 0)
            ->or404();
    }

    /**
     * Entry method which is hit on request. This method should be implement within
     * all sub controller class as a default landing point when a request is
     * made.
     */
    protected function indexAction()
    {
        $this->showAction
            ->execute($this, NULL, NULL, NULL, __METHOD__)
            ->render()
            ->with()
            ->singular()
            ->end();
    }

    /**
     * Update the user first and lastname from their user account page. Renders the form
     * which allows updating account.
     */
    protected function nameAction()
    {
        $this->editAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with(['profile' => $this->findOr404(), 'app_name' => 'LavaStudio'])
            ->form($this->editNameForm)
            ->end();
    }

    /**
     * Update the user email address from their user account page. Renders the form
     * which allows updating account.
     */
    protected function emailAction()
    {
        $this->editAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__, ['password_required'])
            ->render()
            ->with(['app_name' => 'LavaStudio'])
            ->form($this->editEmailForm)
            ->end();
    }

    /**
     * Update the user password from their user account page. Renders the form
     * which allows updating account.
     */
    protected function passwordAction()
    {
        $this->editAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__, ['password_equal'])
            ->render()
            ->with()
            ->form($this->editPasswordForm)
            ->end();
    }

    /**
     * Allow the user to delete their own account from their accounts page. Renders the formB
     * which allows removing account.
     */
    protected function deleteAction()
    {
        $this->deleteAction
            ->execute($this, NULL, UserActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form($this->deleteAccount)
            ->end();
    }
}
