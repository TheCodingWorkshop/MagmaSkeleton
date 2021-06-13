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
use MagmaCore\Utility\Sanitizer;
use App\Model\UserModel;
use App\Entity\UserEntity;
use Closure;

class EmailAlreadyExists extends BeforeMiddleware
{

    /**
     * Undocumented function
     *
     * @param Object $middleware - contains the BaseController object
     * @param Closure $next
     * @return void
     */
    public function middleware(Object $middleware, Closure $next)
    {   

       // if ($object->thisRouteAction() === 'new') {
//            if (isset($_POST))
//                return false;
            $CleanData = new UserEntity();
            $email = Sanitizer::clean((array)$CleanData['email']);
            if ($results = (new UserModel())->getRepo()->findObjectBy(['email' => $email], ['id'])) {
                if (null !== $results->id) {
                    $middleware->flashMessage('Email address already exists', $middleware->flashWarning());
                    $middleware->redirect('/admin/user/new');
                }
            } 
        //}
        return $next($middleware);
    }

}