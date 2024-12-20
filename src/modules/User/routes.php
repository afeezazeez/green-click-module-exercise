<?php

use Illuminate\Support\Facades\Route;
use Modules\Demo\DemoController;
use Modules\User\Http\Controllers\UserController;

Route::prefix('users')->name('users.')->group(function () {
    Route::get('/', [UserController::class, 'index'])->name('index');
    Route::post('/disable/{user}', [UserController::class, 'disable'])->name('disable');
    Route::post('/enable/{user}', [UserController::class, 'enable'])->name('enable');
});
