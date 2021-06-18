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

namespace App\Controller\API;

use App\Model\UserModel;
use MagmaCore\Base\BaseController;

class AccountController extends BaseController
{

    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);
        $this->diContainer(
            [
                'repository' => UserModel::class,
            ]
        );
    }

    /**
     * Validate if email is available (AJAX) for a new signup or an existing user.
     * The ID of an existing user can be passed in in the querystring to ignore when
     * checking if an email already exists or not.
     *
     * @return void
     */
    protected function validateEmailAction()
    {
        $isValid = !$this->repository->emailExists($_GET['email'], $_GET['ignore_id'] ?? null);
        header('Content-Type: application/json');
        echo json_encode($isValid);
        //$handler = new RestHandler($isValid);
        //echo $handler->response();
        //echo (new RestHandler($isValid))->response();
    }
}
