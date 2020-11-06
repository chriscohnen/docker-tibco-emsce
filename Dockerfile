# TIBCO Enterprise Messaging Community Edition - Example Docker Container Build
FROM centos:7
# docker build --tag centos7:1.0 . 
LABEL MAINTAINER="Christian Cohnen <christian.cohnen@sciencentric.de>"

# download install file first !
# https://edownloads.tibco.com/Installers/tap/EMS-CE/8.5.1/TIB_ems-ce_8.5.1_linux_x86_64.zip
ENV UID=1000
ENV GID=1000
ENV USER=tibadmin
ENV GROUP=tibco

ADD TIB_ems-ce_8.5.1_linux_x86_64.zip /tmp/install/
RUN yum install unzip -y


RUN groupadd -r $GROUP -g $GID && \
    useradd -u $UID -r -m -g $GROUP -d /home/$USER -s /bin/bash -c "tibco admin user" tibadmin && \
 	chown -R $USER:$GROUP /home/$USER && \
	mkdir /opt/tibco /cfgmgmt /ems /ems/datastore && \
	chown -R $USER:$GROUP /ems /opt/tibco /tmp/install 

RUN  yum clean all && \
    rm -rf /var/cache/yum

RUN unzip /tmp/install/TIB_ems*.zip -d /tmp/install/tibems/ 
RUN yum install -y /tmp/install/tibems/TIB_ems-ce_8.5.1/rpm/*.rpm 
RUN rm -rf /tmp/install/tibems /tmp/install/TIB_ems*.zip
RUN	chown -R $USER:$GROUP /opt/tibco /cfgmgmt
USER $USER
RUN cp -r /opt/tibco/ems/8.5/samples/config/* /cfgmgmt

EXPOSE 7222
VOLUME ["/ems" ]
WORKDIR /ems
ENTRYPOINT ["/opt/tibco/ems/8.5/bin/tibemsd", "-config", "/cfgmgmt/tibemsd.conf"]
#ENTRYPOINT ["/bin/bash"]
