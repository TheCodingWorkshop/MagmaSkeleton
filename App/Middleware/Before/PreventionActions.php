<?php

declare(strict_types=1);

namespace App\Middleware\Before;

use Closure;
use App\Model\UserModel;
use MagmaCore\Auth\Model\RoleModel;
use MagmaCore\Middleware\BeforeMiddleware;

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
        if ($object->thisRouteAction() === 'delete') {
            if ($guards = (new RoleModel())->guardedID()) {    
                if (is_array($guards) && count($guards) > 0) {
                    foreach ($guards as $guard) {
                        if ($object->toInt($guard) === $object->toInt($object->thisRouteID())) {
                            $object->flashMessage('Deleting guarded actions is not allowed.<br><small>You will need to unguard first before you perform that action. <a href="">click here</a> to find out how to. </small>', $object->flashInfo());
                            $object->redirect('/admin/role/index');
                        }
                    }        
                }
            }    
        }

        return $next($object);
    }
}
