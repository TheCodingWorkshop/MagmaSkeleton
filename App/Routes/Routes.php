<?php

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