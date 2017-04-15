#ARGS = $(filter-out $@,$(MAKECMDGOALS))
compass-path=""
MAKEFLAGS += --silent

DC = docker-compose

shell:
	${DC} run php_fpm bash

setup-typo3:
	${DC} run php_fpm cp /var/www/html/composer-typo3.json /var/www/html/composer.json
	${DC} run composer install
	${DC} run php_fpm bash /opt/docker/bin/setup-typo3.sh

setup-wordpress:
		${DC} run php_fpm cp /var/www/html/composer-wordpress.json /var/www/html/composer.json
		${DC} run composer install
		${DC} run php-fpm bash /opt/docker/bin/setup-typo3.sh

update:
	${DC} run composer update

restart:
	${DC} down
	${DC} up

clean:
	#USE WITH CAUTION!
	git clean -xfd
