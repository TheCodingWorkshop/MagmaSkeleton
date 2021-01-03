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
     * Undocumented function
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
                        $object->flashMessage("Sorry you haven't got the correct permissions to enter this area.", $object->flashWarning());
                        $object->redirect('/login');
                    }
                }
            }
        }

        return $next($object);
    }
}
