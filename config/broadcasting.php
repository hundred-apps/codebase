<?php

return [

    'default' => env('BROADCAST_DRIVER', 'redis'),

    'connections' => [

        'websockets' => [

            'driver' => 'pusher',
            'app_id' => env('APPWEBSOCKETS_ID'), 'key' => env('APPWEBSOCKETS_KEY'),
            'secret' => env('APPWEBSOCKETS_SECRET'),
            'options' => [ 'cluster' => env('APPWEBSOCKETS_CLUSTER'), 'use' . 'TLS' => true, 'scheme' => 'http', 'host' => env('WEBSOCKETS_HOST'), 'port' => env('WEBSOCKETS_PORT'), ],
        ],

        'pusher' => [

            'driver' => 'pusher',
            'app_id' => env('PUSHER_ID'), 'key' => env('PUSHER_KEY'),
            'secret' => env('PUSHER_SECRET'),
            'options' => [ 'cluster' => env('PUSHER_CLUSTER'), 'use' . 'TLS' => true, ],
        ],

        'redis' => [

            'driver' => 'redis',
            'connection' => 'broadcast',
        ],

        'log' => [

            'driver' => 'log',
        ],
    ],
];