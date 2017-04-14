#ARGS = $(filter-out $@,$(MAKECMDGOALS))
compass-path=""
MAKEFLAGS += --silent

DC = docker-compose

shell:
	${DC} run php_fpm bash

build-typo3:
	${DC} build
	${DC} up -d
	${DC} run php_fpm cp /var/www/html/composer-typo3.json /var/www/html/composer.json
	${DC} run composer install
	${DC} run php_fpm bash /opt/docker/bin/setup-typo3.sh

build-wordpress:
		${DC} build
		${DC} up -d
		${DC} run php-fpm ln -s /var/www/html/composer-wordpress.json /var/www/html/composer.json
		${DC} run composer install
		${DC} run php-fpm bash /opt/docker/bin/setup-typo3.sh

update:
	${DC} run composer update

restart:
	${DC} down
	${DC} up
