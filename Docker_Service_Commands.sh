#!/bin/bash

#List docker services
docker service ls 

#Show details of a docker service
docker service ps {servicename}

#Create a basic docker httpd service - on a single node in replicated mode - Cant change modes once created
docker service create --name {servicename} -p 80:80 httpd

#Create a basic docker httpd service - in global mode (if you scale node containers will automaticly start the new node instance)
docker service create --name {servicename} -p 80:80 --mode global httpd

#Scale a docker service to x container replicas
docker service update --replicas {number} {servicename}

#Scale a docker service to x container replicas (Older version shows visualisation)
docker service update --replicas {number} --detach=false {servicename}

#Limit & Reserve CPU for a service
docker service update --limit-cpu={number} --reserve-cpu={number} {servicename}

#Limit & Reserve Memory for a service
docker service update --limit-memory={number} --reserve-memory={number} {servicename} # Minimum memory is 4mb's

#scale a service
docker service scale {servicename}={number}

#scale multiple service docker
service scale {servicename}={number} {servicename}={number}

#Templae Usage with Service create
docker service create --name {servicename} --hostname="{{.Node.ID}}-{{.Service.Name}}" {imagname}

#Start a container on a node based on node tag
docker container create --name {servicename} -p 8081:80 --constrain 'node.labels.{key} == {value}' --replicas {number} -- httpd

 #rebalance services across swarm nodes after a node rebuild
 docker service update --force {servicename}