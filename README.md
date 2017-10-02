# APPUiO Simple MySQL Backup Pod

## How to deploy the backup container
Before executing the following commands make sure that you are logged into Openshift via the commandline (`oc login`) and using the correct project (`oc project`). The mysql service doesn't have to be located in the same project, if you can access it remotely.

```
$ oc new-app https://github.com/appuio/mysql-simple-backup-container.git --strategy=docker

$ oc env dc mysql-simple-backup-container -e MYSQL_USER=user -e MYSQL_PASSWORD=pw -e MYSQL_SERVICE_HOST=mysql -e MYSQL_DATABASE=database -e BACKUP_DATA_DIR=/tmp/ -e BACKUP_KEEP=5 -e BACKUP_MINUTE=10 -e BACKUP_HOUR=11

$ oc rollout latest mysql-simple-backup-container
```
**Note:** For values with comma (eg. 11,23) you will have to edit the dc with vim: `oc edit dc mysql-simple-backup-container`

## Restore Database
```
$ oc get pods
$ oc rsh mysql-simple-backup-container-#-#####
$ gunzip < /opt/app-root/backup/dump-yyyy-mm-dd-hh-mm.sql.gz | mysql -h $MYSQL_SERVICE_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE
```

## Alternative deploy variant (single build, multiple deploys)
If you have a few projects that require mysql backups it makes sense to have a central build. The following command only builds the image in the openshift namespace.

**Create the central image build**
```
$ oc new-app -f template-build.json -n openshift
```
Since the image is already built, you can now deploy it multiple times in different projects and reference the same build. This allows you to update one central build and trigger multiple redeploys. Make sure you are in the correct project and run the following command.
```
$ oc new-app -f template-persistent.json -p MYSQL_DATABASE=database -p MYSQL_USER=user -p MYSQL_PASSWORD=pw -p BACKUP_VOLUME_CAPACITY=2Gi
```

## Configuration

set the following Envs

* MYSQL_USER
* MYSQL_PASSWORD
* MYSQL_SERVICE_HOST, the mysql host, on ose 3 the service name (eg. mysql)
* MYSQL_DATABASE, the database you want to backup
* BACKUP_DATA_DIR, where to store the Backups, typically this directory would be a persistent Volume
* BACKUP_KEEP, how many Backups are kept
* BACKUP_MINUTE, cron Minute (eg. 10)
* BACKUP_HOUR, cron Hour (eg. 11,23) every day at 11am and 11pm
* BACKUP_VOLUME_CAPACITY, size of backup persistent volume (only needed when persistent storage template was used)
