# User Module

This is a `User` module for the Laravel app, which is designed to dynamically extend the functionality of the host app. This module exposes routes for managing users, including enabling, disabling, and listing users.

### Module Structure

The `User` module includes the following components:

1. **Routes**  
   The routes for the `User` module are located in `./src/modules/User/routes.php`.  
   This file defines the following routes:
    - `GET /users`: Returns a list of all users.
    - `POST /users/disable/{userId}`: Disables a user by ID.
    - `POST /users/enable/{userId}`: Enables a user by ID.

2. **Model**  
   The `User` model represents a user entity and is located in `./src/modules/User/Models/User.php`.

3. **Factory**  
   The `UserFactory` generates dummy users for testing and seeding purposes, located in `./src/modules/User/Database/factories/UserFactory.php`.

4. **Seeder**  
   The `UserSeeder` is responsible for seeding user data into the database. It's located in `./src/modules/User/Database/Seeders/UserSeeder.php`.

5. **Migration**  
   The migration that creates the `users` table is located in `./src/modules/User/Database/Migrations/xxxx_xx_xx_create_users_table.php`.

6. **Controller**  
   The `UserController` handles actions related to users, such as listing, enabling, and disabling users. It's located in `./src/modules/User/Http/Controllers/UserController.php`.

### Routes Exposed

The following routes are defined for the `User` module:

1. **GET /users**  
   Retrieves a list of all users in a structured JSON format.  
   **Example Response:**
   ```json
   {
     "1": {
       "id": 1,
       "name": "John Doe",
       "email": "john.doe@example.com",
       "enabled": true
     },
     "2": {
       "id": 2,
       "name": "Jane Smith",
       "email": "jane.smith@example.com",
       "enabled": false
     }
   }
2. **POST /users/disable/{userId}**  
   Disables the user by setting their `enabled` field to `false`.

   **Example Response:**
   ```json
   {
     "id": 1,
     "name": "John Doe",
     "email": "john.doe@example.com",
     "enabled": false
   }

3. **POST /users/enable/{userId}**  
   Enables the user by setting their `enabled` field to `true`.

   **Example Response:**
   ```json
   {
     "id": 1,
     "name": "John Doe",
     "email": "john.doe@example.com",
     "enabled": true
   }


## Setup & Commands

To work with this application and the `User` module, follow the instructions below.

### Boot the Application

To boot the app, run:

```bash
./setup.sh start
```

### Configure the Laravel Application

To configure the Laravel app (generate keys, run migrations, etc.), run:

```bash
./setup.sh setup
```

### Stop the Application

To stop the app, run:
```bash
./setup.sh stop
```

### Run User Module Specific Tests

To run the tests specific to the User module, execute:
```bash
./run_tests.sh
```


### Permission Issues

If you face permission issues when running the shell scripts (e.g., permission denied), you can resolve it by granting execute permissions. Use the following command:
```bash
chmod +x ./setup.sh
chmod +x ./run_tests.sh
```

You should be able to access the app at http://localhost:59000/users


## Additional Information

### Docker Compose
This project uses Docker for containerization. The `docker-compose.yml` file is set up to run both the app (Laravel) and MySQL services.

### Persistence
User data is stored in a MySQL database, and changes to the `enabled` field for users will persist across app restarts.

### No Direct Modification of Host App
The `User` module is self-contained and does not directly reference or modify any code in the host app. All routes and logic are encapsulated within the module.

