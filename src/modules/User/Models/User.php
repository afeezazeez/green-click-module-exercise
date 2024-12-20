<?php

namespace Modules\User\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class User extends Model
{
    use HasFactory;

    protected $table = 'module_users'; // Custom table name
    protected $fillable = ['name', 'email', 'enabled'];

    protected $casts = [
        'enabled' => 'boolean',
    ];

    protected static function newFactory()
    {
        return \Modules\User\Database\Factories\UserFactory::new();
    }
}
