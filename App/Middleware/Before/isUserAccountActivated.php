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
use App\Model\UserModel;
use MagmaCore\Middleware\BeforeMiddleware;

class isUserAccountActivated extends BeforeMiddleware
{

    /**
     * Prevent login access if a user account is either pending, lock or suspended.
     * Only active account user will be allowed in.
     *
     * @param Object $object - contains the BaseController object
     * @param Closure $next
     * @return void
     */
    public function middleware(Object $object, Closure $next)
    {
        if ($email = $object->request->handler()->get('email')) {
            if (isset($email)) {
                $user = (new UserModel())->getRepo()->findObjectBy(['email' => $email]);
                if (is_null($user)) {
                    $object->flashMessage('Account not found.', $object->flashWarning());
                    $object->redirect('/login');
                }
                $message = '';
                switch ($user->status) {
                    case 'pending':
                        $message = 'Account not activated.';
                        break;
                    case 'lock':
                        $message = 'Your account is locked. Please contact support for more information';
                        break;
                    case 'suspended':
                        $message = 'Your account is suspended.';
                        break;
                    case 'active':
                    default : 
                        return;
                        break;
                }
                $object->flashMessage($message, $object->flashWarning());
                $object->redirect('/login');
            }
        }

        return $next($object);
    }
}
