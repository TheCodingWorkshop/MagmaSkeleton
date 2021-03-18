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

class Test extends BeforeMiddleware
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
       // if ($object->formBuilder->canHandleRequest() && $object->formBuilder->isSubmittable('index-security')) {
            //if ($object->formBuilder->csrfValidate()) {
                //var_dump($object->request->handler()->request->all());
            //}
            
        //}
        return $next($object);
    }

}