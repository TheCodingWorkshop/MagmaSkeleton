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

use MagmaCore\Base\BaseController;
use MagmaCore\RestFul\RestHandler;

class DataValidatorController extends BaseController
{

    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);
        $this->diContainer(
            [
                'repository' => \App\Model\UserModel::class,
            ]
        );
    }

    public function validateStringAction()
    {
        $isValid = !$this->repository->check($name);
        header('Content-Type: application/json');
        echo json_encode($isValid);
    }

}
