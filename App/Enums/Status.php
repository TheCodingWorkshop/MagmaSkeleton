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

namespace App\Enums;

use MagmaCore\Enums\Contracts\StatusInterface;

/**
 * Strictly for PHP 8.1 onwards
 */
enum Status: string implements StatusInterface 
{

    case DRAFT;
    case PUBLISHED;
    case ARCHIVED;

    public function color(): string
    {
        return match($this) {
            Status::DRAFT => 'grey',
            Status::PUBLISHED => 'green',
            Status::ARCHIVED => 'red'
        };
    }

}