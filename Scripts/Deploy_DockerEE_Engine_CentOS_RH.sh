#!/bin/bash
# Install Docker EE - CentOS/Redhat
# pre-req - must be run with Root permssions

#Define User acount
        username="sowens" # You linux user account
#Define Repo Store URL - Get from Docker Store
    EEREPO="https://storebits.docker.com/ee/trial/sub-a8c13ebb-fd06-4a31-abe2-e15b621af6ec"
#Define storage driver
    storagedriver="devicemapper"
#Define the swarm role
    swarmrole="manager" # manager, worker, none
#Define swarm manager key
    swarmmanagerkey="xxx"
#Get the Node IP Address
    nodeip=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

#remove old version of docker
        yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine \
                  docker-ce \
                  docker-ce-cli \
                  docker-ee

    rm /etc/yum.repos.d/docker*.repo --force

#Configure the Repo
    export DOCKERURL="${EEREPO}"
    sudo -E sh -c 'echo "$DOCKERURL/centos" > /etc/yum/vars/dockerurl'

#Install required packages
    yum install -y yum-utils \
    device-mapper-persistent-data \
    lvm2

#Add the Docker EE stable repository:
    sudo -E yum-config-manager \
    --add-repo \
    "$DOCKERURL/centos/docker-ee.repo"

#Install Docker EE
    yum-config-manager --enable docker-ee-stable-17.06
    yum -y install docker-ee

#Start Docker Engine
    systemctl enable docker && systemctl start docker && systemctl status docker

#Update docker group permission to alow more the root to run docker (Command only workds with Sudo su -)
    usermod -a -G docker ${username}

#Configure Storage Driver
    touch /etc/docker/daemon.json
    echo '{"storage-driver":"'${storagedriver}'"}' >> /etc/docker/daemon.json
    systemctl restart docker

#Leave the Docker Swarm
    docker swarm leave --force

#Join Docker Swarm

    if [ "$swarmrole" != "none" ]; then 
        if [ "$swarmrole" = "manager" ]; then
            docker swarm init --advertise-addr $nodeip
        elif [ "$swarmrole" = "worker" ]; then
            Docker swarm join --token ${swarmmanagerkey} ${nodeip}:2377
        fi
    fi


## token=`docker -H app.swarm:2376 swarm join-token worker|grep token|awk '{print $5}'`