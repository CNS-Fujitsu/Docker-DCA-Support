#!/bin/bash
#UCP Installation
#Pre-req - Swarm cluster configured
# Deploy UCP on the manager using the manager
docker container run --rm -it --name ucp -v /var/run/docker.sock:/var/run/docker.sock docker/ucp install --host-address 172.31.106.71 --interactive

#Backup UCP
mkdir /DockerBak
cd DockerBak
docker container run --log-driver non --rm -i --name ucp -v /var/run/docker.sock:/var/run/docker.sock docker/ucp backup --id wtwet3tv5tyv534tv > ucp-backup.tar

#Restore UCP
docker container run --log-driver non --rm -i --name ucp -v /var/run/docker.sock:/var/run/docker.sock docker/ucp restore --id wtwet3tv5tyv534tv < ucp-backup.tar

# Deploy DTR - Use UCP to create the following command
docker run -it --rm docker/dtr install --ucp-node {nodename},cin --ucp-username admin --ucp-url https://node:443 --ucp-insecure-tls

#Backup DTR - Solution offline during backup
mkdir /DockerBak
cd DockerBak
docker run -i --rm docker/dtp backup --ucp-insecure-tls --ucp-url https://node:443 --ucp-username admin --ucp-password password > dtr-backup.tar

#Restore DTR
docker run -i --rm docker/dtp restore --ucp-insecure-tls --ucp-url https://node:443 --ucp-username admin --ucp-password password < dtr-backup.tar


docker container run --rm -it --name ucp -v /var/run/docker.sock:/var/run/docker.sock docker/ucp install --host-address 172.31.106.71 --interactive