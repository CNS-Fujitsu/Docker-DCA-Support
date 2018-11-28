#!/bin/bash

#System Log Messages on Centos
cat /var/log/messages | grep  [dD]ocker | more

#System Log Messages on Ubuntu
cat /var/log/daemon | grep  [dD]ocker | more

#Container Logs
docker container logs {containername}

#Service Logs
docker service logs {servicename}
