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

class FlashMessagesEvent extends Event
{

    /** @var string - name of the event */
    public const NAME = 'flash_messages';
    /** @var bool */
    private bool $action;
    private $flash;

    public function __construct(bool $action, $flashMessages)
    { 
        $this->action = $action;
        $this->flash = $flashMessages;
    }

    public function flash()
    {
        return $this->flash;
    }

    public function isValid()
    {
        return $this->action;
    }

}