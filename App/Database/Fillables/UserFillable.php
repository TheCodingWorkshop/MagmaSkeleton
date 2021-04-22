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

namespace App\Database\Fillables;

use App\Model\UserModel;
use MagmaCore\Fillable\FillableSchema;
use MagmaCore\Fillable\FillableBlueprint;
use MagmaCore\Fillable\FillableSchemaInterface;
use MagmaCore\Fillable\FillableBlueprintInterface;

class UserFillable extends FillableSchema implements FillableSchemaInterface
{

    private FillableSchema $fillable;
    private FillableBlueprintInterface $blueprint;
    private UserModel $userModel;

    /**
     * Undocumented function
     *
     * @param FillableSchema $fillable
     * @param FillableBlueprint $blueprint
     * @param UserModel $userModel
     * @return void
     */
    public function __construct(FillableSchema $fillable, FillableBlueprint $blueprint, UserModel $userModel)
    {
        $this->fillable = $fillable;
        $this->blueprint = $blueprint;
        $this->userModel = $userModel;
    }

    public function createFillable()
    {
        return $this->fillable
            ->table($this->userModel)
            ->rows(20)
            ->fill($this->blueprint->faker()->firstname())
            ->fill($this->blueprint->faker()->lastname())
            ->fill($this->blueprint->faker()->email())
            ->fill('random_password')
            ->fill('pending')
            ->fill(1)
            ->fill('::1')
            ->bind(function($fillable) {
                return $fillable
                    ->on(['firstname', 'lastname', 'email', 'password_hash', 'status', 'created_byid', 'remote_addr'])
                        ->push();
            });
    }

}
