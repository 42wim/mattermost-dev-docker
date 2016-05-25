#!/bin/bash
MYSQL_ALLOW_EMPTY_PASSWORD=true /entrypoint.sh mysqld &

echo "Wait until database is ready..."
until nc -z localhost 3306
do
    sleep 1
done

mysql -uroot -e 'CREATE DATABASE IF NOT EXISTS `mattermost` DEFAULT CHARACTER SET `utf8` COLLATE `utf8_unicode_ci`;'

cp /config.template.json /mattermost/config/config.json

echo "Starting platform"
cd /mattermost/bin
./platform $*
