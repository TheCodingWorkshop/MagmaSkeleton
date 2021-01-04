<?php

declare(strict_types=1);

namespace App\Event;

use MagmaCore\EventDispatcher\Event;
use App\Store\Order;

/**
 * The order.placed event is dispatched each time an order is created
 * in the system.
 */
class OrderPlacedEvent extends Event
{

    public const NAME = 'order.placed';
    protected $order;

    public function __construct(Order $order)
    {
        $this->order = $order;
    }

    public function getOrder() : Order
    {
        return $this->order;
    }

}