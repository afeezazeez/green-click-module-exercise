#!/bin/bash
set -e

GREEN=$(tput setaf 2)
PINK=$(tput setaf 5)

# Start application containers (without any configuration)
if [[ "$1" == "start" ]]; then
    echo "${PINK}Starting Docker containers ..."
    if ! docker-compose up -d; then
        echo "${PINK}Error: Failed to start Docker containers. Make sure Docker is installed and running."
        exit 1
    fi
    echo "${GREEN}Docker containers started successfully!"

# Run configuration tasks like env setup, key generation, migrations, and seeding
elif [[ "$1" == "setup" ]]; then
    echo "${PINK}Copying environment variables to .env ..."
    if ! cp ./src/.env.example ./src/.env; then
        echo "${PINK}Error: Failed to copy .env.example to .env."
        exit 1
    fi
    echo "${GREEN}Copied .env.example to .env successfully!"

    echo "${PINK}Installing composer dependencies ..."
    cd ./src
    if ! composer install --quiet; then
        echo "${PINK}Error: Composer installation failed."
        exit 1
    fi
    cd ..
    echo "${GREEN}Composer dependencies installed successfully!"

    echo "${PINK}Generating app key ..."
    if ! docker-compose exec app php artisan key:generate; then
        echo "${PINK}Error: Failed to generate app key."
        exit 1
    fi
    echo "${GREEN}App key generated successfully!"

    echo "${PINK}Running migrations ..."
    if ! docker-compose exec app php artisan migrate; then
        echo "${PINK}Error: Database migrations failed."
        exit 1
    fi
    echo "${GREEN}Migrations ran successfully!"

    echo "${PINK}Seeding database ..."
    if ! docker-compose exec app php artisan db:seed --class=Modules\\User\\Database\\Seeders\\UserSeeder; then
        echo "${PINK}Error: Database seeding failed."
        exit 1
    fi
    echo "${GREEN}Database seeded successfully!"

    echo "${GREEN}Configuration completed successfully!"

# Stop application containers
elif [[ "$1" == "stop" ]]; then
    echo "${PINK}Stopping Docker containers ..."
    if ! docker-compose down; then
        echo "${PINK}Error: Failed to stop Docker containers."
        exit 1
    fi
    echo "${GREEN}Docker containers stopped successfully!"

else
    echo "${PINK}Usage: $0 [start|setup|stop]"
    exit 1
fi
