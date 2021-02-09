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

use MagmaCore\EventDispatcher\Event;

class NewUserEvent extends Event
{

    /** @var string - name of the event */
    public const NAME = 'app.event.new_user_event';
    
    /** @var array */
    private Object $user;

    /** 
     * New user event dispatcher. Which pipes the user object arguement to 
     * the class property
     *
     * @param Object $user
     * @return void
     */
    public function __construct(Object $user)
    { 
        $this->user = $user;
    }

    /**
     * Returns the new user object
     *
     * @return Object
     */
    public function getUser() : Object
    {
        return $this->user;
    }

}