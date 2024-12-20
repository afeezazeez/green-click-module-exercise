#!/bin/bash
set -e

GREEN=$(tput setaf 2)

echo "${GREEN}Running app tests ..."

# Run tests in the container (make sure to run from the src directory)
docker-compose exec app php artisan test modules/User/tests

echo "${GREEN}Tests completed."
