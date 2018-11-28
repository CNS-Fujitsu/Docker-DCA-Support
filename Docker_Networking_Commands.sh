#!/bin/bash

#Show Docker Networks
docker network ls

#Inspect a docker network
docker network inspect {networkname}

#Create a bridge network and set 1 of the 5 options
docker network create --driver bridge --subnet 192.168.2.0/24 --opt "com.docker.network.drive.mtu"="1501" {netowrkname}

#Create a overlay network and set 1 of the 5 options
docker network create --driver overlay --subnet 192.168.2.0/24 --gateway=192.168.2.254 --opt "com.docker.network.drive.mtu"="1501" {netowrkname}

#Conenct a container to a network
docker network connect --ip={IPAddress} {networkname} {containername}

#Disconnect from a network
docker network connect {networkname} {containername}

#Change container DNS server for single container
docker container run --name {containername} --dns={dnsserver1ip} --dns={dnsserver2ip} -p {hostport}:{containerport} {containerimage}


#Change DNS servers all containers running on a host
cd /etc/docker/
echo '{"dns":["8.8.8.8","8.8.4.4"]}'  >> daemon.json
systemctl restart docker

#check linux DNS config
cat /etc/resolv.conf

#Docker overlay network across the swarm nodes (create over network on master first)
docker service create --name {servicename} -p {hostport}:{containerport} --network={netowrkname} --repl
icas {number} {imagename}

#Remove a network from a service
docker service update --network-rm={networkname} {servicename}
