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

namespace App\Repository;

use App\Model\UserRoleModel;
use JetBrains\PhpStorm\ArrayShape;

class UserRoleRepository extends UserRoleModel
{
    public function getRepoSchemaID(): string
    {
        return 'user_id';
    }

    #[ArrayShape(['user_id' => "int"])] public function getRepoUserIDArray(int $userID): array
    {

        return ['user_id' => $userID];
    }
}

