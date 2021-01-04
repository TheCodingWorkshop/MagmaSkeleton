<?php

declare(strict_types=1);

namespace App\Event;

use MagmaCore\EventDispatcher\Event;

class MyListener
{
    public function onFooAction(Event $event)
    {
        echo __CLASS__ . '/' . __METHOD__;
        echo "<br>";
    }
}

