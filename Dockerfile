FROM openshift/base-centos7

USER root

RUN yum -y install python \
    python-devel \
    python-pip \
    mercurial && yum clean all

# Install dev cron
RUN pip install -e hg+https://bitbucket.org/dbenamy/devcron#egg=devcron

ADD ./etc/crontab /cron/crontab
ADD ./bin/job.sh /opt/app-root/src/bin/

USER 1001

CMD ["devcron.py", "/cron/crontab"]
