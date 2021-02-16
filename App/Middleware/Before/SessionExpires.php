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
use MagmaCore\Utility\Yaml;
use Closure;

class SessionExpires extends BeforeMiddleware
{

    /** @var int */
    protected const SESSION_TIMEOUT = 600; /* 10 min */

    /**
     * Expires the session if left idle for more than the specified allowed time set.
     * from the application session.yaml file. else will default to class constant which
     * defaults to 30min idle time;
     *
     * @param Object $object - contains the BaseController object
     * @param Closure $next
     * @return void
     */
    public function middleware(Object $object, Closure $next)
    {   
        $session = $object->getSession();
        if(null !== $session->get('timeout')) {
            $duration = time() - (int)$session->get('timeout');
            $lifetime = Yaml::file('session')['lifetime']; /* Get session lifetime from yaml file */
            $expires = ($lifetime !== 0) ? $lifetime : self::SESSION_TIMEOUT;
            if ($duration > $expires) {
                $session->invalidate();
                /** @todo let the user know the session was expired */
                $object->redirect('/login');
            } else {
                $session->set('timeout', time());
            }
        }
        $session->set('timeout', time());
        return $next($object);
    }

}