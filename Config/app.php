<?php

return [

    /**
     * Predefine applicastion settings. Feel free to change this to reflect your own
     * This contains infomation about the application ie. application name, version
     * email and the application author
     */
    'app' => [

        'app_name'  => 'MagmaCore',
        'app_version' => '1.0.0',
        'app_email' => '',
        'app_author' => '',

    ],
    
    /**
     * Basic application settings. You can modify the value to match your region. Ensure
     * you set your own timezone as this might make your mysql current datetime value 
     * incorrect.
     */
    'settings' => [

        'charset' => 'UTF-8',
        'language' => 'en_GB',
        'timezone' => 'Europe/London',
        'favicon' => '',
        'apple_icon' => [
            '1x' => '',
            '2x' => '',
            '3x' => ''
        ]

    ],

    /**
     * Default gravatar settings.
     */
    'gravatar' => [

        'rating' => 'r',
        'size' => 200,
        'default' => 'mystery'

    ],

    /**
     * Security pattern settings for the application input form. These values are defined
     * withn the form component
     */
    'security' => [

        'password_pattern' => '(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}',
        'url_pattern' => 'https?://.+',
        'search_pattern' => "'[^'\x22]+'",
        'email_pattern' => '[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$',
        'tel_pattern' => '[0-9]{3}-[0-9]{3}-[0-9]{4}'

    ]

];