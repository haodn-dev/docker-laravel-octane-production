Larvel With Docker Optimize
===============

Configuration
-------------
copy the env.{environment}.example file to env and fill in the values

- dev mode

    ```cp env.dev.example .env ```

- prod mode

    ```cp env.production.example .env ```

Run with docker 
---------------

- We got 4 option running the app with docker :
  - dev
  - dev-optimize
  - prod
  - prod-optimize
  
  To run each option, please change the COMPOSE_FILE in .env of docker (not laravel/.env)
  The difference between option:
  - dev : running the app with xdebug enabled, mount all project directory to container (including vendor) this will
    make the application slower in Windows environment, but we can run the app without need to sync the changes
  - dev-optimize : running the app with xdebug enabled, copy all project directory to container (except vendor) this
    will make the application faster, but we need to run ```docker compose watch``` to sync the changes
  - prod : running the app without xdebug, mount all project directory to container
  - prod-optimize : running the app without xdebug, copy all project directory to container (except vendor)

_Note_ : in dev,prod,prod-optimize mode we're using command ```docker-compose up -d``` to run the app, in dev-optimize mode we're using command ```docker compose watch``` to sync the changes

**_Note_** 
-----------
- **Xdebug** in development mode is enabled by default, running at port 9005
- **For sync vendor** from container to host after watch, we can use command 
  
  ```docker cp laravel_app:/opt/html/vendor D:\workspace\OrderHistory_API\laravel/```
- For watch nginx and php-fpm logs, we can use command 
  
  ```tail -f logs/nginx/access.log & tail -f logs/php-fpm/www.access.log```
