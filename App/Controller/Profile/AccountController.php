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

use MagmaCore\Base\BaseController;
use LoaderError;
use RuntimeError;
use SyntaxError;

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
                "repository" => \App\Model\UserModel::class,
                //"editNameForm" => \App\Forms\Client\Profile\EditNameForm::class,
                //"editEmailForm" => \App\Forms\Client\Profile\EditEmailForm::class,
                //"editPasswordForm" => \App\Forms\Client\Profile\EditPasswordForm::class,
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
            'AuthorizedIsNull' => \App\Middleware\Before\AuthorizedIsNull::class,
            'LoginRequired' => \App\Middleware\Before\LoginRequired::class,
            'loginRequired' => \App\Middleware\Before\LoginRequired::class,
            'isAlreadyLogin' => \App\Middleware\Before\isAlreadyLogin::class,
            'SessionExpires' => \App\Middleware\Before\SessionExpires::class,
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
        $this->render(
            'client/profile/show.html.twig',
            [
                "profile" => $this->repository
                    ->getRepo()
                    ->findAndReturn($_SESSION['user_id'])
                    ->or404()
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
    protected function showAction()
    {
        $this->render('client/profile/show.html.twig',
            [
                "profile" => $this->repository
                    ->getRepo()
                    ->findAndReturn($_SESSION['user_id'])
                    ->or404()
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
    protected function editAction()
    {

    }

}