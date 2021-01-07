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

class UserEdittedEvent extends Event
{

    /** @var string - name of the event */
    public const NAME = 'app.event.user_editted_event';
    
    /** @var Object */
    private Object $user;

    /**
     * New user event dispatcher. Which pipes the user object arguement to 
     * the class property
     *
     * @param array $user
     * @return void
     */
    public function __construct(Object $user)
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
        echo 'User was editted event fires';
    }

}