<?php

declare(strict_types=1);

namespace App\Middleware\After;

use MagmaCore\Middleware\AfterMiddleware;
use Closure;

class SessionExpiresCleanUp extends AfterMiddleware
{
    /**
     * Clean up after logout will only execute when the logout action called
     * and will attempt to clean up database and left over cookie crumbs
     * if needs doing else will just return the next middleare
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
