FROM nginx:1.20-alpine

## Copy Laravel application files
COPY ./laravel /opt/html
#
### Copy Nginx configuration
COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
