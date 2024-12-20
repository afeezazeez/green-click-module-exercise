#!/bin/bash
set -e

GREEN=$(tput setaf 2)
PINK=$(tput setaf 5)

if [[ "$1" == "start" ]]; then

     echo "${PINK}Installing composer packages ..."
     if ! cp ./src/.env.example ./src/.env; then
         echo "${PINK}Error: Failed to copy .env.example to .env."
         exit 1
     fi

    echo "${PINK}Starting Docker containers ..."
    if ! docker-compose up -d; then
        echo "${PINK}Error: Failed to start Docker containers. Make sure Docker is installed and running."
        exit 1
    fi


   echo "${PINK}Installing composer packages ..."
       cd ./src
       if ! composer install --quiet; then
           echo "${PINK}Error: Composer installation failed."
           exit 1
       fi
       cd ..

    echo "${PINK}Generating app key ..."
    if ! docker-compose exec app php artisan key:generate; then
        echo "${PINK}Error: Failed to generate app key."
        exit 1
    fi


    echo "${PINK}Clearing existing database data ..."
    if ! docker-compose exec app php artisan migrate:reset; then
        echo "${PINK}Error: Failed to reset database migrations."
        exit 1
    fi

    echo "${PINK}Running migrations ..."
    if ! docker-compose exec app php artisan migrate --seed; then
        echo "${PINK}Error: Database migrations failed."
        exit 1
    fi


elif [[ "$1" == "stop" ]]; then
    echo "${PINK}Stopping Docker containers ..."
    if ! docker-compose down; then
        echo "${PINK}Error: Failed to stop Docker containers."
        exit 1
    fi
    echo "${GREEN}Docker containers stopped successfully!"
else
    echo "${PINK}Usage: $0 [start|stop]"
    exit 1
fi
