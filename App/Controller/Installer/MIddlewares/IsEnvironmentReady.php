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

namespace App\Controller\Installer\Middleware;

use MagmaCore\Middleware\BeforeMiddleware;
use Closure;

class IsEnvironmentReady extends BeforeMiddleware
{

    /**
     * Prevent unauthorized access to the administration panel. Only users with specific 
     * priviledges can access the admin area.
     *
     * @param Object $object
     * @param Closure $next
     * @return void
     */
    public function middleware(Object $object, Closure $next)
    {
        return $next($object);
    }
}
