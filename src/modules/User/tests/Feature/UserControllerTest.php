<?php

namespace Modules\User\tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Modules\User\Models\User;
use Tests\TestCase;

class UserControllerTest extends TestCase
{
    use RefreshDatabase;

    public function test_that_it_returns_all_users_in_expected_format()
    {
        $user1 = User::factory()->create();
        $user2 = User::factory()->create();

        $response = $this->getJson(route('users.index'));

        $response->assertStatus(200)
            ->assertJsonStructure([
                '*' => [
                    'id',
                    'name',
                    'email',
                    'enabled',
                ],
            ])
            ->assertJson([
                $user1->id => [
                    'id' => $user1->id,
                    'name' => $user1->name,
                    'email' => $user1->email,
                    'enabled' => $user1->enabled,
                ],
                $user2->id => [
                    'id' => $user2->id,
                    'name' => $user2->name,
                    'email' => $user2->email,
                    'enabled' => $user2->enabled,
                ],
            ]);
    }


    public function test_that_it_disables_a_user()
    {
        $user = User::factory()->create();

        $response = $this->postJson(route('users.disable', $user->id));

        $response->assertStatus(200)
            ->assertJson([
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'enabled' => false,
            ]);

        $this->assertFalse(User::find($user->id)->enabled);
    }

    public function test_that_it_enables_a_user()
    {
        $user = User::factory()->create(['enabled' => false]);

        $response = $this->postJson(route('users.enable', $user->id));

        $response->assertStatus(200)
            ->assertJson([
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'enabled' => true,
            ]);

        $this->assertTrue(User::find($user->id)->enabled);
    }

    public function test_that_it_returns_404_if_user_not_found_on_disable()
    {
        $response = $this->postJson(route('users.disable', 999)); // assuming 999 is an invalid user ID

        $response->assertStatus(404);
    }

    public function test_that_it_returns_404_if_user_not_found_on_enable()
    {
        $response = $this->postJson(route('users.enable', 999)); // assuming 999 is an invalid user ID

        $response->assertStatus(404);
    }


}
