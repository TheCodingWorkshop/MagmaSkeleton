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

use Closure;
use MagmaCore\Auth\Authorized;
use MagmaCore\Middleware\BeforeMiddleware;

class isAlreadyLogin extends BeforeMiddleware
{

    /**
     * Prevent access to the login form is the user is already logged.
     * as this action doesn't need doing again
     *
     * @param Object $object - contains the BaseController object
     * @param Closure $next
     * @return void
     */
    public function middleware(Object $object, Closure $next)
    {   
        if ($object->thisRouteController() === 'Security' && $object->thisRouteAction() === 'index') {
            $userID = $object->getSession()->get('user_id');
            if (isset($userID) && $userID !== 0) {
                $object->flashMessage(sprintf('%s You are already logged in.', '<strong class=\"uk-text-danger\">Action Rejected: </strong>'), $object->flashInfo());
                $object->redirect(Authorized::getReturnToPage());
            }
        }
        return $next($object);
    }

}