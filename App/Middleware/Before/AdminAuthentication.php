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
    protected const SUPERADMIN_PRIVILEDGE = 'all';

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
        if ($authorizedUser = Authorized::grantedUser()) {
            if (null !== $authorizedUser) {
                $priviledge = new Roles();
                if ($priviledge) {
                    $priviledge->initRoles($object->getSession()->get('user_id'));
                    if (!$priviledge->hasPrivilege(self::SUPERADMIN_PRIVILEDGE)) {
                        $object->flashMessage("<strong class=\"uk-text-danger\">Access Denied </strong>Sorry you need the correct priviledge to access this area.", $object->flashInfo());
                        /* Send the user back where they're are coming from */
                        $object->redirect(Authorized::getReturnToPage());
                    }
                }
            }
        }

        return $next($object);
    }
}
