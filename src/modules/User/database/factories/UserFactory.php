<?php

namespace Modules\User\database\factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Modules\User\Models\User;


class UserFactory extends Factory
{

    protected $model = User::class;
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => fake()->name(),
            'email' => fake()->unique()->safeEmail(),
            'enabled' => true
        ];
    }


}
