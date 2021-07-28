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

use App\Controller\Admin\UserController as APIUserController;
use App\Entity\UserEntity;
use App\Event\UserActionEvent;
use App\Schema\UserSchema;

class UserController extends APIUserController
{

    protected function indexAction()
    {
        $this->indexAction
            ->execute($this, NULL, NULL, UserSchema::class, __METHOD__)
            ->render('/admin/user/index.html')
            ->with()
            ->table()
            ->indexApiEndpoint();

    }

}
