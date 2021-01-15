<?php

declare(strict_types=1);

namespace App\Middleware\Before;

use MagmaCore\Middleware\BeforeMiddleware;
use App\Model\UserModel;
use Closure;

class PreventionActions extends BeforeMiddleware
{

    /**
     * Undocumented function
     *
     * @param Object $object
     * @param Closure $next
     * @return void
     */
    public function middleware(Object $object, Closure $next)
    {
        if ($guards = (new UserModel())->guardedID()) {
            if (is_array($guards) && count($guards) > 0) {
                foreach ($guards as $guard) {
                    if (intval($guard) === $object->thisRouteID()) {
                        $object->flashMessage('That action is not allowed.', $object->flashWarning());
                        $object->redirect('/admin/user/index');
                    }
                }        
            }
        }

        return $next($object);
    }
}
