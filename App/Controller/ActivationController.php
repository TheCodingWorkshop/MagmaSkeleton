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

class ActivationController extends BaseController
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
                "activationRepo" => \App\Repository\ActivationRepository::class,
            ]
        );
    }

    /**
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function activateAction()
    {
        $token = $this->thisRouteToken();
        if (is_string($token) && $token !=null) {
            $repository = $this->activationRepo->findByActivationToken($token);
            if (!$repository) {
                $this->redirect('/profile');
            }
            $action = $this->activationRepo->validateActivation()->activate();
            if ($action) {
                $this->flashMessage('Your account is now activated', $this->flashInfo());
                $this->redirect('/activation/activate');
            } else {
                $this->flashMessage('Fail to activate your account.', $this->flashInfo());
                $this->redirect('/activation/fail-activation');
            }
        }
        
    }

    /**
     * Show the activation response if the activation was successful.
     * 
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function activatedAction()
    {
        $this->render('client/activation/activation.html.twig');
    }

    /**
     * Show the activation response if the activation was unsuccessful.
     * 
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function failActivationAction()
    {
        $this->render('client/activation/fail_activated.html.twig');
    }


}