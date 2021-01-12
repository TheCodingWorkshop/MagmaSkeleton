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

use MagmaCore\Auth\Controller\AuthSecurityController;
use MagmaCore\Base\BaseController;
use LoaderError;
use RuntimeError;
use SyntaxError;

class RegistrationController extends BaseController
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
                "formRegister" => \App\Forms\Client\Registration\RegistrationForm::class,
                "repository" => \App\Model\UserModel::class
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
    protected function callBeforeMiddlewares() : array
    {
        return [
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
    protected function callAfterMiddlewares() : array
    {
        return [
        ];
    }

    /**
     * Entry method which is hit on request. This method should be implement within
     * all sub controller class as a default landing point when a request is 
     * made. The properties within the method below is extended from the parent
     * class AuthSecurityController
     *
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function registerAction()
    { 
        if (isset($this->formBuilder)) :
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('new-register')) : {
                if ($this->formBuilder->csrfValidate()) {
                    $action = $this->repository
                    ->getRepo()
                    ->validateRepository(new UserEntity($this->formBuilder->getData()))
                    ->persistAfterValidation();

                    if ($action) {
                        $this->flashMessage('Successfully Registered.');
                        $this->redirect('/');
                    }
                }
            }
            endif;
        endif;

        $this->render('client/registration/register.html.twig',
            [
                "form" => $this->formRegister->createForm('/registration/register')
            ]
        );
    }

}