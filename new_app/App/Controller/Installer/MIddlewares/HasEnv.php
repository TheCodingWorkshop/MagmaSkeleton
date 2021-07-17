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

namespace App\Controller\Installer\Middleware;

use Closure;
use MagmaCore\Middleware\BeforeMiddleware;

class HasEnv extends BeforeMiddleware
{

    /**
     * Prevent unauthorized access to the administration panel. Only users with specific
     * privileges can access the admin area.
     *
     * @param Object $middleware
     * @param Closure $next
     * @return void
     */
    public function middleware(object $middleware, Closure $next)
    {
        if (!file_exists(APP_ROOT . '/.env.lip')) {
            if ($middleware->error) {
                $middleware->error->addError(['missing_env' => 'Error locating the system .env file.'], $middleware)->dispatchError();
            }
        }
        return $next($middleware);
    }
}
