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

namespace App\Middleware\Before;

use MagmaCore\Middleware\BeforeMiddleware;
use Closure;

class InitializeSettings extends BeforeMiddleware
{

    /**
     * Undocumented function
     *
     * @param Object $middleware - contains the BaseController object
     * @param Closure $next
     * @return void
     */
    public function middleware(Object $middleware, Closure $next)
    {   
        $middleware->tableSettingsInsertAction($middleware->thisRouteController());
        return $next($middleware);
    }

}