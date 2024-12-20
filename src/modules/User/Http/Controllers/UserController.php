<?php

namespace Modules\User\Http\Controllers;

use Illuminate\Routing\Controller;
use Modules\User\Models\User;

class UserController extends Controller
{
    public function index()
    {
        $users = User::all();

        $formattedUsers = $users->mapWithKeys(function ($user) {
            return [
                $user->id => [
                    'id' => $user->id,
                    'name' => $user->name,
                    'email' => $user->email,
                    'enabled' => $user->enabled,
                ],
            ];
        });

        return response()->json($formattedUsers);
    }

    public function disable($userId)
    {
        $user = User::findOrFail($userId);
        $user->enabled = false;
        $user->save();

        return response()->json($user);
    }

    public function enable($userId)
    {
        $user = User::findOrFail($userId);
        $user->enabled = true;
        $user->save();

        return response()->json($user);
    }
}
