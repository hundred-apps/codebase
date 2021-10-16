<?php

namespace App\Providers;

use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;

class EventServiceProvider extends ServiceProvider
{
    /**
     * @var array
     */
    protected $listen = [];

    /**
     * @return void
     */
    // public function register() {}

    /**
     * @return void
     */
    public function boot()
    {
        parent::boot();
    }

    /**
     * @return bool
     */
    public function shouldDiscoverEvents()
    {
        return false;
    }
}