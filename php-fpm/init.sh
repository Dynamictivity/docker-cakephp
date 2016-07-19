#!/usr/bin/env bash

# Clear vendors (composer)
#rm -rf /www/vendor

# Install app dependencies
composer install --working-dir=/www

# Copy over app configuration
cp /app.php /www/config/app.php

# Wait for MySQL to come up (http://stackoverflow.com/questions/6118948/bash-loop-ping-successful)
((count = 100000))                            # Maximum number to try.
while [[ $count -ne 0 ]] ; do
    nc -v db 3306                      # Try once.
    rc=$?
    if [[ $rc -eq 0 ]] ; then
        ((count = 1))                      # If okay, flag to exit loop.
    fi
    ((count = count - 1))                  # So we don't go forever.
done

if [[ $rc -eq 0 ]] ; then                  # Make final determination.
    echo 'The MySQL server is up.'
else
    echo 'Timeout waiting for MySQL server.'
fi

# Run db migrations
cd /www; bin/cake migrations migrate

# Seed the db
cd /www; bin/cake migrations seed --seed DatabaseSeed || true

# Start php-fpm
/usr/sbin/php5-fpm