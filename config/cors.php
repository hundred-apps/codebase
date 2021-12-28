<?php

return [

    'paths' => [ 'api/*', ],

    'allowed_origins' => [ '*', ],
    'allowed_methods' => [ '*', ],
    'allowed_headers' => [ '*', ],

    'allowed_origins_patterns' => [],
    'exposed_headers' => [],
    'supports_credentials' => false,
    'max_age' => 65536,
];