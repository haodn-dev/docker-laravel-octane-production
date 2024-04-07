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

# Copy PHP configuration
COPY ./docker/php/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf

COPY ./docker/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
## Copy Laravel application files
COPY ./laravel /opt/html

RUN pecl install swoole pcntl
RUN docker-php-ext-install pcntl
RUN docker-php-ext-enable swoole pcntl

# Scheduler setup
# Create a log file
RUN touch /var/log/cron.log

## Copy Laravel application files
COPY ./laravel /opt/html

# Add cron job directly to crontab
#RUN echo "* * * * * /usr/local/bin/php /opt/html/artisan schedule:run >> /var/log/cron.log 2>&1" | crontab -

RUN apk add tzdata && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY ./docker/entrypoint-octane.sh /opt/entrypoint.sh

RUN chmod +x /opt/entrypoint.sh

WORKDIR /opt/html

CMD ["/opt/entrypoint.sh"]