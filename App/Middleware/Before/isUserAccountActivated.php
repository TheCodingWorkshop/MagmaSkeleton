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
use App\Model\UserModel;
use Closure;

class isUserAccountActivated extends BeforeMiddleware
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
        $user = (new UserModel())->getRepo()->findObjectBy(['email' => $_POST['email']]);#
        if ($user) {
            switch ($user->status) :
                case 'locked' :
                    $object->flashMessage('Your account is currently locked. Admin is aware of this', $object->flashInfo());
                    break; 
                case 'suspended' :
                    $object->flashMessage('Your account is currently Suspended. Admin is aware of this', $object->flashInfo());
                    break;
                case 'pending' :
                    $object->flashMessage('Your account is pending activation. Did you check your email for your activation token.', $object->flashInfo());
                    break;
                case 'active' :
                    break;
            endswitch;
            $object->redirect('/login');
        }

        return $next($object);
    }

}