FROM openshift/base-centos7

USER root

ENV BACKUP_DATA_DIR=/tmp BACKUP_KEEP=2 BACKUP_MINUTE=* BACKUP_HOUR=*

RUN yum -y install python \
    python-devel \
    python-pip \
    mercurial \
    mysql && yum clean all

# Install dev cron
RUN pip install -e hg+https://bitbucket.org/dbenamy/devcron#egg=devcron

WORKDIR /opt/app-root/src

RUN /bin/sh -c 'echo "$BACKUP_MINUTE $BACKUP_HOUR * * * /opt/app-root/src/job.sh" > crontab'
ADD ./bin/job.sh job.sh

USER 1001

CMD ["devcron.py", "crontab"]
