<?php

declare(strict_types=1);

namespace App\Middleware\Before;

use App\Model\RoleModel;
use Closure;
use MagmaCore\Middleware\BeforeMiddleware;

class PreventionActions extends BeforeMiddleware
{

    /**
     * Undocumented function
     *
     * @param Object $middleware
     * @param Closure $next
     * @return void
     */
    public function middleware(object $middleware, Closure $next)
    {
        if ($middleware->thisRouteAction() === 'delete') {
            if ($guards = (new RoleModel())->guardedID()) {
                if (is_array($guards) && count($guards) > 0) {
                    foreach ($guards as $guard) {
                        if ($middleware->toInt($guard) === $middleware->toInt($middleware->thisRouteID())) {
                            $middleware->flashMessage('Deleting guarded actions is not allowed.<br><small>You will need to guard first before you perform that action. <a href="">click here</a> to find out how to. </small>', $middleware->flashInfo());
                            $middleware->redirect('/admin/role/index');
                        }
                    }
                }
            }
        }

        return $next($middleware);
    }
}
