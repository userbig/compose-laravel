#!/bin/bash

set -e

role=${CONTAINER_ROLE:-app}
env=${APP_ENV:-production}

if [ "$role" = "app" ]; then

    exec php-fpm

elif [ "$role" = "queue" ]; then

    echo "Running the queue..."
    php /app/artisan queue:work --verbose --tries=3 --timeout=90

elif [ "$role" = "scheduler" ]; then

    while [ true ]
    do
      php /app/artisan schedule:run --verbose --no-interaction &
      sleep 60
    done

else
    echo "Could not match the container role \"$role\""
    exit 1
fi

