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

namespace App\Event;

use MagmaCore\Auth\Model\UserModel;
use MagmaCore\EventDispatcher\Event;

class NewUserEvent extends Event
{

    /** @var string - name of the event */
    public const NAME = 'new.user';
    /** @var UserModel */
    private UserModel $user;

    /**
     * New user event dispatcher. Which pipes the user object arguement to 
     * the class property
     *
     * @param UserModel $user
     * @return void
     */
    public function __construct(UserModel $user)
    { 
        $this->user = $user;
    }

    /**
     * Returns the new user object
     *
     * @return void
     */
    public function getUser()
    {
        return $this->user;
    }

}