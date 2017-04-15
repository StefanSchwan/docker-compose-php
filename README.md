# docker-compose-php

Composer based dockerized PHP Application Development Containers inspired by   [webdevops/TYPO3-docker-boilerplate](https://github.com/webdevops/TYPO3-docker-boilerplate)

## Requirements
Docker and docker-compose optionally GNU Make, tested on Mac OS X and Ubuntu 16.04.

## tl;dr
```
sudo echo "127.0.0.1 typo3.local" >> /etc/hosts
cp app/web/composer-typo3.json app/web/composer.json
docker-compose build
docker-compose up
docker-compose run composer install
docker-compose run php-fpm bash /opt/docker/bin/setup-typo3.sh
```


## Overview

The goal of this Project is to quickly get composer based PHP Projects up an running for development. The Application lives in app/web which is included in .gitignore.

To start, build and start the containers by running ```docker-compose up``` in the project's base dir, edit your /etc/hosts file to match the FQDN configured in etc/environment (127.0.0.1 docker.local) and finally point you webbrowser to http://docker.local/info.php to see the systems's phpinfo.

Composer is provided as an Application Container and shared it's relevant file system with FPM.
Executing ```docker-compose run composer install``` will install packages defined in a composer.json file in app/web/
This file does not exist by default. You can either use your own or copy the provided composer-typo3.json or composer-wordpress.json to composer.json.
Furhter automation of TYPO3 and Wordpress are provided and can be executed by running ```make setup-typo3``` or ```make setup-wordpress```


## Configuration

Most of the Configuration is done in /etc/environment.yml

## Containers

```docker-compose up``` will set up serveral services:

### nginx

The nginx container is called 'web' so it can be replaced by Apache, which is also avaiable but commented out.
Nginx is build from nginx:stable-alpine with only minor customizations:
  * Some shell packages (bash, vim, less and alike) are installed if you ever have to log into the container to do debugging.
  * Nginx can not handle environment variables in it's config. The default command is extended in docker-compose to use envsubst to inject the values into a template like suggested [here](https://github.com/docker-library/docs/issues/496)

The Nginx container is the place where this project's ./app/web folder is mounted to the container's /var/www/html filesystem. All other containers that need access to the filesystem use ```volumes_from``` in docker-compose.

At the moment, nginx's default.conf is configured for TYPO3. If you want to use this Project for Wordpress or other systems, you should optimze the file in docker/nginx_fpm_tcp/etc/default.conf and rebuild the container ```docker-compose build web```

### FPM

The FPM Container is based on php:7.0-fpm-alpine. The Dockerfile adds several shell packages and PHP extensions. All PHP modules needed for TYPO3 are installed, xdebug is set up. GO is installed to forward mail to mailhog.

### mariadb

Based on the mariadb image, only the default command is altered to change the default latin1 to utf8


### composer

Composer is set up as an Application container (composer/composer:php7). It's entrypoint is set to ```composer`` so all arguments applied to ```docker-compose run compser [arguments]``` translate to composer commands. eg ```docker-compose run composer update``` will update the composer packages of app/web/composer.json

### mailhog

Mailhog will intercept all mailtraffic send from PHP and present it on a webgui which is avaiable on http://localhost:8025


### compass

The compass container is ruby compass as an application container. Try ```docker-compose run compass watch /var/www/html/[path to your config.rb]```
