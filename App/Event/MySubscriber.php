<?php

namespace App\Event;

use MagmaCore\EventDispatcher\EventSubscriberInterface;

class MySubscriber implements EventSubscriberInterface
{

    public static function getSubscribedEvents(): array
    {
        return [
            'foo.action' => ['onFooAction', 0],
            'bar.action' => ['onBarAction', 10],
            'baz.action' => ['onBazAction', -10]
        ];
    }

    public function onFooAction()
    {
        echo __CLASS__ . '/' . __METHOD__;
        echo "<br>";
    }

    public function onBarAction()
    {
        echo __CLASS__ . '/' . __METHOD__;
        echo "<br>";
    }
    public function onBazAction()
    {
        echo __CLASS__ . '/' . __METHOD__;
        echo "<br>";
    }

}
