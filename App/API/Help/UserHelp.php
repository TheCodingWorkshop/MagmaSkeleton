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

namespace App\API\Help;

class UserHelp
{

    public function init()
    {
        return [
            [
                "title" => "What are pages?",
                "desc" => "this is some description base on the name search a user can search form"
            ],
            [
                "title" => "Creating new pages",
                "desc" => "this is some description base on the name search a user can search form"
            ],
            [
                "title" => "How to edit pages",
                "desc" => "this is some description base on the name search a user can search form"
            ],
            [
                "title" => "Deleting a page",
                "desc" => "this is some description base on the name search a user can search form"
            ],
            [
                "title" => "Customizing pages?",
                "desc" => "this is some description base on the name search a user can search form"
            ]


        ];
    }

}