#!/bin/sh
#Note : This file must be save as LF not CRLF
figlet haodn.dev
if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction
fi

if [ ! -f ".env" ]; then
    echo "Creating env file for env $APP_ENV using ${ORDER_HISTORY_ENV}"
    cp "${ORDER_HISTORY_ENV}" .env
else
    echo "env file exists."
fi

php artisan config:clear
php artisan route:clear
php artisan optimize

chmod -R +r /opt/logs/php-fpm

chgrp -R www-data storage bootstrap/cache
chmod -R ug+rwx storage bootstrap/cache

php-fpm