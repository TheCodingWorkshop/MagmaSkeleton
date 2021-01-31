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

namespace App\EventListener;

use MagmaCore\EventDispatcher\Event;

class NewUserListener
{
    /**
     * New user event dispatcher. Which pipes the user object arguement to 
     * the class property
     *
     * @param UserModel $user
     * @return void
     */
    public function onUserRegisterAction(Event $event)
    { 
        echo __CLASS__ . '/' . __METHOD__;
        //$user = $event->getUser();
        //var_dump($user);
    }

}