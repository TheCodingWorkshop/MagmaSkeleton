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
use MagmaCore\Auth\Authorized;
use Closure;

class LoginRequired extends BeforeMiddleware
{

    protected const MESSAGE = "<strong class=\"uk-text-danger\">Action Required: </strong>Please login for access.";

    /**
     * Requires basic login when entering protected routes
     *
     * @param Object $object - contains the BaseController object
     * @param Closure $next
     * @return void
     */
    public function middleware(Object $object, Closure $next)
    {
        if (!Authorized::grantedUser()) {
            $object->flashMessage(self::MESSAGE, $object->flashInfo());
            /* Hold the requested page so when the user logs in we can redirect them back */
            Authorized::rememberRequestedPage();
            $object->redirect('/login');
        }

        return $next($object);
    }
}
