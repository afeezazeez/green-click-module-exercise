#!/bin/bash

# Check if vendor/autoload.php exists, if not, install composer dependencies
if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction
fi

# Check if .env file exists, if not, copy .env.example
if [ ! -f ".env" ]; then
    cp .env.example .env
else
    echo "env file exists"
fi

# Generate the application key
php artisan key:generate

# Create the database if it doesn't exist (make sure the MySQL container is ready)
DB_NAME=$(grep DB_DATABASE .env | cut -d '=' -f2)
DB_USER=$(grep DB_USERNAME .env | cut -d '=' -f2)
DB_PASSWORD=$(grep DB_PASSWORD .env | cut -d '=' -f2)
DB_HOST=$(grep DB_HOST .env | cut -d '=' -f2)

# Wait for MySQL to be ready (replace with your MySQL service name if needed)
echo "Waiting for MySQL to be ready..."
until mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" -e "exit"; do
  echo "Waiting for MySQL to be ready..."
  sleep 3
done

# Create the database if it does not exist
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Run the migrations
php artisan migrate

# Run the seeder command
php artisan db:seed --class=Modules\\User\\Database\\Seeders\\UserSeeder

# Install npm dependencies
npm install

# Build frontend assets
npm run build

# Start the PHP-FPM process
exec php-fpm
