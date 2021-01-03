<?php

declare(strict_types=1);

namespace App\Middleware\After;

use MagmaCore\Middleware\AfterMiddleware;
use Closure;

class CleanUpAfterLogout extends AfterMiddleware
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
        /* If we hit the logout button we want to ensure the token in the database gets
        deleted and the browser cookie also gets deleted */
        /*
            scenario 1 - if the database token gets corupt then we will have an invalid browser cookie
            whcih will results in a fatal error */
        return $next($object);
    }
}
