#!/bin/bash
#Select a docker storage device (CentOS)

#find out what storage device docker engine is using
docker info | grep Storage

#Change docker storage driver (Run as sudo)
cd /etc/docker
touch daemon.json
echo '{"storage-driver":"devicemapper"}' >> daemon.json
systemctl restart docker


#Where the images will be located after channging storage driver
cd /var/lib/docker
cd devicemapper

