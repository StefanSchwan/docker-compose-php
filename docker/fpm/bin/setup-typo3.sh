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

if ! type "typo3cms" > /dev/null; then
  echo "typo3cms not in path, check composer run. Aborting"
  exit 1
fi

typo3cms install:setup \
  --non-interactive \
  --database-user-name $MYSQL_USER \
  --database-user-password $MYSQL_PASSWORD \
  --database-host-name mariadb \
  --database-name $MYSQL_DATABASE \
  --use-existing-database $MYSQL_DATABASE \
  --admin-user-name $TYPO3_ADMINUSER \
  --admin-password $TYPO3_ADMINPASSWORD \
  --site-name $TYPO3_SITENAME

typo3cms configuration:set MAIL/transport smtp
typo3cms configuration:set MAIL/transport_smtp_server mail:1025
typo3cms extension:activate extension_builder


echo "keepfile" > /var/www/html/docroot/typo3conf/ENABLE_INSTALL_TOOL
