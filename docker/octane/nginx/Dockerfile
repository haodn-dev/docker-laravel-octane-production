FROM nginx:1.20-alpine

## Copy Laravel application files
COPY ./laravel /opt/html

RUN mkdir "/opt/logs/" && mkdir "/opt/logs/nginx/" && touch /opt/logs/nginx/access.log
RUN apk add wrk

### Copy Nginx configuration
COPY ./docker/octane/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
