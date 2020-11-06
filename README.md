# TIBCO Enterprise Messaging Community Edition - Example Docker Container Build


The repository provides a simple container build for TIBCO EMS.
Purpose is to get started und running in 2 minutes.
Container Instance can be used to develope JMS clients, train tibemsadmin console.  

To use TICO EMS in real life projects a licensed Enterprise Version might be needed. 
Please read the TIBCO EMS Community Edition End User License Aggreement before any kind of commercial use.

## Prerequisites
- Docker installation
- Download of TIBCO Installation file

TIBCO Software is available here:
https://www.tibco.com/resources/product-download/tibco-enterprise-message-service-community-edition--free-download-0
to download End User License agreement must be accepted.

Documentation by TIBCO for this version is available here:
https://docs.tibco.com/products/tibco-enterprise-message-service-community-edition-8-5-1


## good to know before start, some Limitations of CE are
- max of 100 client instances
- no fault tolerance of the server
- no unshared state failover
- no server to server routing of messages
- no JSON configuration
- no Central Administration User Interface (EMSCA)

## container persistence
A volume can be used to persist message and configuration of the EMS server

## build & run
download repository & build container:

```
docker build --tag tibcoems:8.5 .
```

start container:
```
docker run -t -d \ 
       -v $PWD/ems:/ems:rw \
       -p 7222:7222 \
       --name tibems tibcoems:8.5  
```
log files:
```
docker logs tibems
```
## accessing the administration console
```
docker exec -it tibems /opt/tibco/ems/8.5/bin/tibemsadmin
```
## additional infos and room for improvements
- If you already have a TIBCO EMS Enterprise Editionlicense/software, there is a tibemscreateimage script provided by TIBCO
  for creating a docker container. 
- This image is not optimized for size, a centos base image was used 
- all TIBCO EMS rpm are installed, you might want to leave out some 



