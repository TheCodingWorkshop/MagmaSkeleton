<?php

namespace App\TestClass;

class UserModel
{

    private $name;

    public function set($name)
    {
        $this->name = $name;
    }

    public function get()
    {
        return $this->name;
    }

}