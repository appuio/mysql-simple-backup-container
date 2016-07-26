# APPUiO Simple MySQL Backup Pod


## How to deploy

### Create New OpenShift Project
```
$ oc project mymysqlproject
```

### Create Application and configure dc
```
$ oc new-app https://github.com/appuio/mysql-simple-backup-container.git --strategy=docker

$ oc env dc mysql-simple-backup-container -e MYSQL_USER=user -e MYSQL_PASSWORD=pw -e MYSQL_SERVICE_HOST=mysql -e MYSQL_DATABASE=database -e BACKUP_DATA_DIR=/tmp/ -e BACKUP_KEEP=5 -e BACKUP_MINUTE=10 -e BACKUP_HOUR=11,23
```

### Restore Database
```
$ oc get pods
$ oc rsh mysql-simple-backup-container-#-#####
$ gunzip < /opt/app-root/backup/dump-yyyy-mm-dd-hh-mm.sql.gz | mysql -h $MYSQL_SERVICE_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE
```

### Template

**Create the central image build**
```
$ oc new-app -f template-build.json -n openshift
```

Use the following commands to instanciate the backup container.

**Without persistent storage attached**
```
$ oc new-app -f template-ephemeral.json -p MYSQL_DATABASE=database -p MYSQL_USER=user -p MYSQL_PASSWORD=pw

```

**With persistent storage**
```
$ oc new-app -f template-persistent.json -p MYSQL_DATABASE=database -p MYSQL_USER=user -p MYSQL_PASSWORD=pw -p VOLUME_CAPACITY=2GBi

```


### Configuration

set the following Envs

* MYSQL_USER
* MYSQL_PASSWORD
* MYSQL_SERVICE_HOST, the mysql host, on ose 3 the service name (eg. mysql)
* MYSQL_DATABASE, the database you want to backup
* BACKUP_DATA_DIR, where to store the Backups, typically this directory would be a persistent Volume
* BACKUP_KEEP, how many Backups are kept
* BACKUP_MINUTE, cron Minute (eg. 10)
* BACKUP_HOUR, cron Hour (eg. 11,23) every day at 11am and 11pm
