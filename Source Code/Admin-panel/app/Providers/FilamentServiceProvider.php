<?php

namespace App\Providers;

use Filament\Facades\Filament;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Auth;
use Kreait\Firebase\Factory;

class FilamentServiceProvider extends ServiceProvider
{
    public function boot()
    {
        Filament::serving(function () {
            Auth::viaRequest('firebase', function ($request) {
                $token = $request->bearerToken();
                if (!$token) return null;

                $auth = (new Factory)
                    ->withServiceAccount(config('firebase.credentials'))
                    ->createAuth();

                try {
                    $verifiedToken = $auth->verifyIdToken($token);
                    $userUid = $verifiedToken->claims()->get('sub');
                    return \App\Models\FirebaseUser::findOrFail($userUid);
                } catch (\Exception $e) {
                    return null;
                }
            });
        });
    }
}
