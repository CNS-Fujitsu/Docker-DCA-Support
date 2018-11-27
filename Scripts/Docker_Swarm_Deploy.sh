#!/bin/bash

#Setup a single swarm manager
docker swarm init --advertise-addr x.x.x.x #Host IP Address

#Setup a single swarm manager - Locked
docker swarm init --auto-lock --advertise-addr x.x.x.x

#Set Docker Swarm to locked
docker swarm update --autolock=true # save the unlock code

#Set Docker Swarm to unlocked
docker swarm update --autolock=false

#Start Locked Docker swarm after reboot
docker swarm unlock #the provide unlock code

#Get Docker swarm unlock code if unlocked
docker swarm unlock-key

#Swarm unlock key rotation
docker swarm unlock-key --rotate

#Save the token to add nodes to a swarm
# token example - Docker swarm join --token SWMTKN-1-3bn34bn3kbjb56jb5jktbnjbnjtnvjtn635j6v3j56v3jbn6v x.x.x.x:2377

#Re-get the worker node token
docker swarm join-token worker

#Add a swarm worker
Docker swarm join --token SWMTKN-1-3bn34bn3kbjb56jb5jktbnjbnjtnvjtn635j6v3j56v3jbn6v x.x.x.x:2377

#Re-get the manager node token
docker swarm join-token manager

#Add additional swarm manager
Docker swarm join --token SWMTKN-1-3bn34bn3kbjb56jb5jktbnjbnjtnvjtn635j6v3j56v3jbn6v x.x.x.x:2377

#Get swarm node info on the manager
docker node ls

#Leave a swarm
docker swarm leave

#Backup a Docker Swarm
sudo systemctl stop docker
mkdir /swarm
cd swarm
cp -rf /var/lib/docker/swarm/ .
tar cvf swarm.tar swarm/
scp swarm.tar username@hostname:/home/user

#Restore a Docker Swarm
sudo systemctl stop docker
cd /home/user
mkdir tmp
cd tmp/
tar xvf ../swarm.tar
cd swarm
mv swarm/ /var/lib/docker
sudo systemctl start docker
docker swarm init --force-new-cluster

#Add labels to swarm nodes
 docker node update --label-add {key}={value} {node_id}

