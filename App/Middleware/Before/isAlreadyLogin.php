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
use Closure;

class isAlreadyLogin extends BeforeMiddleware
{

    /**
     * Undocumented function
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
                $object->redirect('/');
            }
        }
        return $next($object);
    }

}