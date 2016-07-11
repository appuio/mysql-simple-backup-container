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

$ oc oc env dc mysql-simple-backup-container -e MYSQL_USER=user -e MYSQL_PASSWORD=pw -e MYSQL_SERVICE_HOST=mysql -e MYSQL_DATABASE=database -e BACKUP_DATA_DIR=/tmp/
```
