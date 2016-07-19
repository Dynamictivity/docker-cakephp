#!/usr/bin/env bash

# Clear vendors (composer)
rm -rf /www/vendor

# Install app dependencies
composer install --working-dir=/www

# Copy over app configuration
cp /app.php /www/config/app.php

# Run db migrations
cd /www; bin/cake migrations migrate

# Seed the db
cd /www; bin/cake migrations seed --seed DatabaseSeed

# Start php-fpm
/usr/bin/php-fpm