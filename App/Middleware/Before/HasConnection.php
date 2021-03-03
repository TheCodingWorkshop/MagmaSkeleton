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

use mysqli;
use Closure;
use MagmaCore\Middleware\BeforeMiddleware;

class HasConnection extends BeforeMiddleware
{

    /**
     * Redirect to login if authorized object is null. As if you're not 
     * authorized then access cannot be granted.
     *
     * @param Object $object - contains the BaseController object
     * @param Closure $next
     * @return void
     */
    public function middleware(Object $object, Closure $next)
    {
        /*$mysqli = new mysqli("localhost", "root", "", "lavacms");
        if ($mysqli->connect_errno) {
            echo "<div class=\"uk-alert-danger uk-margin-remove uk-text-center\" uk-alert>
            <a class=\"uk-alert-close\" uk-close></a>
            <p>Failed to connect to MySQL {$mysqli->connect_error}</p>
        </div>";
        }*/
        return $next($object);
    }
}
