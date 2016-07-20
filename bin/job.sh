#!/bin/sh
DATE=`date +%Y-%m-%d`
mysqldump --user=$MYSQL_USER --password=$MYSQL_PASSWORD --host=$MYSQL_SERVICE_HOST $MYSQL_DATABASE | gzip > $BACKUP_DATA_DIR/dump-${DATE}.sql.gz

# Delete old files
old_dumps=$(ls -1 $BACKUP_DATA_DIR/dump* | head -n -$BACKUP_KEEP)
if [ "$old_dumps" ]; then
    echo "Deleting: $old_dumps"
    rm $old_dumps
fi
