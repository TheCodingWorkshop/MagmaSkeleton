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

use MagmaCore\RestFul\RestHandler;
use App\Controller\Admin\UserController as APIUserController;

class UserController extends APIUserController
{

    /**
     * Return api response for the user index route which returns all queried
     * database results
     *
     * @return RestHandler
     * @throws \Exception
     */
    protected function indexAction()
    {
        $repository = $this->repository->getRepo();
        if ($repository->count() > 0) {
            $records = [];
            $records['records'] = [];
            array_push($records['records'], $repository->findAll());
            echo $this->apiResponse->response($records);
        } 
    }

    /**
     *
     * @return RestHandler
     * @throws \Exception
     */
    public function newAction()
    {
        $this->newAction
            ->execute($this, UserEntity::class, UserActionEvent::class, NULL, __METHOD__)
                ->with()
                    ->api();
        
    }

}
