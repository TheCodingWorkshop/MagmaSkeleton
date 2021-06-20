<?php

namespace App\TestClass;

class User
{

    private $user;

    public function __construct(UserModel $user)
    {
        $this->user = $user;
    }

    public function userModel()
    {
        return $this->user;
    }

}