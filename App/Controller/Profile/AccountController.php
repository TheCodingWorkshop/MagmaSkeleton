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

use LoaderError;
use SyntaxError;
use RuntimeError;
use App\Entity\UserEntity;
use MagmaCore\Base\BaseController;

/**
 * This class is reponsible for allowing the user to control and edit their user account 
 * i.e users can update their name, email address and change their password. Upon changing 
 * their email address they will be automatically logged out and will be prompt to reactivate
 * their account again. For added security. Activation token is valid for 1 hour by default
 */
class AccountController extends BaseController
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
                "repository" => \App\Model\UserProfileModel::class,
                "activationRepo" => \App\Repository\ActivationRepository::class,
                "editNameForm" => \App\Forms\Client\Profile\EditNameForm::class,
                "editEmailForm" => \App\Forms\Client\Profile\EditEmailForm::class,
                "editPasswordForm" => \App\Forms\Client\Profile\EditPasswordForm::class,
                "deleteAccount" => \App\Forms\Client\Profile\DeleteAccountForm::class,
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
            'AuthorizedIsNull' => \App\Middleware\Before\AuthorizedIsNull::class,
            'LoginRequired' => \App\Middleware\Before\LoginRequired::class,
            'SessionExpires' => \App\Middleware\Before\SessionExpires::class,
            'isAlreadyLogin' => \App\Middleware\Before\isAlreadyLogin::class,
        ];
    }

    /**
     * Returns the user entity object
     *
     * @return Object
     */
    public function userEntity() : UserEntity
    {
        $entity = new UserEntity($this->formBuilder->getData());
        if ($entity) {
            return $entity;
        }
    }

    /**
     * Return the current user object based on the current session ID
     *
     * @return Object
     */
    protected function findUserOr404(): Object
    {
        return $this->repository
            ->getRepo()
            ->findAndReturn($_SESSION['user_id'])
            ->or404();
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
        $this->render(
            'client/profile/index.html.twig',
            [
                "profile" => $this->findUserOr404()
            ]
        );
    }

    /**
     * Update the user first and lastname from their user account page. Renders the form
     * which allows updating account.
     * 
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function editNameAction()
    {
        if (isset($this->formBuilder)) {
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('edit-profile-name')) {
                if ($this->formBuilder->csrfValidate()) {
                    list(
                        $validatedData,
                        $errors
                    ) = $this->repository->updateProfileNameOnceValidated($this->userEntity(),$this->findUserOr404());
                    if ($this->error) {
                        $this->error->addError($errors, $this)->dispatchError($this->onSelf());
                    }
                    $updated = $this->repository
                        ->getRepo()
                        ->findByIDAndUpdate($validatedData, $this->findUserOr404()->id);
                    if ($updated) {
                        $this->flashMessage('Changes Saved!');
                        $this->redirect($this->onSelf());
                    }
                }
            }
        }
        $this->render(
            'client/profile/edit_name.html.twig',
            [
                "profile" => $this->findUserOr404(),
                "formName" => $this->editNameForm->createForm($this->onSelf(), $this->findUserOr404()),
                "app_name" => "LavaStudio"
            ]
        );
    }

    /**
     * Update the user email address from their user account page. Renders the form
     * which allows updating account.
     * 
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function editEmailAction()
    {
        if (isset($this->formBuilder)) {
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('edit-profile-email')) {
                if ($this->formBuilder->csrfValidate()) {
                    if ($this->repository->verifyPassword($this, $this->findUserOr404()->id)) {
                        list(
                            $validatedData,
                            $errors
                        ) = $this->repository->updateProfileEmailOnceValidated($this->userEntity(),$this->findUserOr404());
                        if ($this->error) {
                            $this->error->addError($errors, $this)->dispatchError($this->onSelf());
                        }
                        $action = $this->repository
                            ->getRepo()
                            ->findByIdAndUpdate($validatedData, $this->findUserOr404()->id);
                        $this->flashAndRedirect($action, null, 'Changes Saved!');
                    } else {
                        $this->flashAndRedirect(false, null, 'Incorrect Password for this account.!', 'warning');
                    }
                }
            }
        }
        $this->render(
            'client/profile/edit_email.html.twig',
            [
                "profile" => $this->findUserOr404(),
                "formEmail" => $this->editEmailForm->createForm($this->onSelf(), $this->findUserOr404()),
                "app_name" => "LavaStudio"
            ]
        );
    }

    /**
     * Update the user password from their user account page. Renders the form
     * which allows updating account.
     * 
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function editPasswordAction()
    {
        if (isset($this->formBuilder)) {
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('edit-profile-password')) {
                if ($this->formBuilder->csrfValidate()) {
                    if ($this->repository->verifyPassword($this, $this->findUserOr404()->id)) {
                        if ($this->repository->isPasswordMatching($this, $this->userEntity())) {
                            list(
                                $validatedData,
                                $error
                            ) = $this->repository->updateProfilePasswordOnceValidated($this->userEntity(),$this->findUserOr404());
                            if ($this->erorr) {
                                $this->error->addError($error, $this)->dispatchError($this->onSelf());
                            }
                            $action = $this->repository
                                ->getRepo()
                                ->findByIdAndUpdate($validatedData, $this->findUserOr404()->id);
                            $this->flashAndRedirect($action, null, 'Changes Saved!');
                        } else {
                            $this->flashAndRedirect(false, null, 'Oops! Password did not match! Try again.', 'warning');
                        }
                    } else {
                        $this->flashAndRedirect(false, null, 'Incorrect Password for this account.!', 'warning');
                    }
                }
            }
        }
        $this->render(
            'client/profile/edit_password.html.twig',
            [
                "profile" => $this->findUserOr404(),
                "formPassword" => $this->editPasswordForm->createForm("/profile/account/edit-password", $this->findUserOr404()),
                "app_name" => "LavaStudio"
            ]
        );
    }

    /**
     * Allow the user to delete their own account from their accounts page. Renders the formB
     * which allows removing account.
     * 
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function deleteAction()
    {
        if (isset($this->formBuilder)) {
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('delete-profile')) {
                if ($this->formBuilder->csrfValidate()) {
                    if ($this->repository->isOwnAccount($this)) {
                        list(
                            $validatedData,
                            $error
                        ) = $this->repository->deleteAccountOnceValidated($this->userEntity(),$this->findUserOr404());
                        if ($this->erorr) {
                            $this->error->addError($error, $this)->dispatchError($this->onSelf());
                        }
                        $action = $this->repository->getRepo()->findByIdAndDelete($validatedData);
                        $this->flashAndRedirect($action, '/', 'Account deleted successfully.');
                    }
                }
            }
        }
        $this->render(
            'client/profile/delete_account.html.twig',
            [
                "profile" => $this->findUserOr404(),
                "deleteAccount" => $this->deleteAccount->createForm("/profile/account/delete",$this->findUserOr404()),
            ]
        );

    }
}
