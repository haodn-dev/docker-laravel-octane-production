FROM php:8.1-fpm-alpine

WORKDIR /tmp

RUN apk add wget git iputils-ping net-tools vim nodejs npm figlet

# Install additional packages
RUN apk --no-cache add \
    supervisor \
    && docker-php-ext-enable opcache

# installing required extensions
RUN apk add bash build-base gcc wget git autoconf libmcrypt-dev libzip-dev zip  g++ make openssl-dev php81-openssl php81-pdo_mysql

RUN docker-php-ext-install mysqli pdo pdo_mysql

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#Xdebug
RUN apk add --update linux-headers \
    & pecl install xdebug \
    && docker-php-ext-enable xdebug

# Copy PHP configuration
COPY ./docker/php/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf

#COPY ../docker/php/php.ini /usr/local/etc/php/conf.d/php.ini

COPY ./docker/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Copy Supervisor configuration
#COPY conf.d/supervisor/supervisord.conf /etc/supervisord.conf
COPY ./docker/app/dev/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

## Copy Laravel application files
COPY ./laravel /opt/html

## Set up permissions
RUN chown -R www-data:www-data /opt/html \
    && chmod -R 755 /opt/html/storage

# Scheduler setup
# Create a log file
RUN touch /var/log/cron.log

# Add cron job directly to crontab
RUN echo "* * * * * /usr/local/bin/php /opt/html/artisan schedule:run >> /var/log/cron.log 2>&1" | crontab -

RUN apk add tzdata && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY ./docker/entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

WORKDIR /opt/html

ENTRYPOINT ["/opt/entrypoint.sh"]