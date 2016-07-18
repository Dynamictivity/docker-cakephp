#!/usr/bin/env bash

rm -rf /www/vendors
composer install --working-dir=/www
cp /app.php /www/config/app.php
/usr/bin/php-fpm