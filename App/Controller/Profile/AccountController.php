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
use App\Event\NewUserEvent;
use MagmaCore\Base\BaseController;

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
        $this->container(
            [
                "repository" => \App\Model\UserProfileModel::class,
                "activationRepo" => \App\Repository\ActivationRepository::class,
                "editNameForm" => \App\Forms\Client\Profile\EditNameForm::class,
                "editEmailForm" => \App\Forms\Client\Profile\EditEmailForm::class,
                "editPasswordForm" => \App\Forms\Client\Profile\EditPasswordForm::class,
                /* Event Listeners */
                //"ResendActivationEmailListener" => \App\EventListener\ResendActivationEmailListener::class
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
            'loginRequired' => \App\Middleware\Before\LoginRequired::class,
            'isAlreadyLogin' => \App\Middleware\Before\isAlreadyLogin::class,
            'SessionExpires' => \App\Middleware\Before\SessionExpires::class,
        ];
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
     * Undocumented function
     *
     * @return void
     */
    protected function editEmailAction()
    {
        if (isset($this->formBuilder)) {
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('edit-profile-email')) {
                if ($this->formBuilder->csrfValidate()) {
                    if ($this->verifyPassword()) {
                        $userEntity = new UserEntity($this->formBuilder->getData());
                        $action = $this->repository
                            ->getRepo()
                            ->validateRepository($userEntity, $this->findUserOr404())
                            ->saveAfterValidation(['id' => $this->findUserOr404()->id]);
                        if ($action) {
                            //$content = $this->getRepo()->validatedDataBag();
                            //$this->activationRepo->
                            /*
                            @todo
                            1. Generate and insert a new hash token
                            2. send the hash value to the new email address
                            3. only update user email once the token is activated
                            */
                            $this->flashMessage('Changes saved');
                            $this->redirect('/profile/account/edit-email');
                        }
                    } else {
                        die('Password not verify');
                    }
                }
            }
        }
        $this->render(
            'client/profile/edit_email.html.twig',
            [
                "profile" => $this->findUserOr404(),
                "formEmail" => $this->editEmailForm->createForm("/profile/account/edit-email", $this->findUserOr404()),
                "app_name" => "LavaStudio"
            ]
        );
    }

    /**
     * Undocumented function
     *
     * @return void
     */
    protected function editNameAction()
    {
        if (isset($this->formBuilder)) {
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('edit-profile-name')) {
                if ($this->formBuilder->csrfValidate()) {
                    list(
                        $validatedData, 
                        $errors) = $this->repository->updateProfileNameOnceValidated(
                        new UserEntity($this->formBuilder->getData()),
                        $this->findUserOr404()
                    );
                    $updated = $this->repository->getRepo()->findByIDAndUpdate($validatedData, $this->findUserOr404()->id);
                    /*if ($errors) {
                        $this->flashMessage(implode('<br>', $errors), $this->flashWarning());
                        $this->redirect('/profile/account/edit-name');
                    } else {
                        
                        if ($updated) {
                            $this->flashMessage('Changes Saved');
                            $this->redirect('/profile/account/edit-name');
                        }
                    }*/
                }
            }
        }
        $this->render(
            'client/profile/edit_name.html.twig',
            [
                "profile" => $this->findUserOr404(),
                "formName" => $this->editNameForm->createForm("/profile/account/edit-name", $this->findUserOr404()),
                "app_name" => "LavaStudio"
            ]
        );
    }

    /**
     * Undocumented function
     *
     * @return void
     */
    protected function editPasswordAction()
    {
        if (isset($this->formBuilder)) {
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('edit-profile-password')) {
                if ($this->formBuilder->csrfValidate()) {
                    if (!$this->passwordMatch()) {
                        $this->flashMessage('Password does not matched. Please try again');
                        $this->redirect('/profile/account/edit-password');
                    }
                    $action = $this->repository
                        ->getRepo()
                        ->validateRepository(new UserEntity($this->formBuilder->getData()), $this->findUserOr404())
                        ->saveAfterValidation(['id' => $this->findUserOr404()->id]);
                    if ($action) {
                        $this->flashMessage('Changes saved');
                        $this->redirect('/profile/account/edit-password');
                    }
                }
            }
        }
        $this->render(
            'client/profile/edit_password.html.twig',
            [
                "profile" => $this->findUserOr404(),
                "formPassword" => $this->editPasswordForm->createForm("/profile/edit-password", $this->findUserOr404()),
                "app_name" => "LavaStudio"
            ]
        );
    }

    protected function deleteAction()
    {
        if (isset($this->formBuilder)) {
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('profile-delete-account')) {
                if ($this->csrfValidate()) {
                }
            }
        }
        $this->render("client/profile/delete_account.html.twig", []);
    }
}
