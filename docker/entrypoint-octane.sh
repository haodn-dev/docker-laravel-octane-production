#!/bin/sh
#Note : This file must be save as LF not CRLF
figlet haodn.dev
mkdir "/opt/logs"
mkdir "/opt/logs/php-fpm"
mkdir "/opt/logs/nginx"
if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction
    php artisan key:generate
fi

if [ ! -f ".env" ]; then
    echo "Creating env file for env $APP_ENV using ${ORDER_HISTORY_ENV}"
    cp "${ORDER_HISTORY_ENV}" .env
else
    echo "env file exists."
fi
composer require laravel/octane
echo "1" | php artisan octane:install
php artisan config:clear
php artisan route:clear
php artisan optimize
php-fpm -D
php artisan octane:start --host=0.0.0.0 --port=8000

