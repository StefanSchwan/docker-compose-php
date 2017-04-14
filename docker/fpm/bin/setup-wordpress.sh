#!/bin/bash

#check if we are ready to go

if [ -z $MYSQL_DATABASE ]
then
  echo "Env not set, aborting"
  exit 1
fi

if ! mysqlshow -h mariadb -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE > /dev/null 2>&1; then
  echo "Database error, aborting"
  exit 1
fi

if ! type "wp" > /dev/null; then
  echo "wp_cli not in path, check composer run. Aborting"
  exit 1
fi

 wp core config \
    --allow-root \
    --path='/var/www/html/docroot' \
    --dbhost=mariadb \
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --locale=$WP_LOCLAE

wp core install \
   --allow-root \
   --path='/var/www/html/docroot' \
   --url=$WP_URL \
   --title=$WP_TITLE \
   --admin_user=$WP_ADMINUSER \
   --admin_password=$WP_ADMINPASSWORD \
   --admin_email=$WP_ADMINEMAIL
