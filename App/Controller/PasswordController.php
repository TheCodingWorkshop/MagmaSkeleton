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

use App\Entity\UserEntity;
use MagmaCore\Base\BaseController;
use LoaderError;
use RuntimeError;
use SyntaxError;

class PasswordController extends BaseController
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
                "repository" => \App\Model\UserModel::class,
                "passwordRepo" => \App\Repository\PasswordRepository::class,
                "formPassword" => \App\Forms\Client\Password\PasswordForm::class,
                "formResetPassword" => \App\Forms\Client\Password\ResetForm::class,
            ]
        );
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
    protected function forgotAction()
    { 
        $this->render(
            'client/password/forgot.html.twig',
            [
                "form" => $this->formPassword->createForm('/password/request-reset')
            ]
        );
    }

    /**
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function requestResetAction()
    {
        if (isset($this->formBuilder)) :
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('request-reset')) : {
                if ($this->formBuilder->csrfValidate()) {
                    $userEntity = new UserEntity($this->formBuilder->getData());
                    if ($this->repository->emailExists($userEntity->email)) {
                        $this->passwordRepo->findByUser($userEntity->email)->sendUserResetPassword();
                        $this->render('client/password/reset_requested.html.twig');
                    } else {
                        $this->flashMessage('Your email address could not be found!', $this->flashInfo());
                        $this->redirect('/password/forgot');
                    }    
                }
            }
            endif;
        endif;
    }

    /**
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function resetAction()
    {
        $token = $this->passwordRepo->parsedUrlToken($this->thisRouteToken());
        if ($token) {
            $this->render('client/password/reset.html.twig',["form" => $this->formResetPassword->createForm('/password/reset-password', $this->thisRouteToken())]);
        } else {
            $this->render('client/password/token_expired.html.twig');
            exit;    
        }
        
    }

    /**
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function resetPasswordAction()
    {
        if (isset($this->formBuilder)) :
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('reset-password')) : {
                if ($this->formBuilder->csrfValidate()) {
                    $userEntity = new UserEntity($this->formBuilder->getData());
                    $repository = $this->passwordRepo->findByPasswordResetToken($userEntity->token);
                    $action = $this->passwordRepo->validatePassword($userEntity, $repository)->reset();
                    if ($action) {
                        $this->render('client/password/reset_success.html.twig');
                    } else {
                        $this->flashMessage('Error saving new password.', $this->flashWarning());
                        $this->redirect('/password/reset');
                    }
                }

            }
            endif;
        endif;
    }

}