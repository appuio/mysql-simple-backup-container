#!/bin/sh
mysqldump --user=$MYSQL_USER --password=$MYSQL_PASSWORD --host=$MYSQL_SERVICE_HOST $MYSQL_DATABASE > $BACKUP_DATA_DIR/dump.sql
