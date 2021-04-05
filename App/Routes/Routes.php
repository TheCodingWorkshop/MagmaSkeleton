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

namespace App\Routes;

class Routes
{

    public static function myRoutes()
    {
        return [

            '' => ['controller' => 'Home', 'action' => 'index'],
            'login' => ['controller' => 'Security', 'action' => 'index'],
            'register' => ['controller' => 'Registration', 'action' => 'register'],
            'admin/{controller}/{action}' => ['namespace' => 'Admin'],
            'admin/{controller}/{id:[\da-f]+}/{action}' => ['namespace' => 'Admin']


        ];
    }

}