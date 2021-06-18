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
use App\Event\PasswordActionEvent;
use App\Forms\Client\Password\PasswordForm;
use App\Forms\Client\Password\ResetForm;
use App\Repository\PasswordRepository;
use MagmaCore\Base\BaseController;
use MagmaCore\Base\Domain\Actions\NewPasswordAction;
use MagmaCore\Base\Domain\Actions\ResetPasswordAction;
use MagmaCore\Base\Exception\BaseInvalidArgumentException;

class PasswordController extends BaseController
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
                'repository' => PasswordRepository::class,
                'entity' => UserEntity::class,
                'formPassword' => PasswordForm::class,
                'formResetPassword' => ResetForm::class,
                'newPasswordAction' => NewPasswordAction::class,
                'resetPasswordAction' => ResetPasswordAction::class,
            ]
        );
    }

    /**
     * Entry method which is hit on request. This method should be implement within
     * all sub controller class as a default landing point when a request is
     * made.
     *
     */
    protected function forgotAction()
    {
        $this->newPasswordAction
            ->execute($this, UserEntity::class, PasswordActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form($this->formPassword)
            ->end();
    }


    protected function resetAction()
    {
        $this->resetPasswordAction
            ->execute($this, UserEntity::class, PasswordActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with(['token_valid' => $this->repository->parsedUrlToken($this->thisRouteToken())])
            ->form($this->formResetPassword, NULL, $this->thisRouteToken())
            ->end();

    }

}