# APPUiO Simple MySQL Backup Pod


## How to deploy

### CLI / oc Client

#### Create New OpenShift Project
```
$ oc project mymysqlproject
```

#### Create Application and configure dc
```
$ oc new-app https://github.com/appuio/mysql-simple-backup-container.git --strategy=docker

$ oc oc env dc mysql-simple-backup-container -e MYSQL_USER=user -e MYSQL_PASSWORD=pw -e MYSQL_SERVICE_HOST=mysql -e MYSQL_DATABASE=database -e BACKUP_DATA_DIR=/tmp/ -e BACKUP_KEEP=5 -e BACKUP_MINUTE=10 -e BACKUP_HOUR=11,23
```

#### Configuration

set the following Envs

* MYSQL_USER
* MYSQL_PASSWORD
* MYSQL_SERVICE_HOST, the mysql host, on ose 3 the service name (eg. mysql)
* MYSQL_DATABASE, the database you want to backup
* BACKUP_DATA_DIR, where to store the Backups, typically this directory would be a persistent Volume
* BACKUP_KEEP, how many Backups are kept
* BACKUP_MINUTE, cron Minute (eg. 10) 
* BACKUP_HOUR, cron Hour (eg. 11,23) every day at 11am and 11pm
