#!/bin/bash


#Deploy a docker-compose application in detached mode on single host
docker-compose up -d .

#Information about containers start on host with compose
docker-compose ps

#Stop the docker containers in the compose
docker-compose down --volumes

#Deploy a docker-compose application stack of hosts
docker stack deploy --compose-file {docker-compose File Name} {stackname}
