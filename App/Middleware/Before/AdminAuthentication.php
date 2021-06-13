<?php

declare(strict_types=1);

namespace App\Middleware\Before;

use MagmaCore\Middleware\BeforeMiddleware;
use MagmaCore\Auth\Authorized;
use MagmaCore\Auth\Roles\Roles;
use Closure;

class AdminAuthentication extends BeforeMiddleware
{
    /** @var string */
    protected const SUPERADMIN_PRIVILEGE = 'all';

    /**
     * Prevent unauthorized access to the administration panel. Only users with specific 
     * privileges can access the admin area.
     *
     * @param Object $middleware
     * @param Closure $next
     * @return void
     */
    public function middleware(Object $middleware, Closure $next)
    {
        if ($authorizedUser = Authorized::grantedUser()) {
            if (null !== $authorizedUser) {
                $privilege = new Roles();
                if ($privilege) {
                    $privilege->initRoles($middleware->getSession()->get('user_id'));
                    if (!$privilege->hasPrivilege(self::SUPERADMIN_PRIVILEGE)) {
                        $middleware->flashMessage("<strong class=\"uk-text-danger\">Access Denied </strong>Sorry you need the correct privilege to access this area.", $middleware->flashInfo());
                        /* Send the user back where they're are coming from */
                        $middleware->redirect(Authorized::getReturnToPage());
                    }
                }
            }
        }

        return $next($middleware);
    }
}
