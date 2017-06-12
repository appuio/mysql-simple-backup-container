#!/bin/sh
if [ -z $BACKUP_DATA_DIR ]; then
    echo '$BACKUP_DATA_DIR must be set'
    exit 1
fi
echo "$BACKUP_MINUTE $BACKUP_HOUR * * * /opt/app-root/src/bin/job.sh" > /opt/app-root/src/crontab
devcron.py /opt/app-root/src/crontab
