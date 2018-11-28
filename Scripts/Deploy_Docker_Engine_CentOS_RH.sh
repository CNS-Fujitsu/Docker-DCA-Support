#!/bin/bash
# Install Docker Engine (Production Repo) - CentOS/Redhat
# pre-req - must be run with Root permssions

#Define User acount
    username="user" # You linux user account
    storagedriver="devicemapper"

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
                  docker-ce-cli

    rm /etc/yum.repos.d/docker*.repo --force

#Install Docker Packages
    yum install -y yum-utils device-mapper-persistent-data lvm2
    yum-config-manager --add-repo "https://download.docker.com/linux/centos/docker-ce.repo"
    yum update -y
    yum install -y "docker-ce"



#Start Docker Engine
    systemctl enable docker && systemctl start docker && systemctl status docker

#Update docker group permission to alow more the root to run docker (Commnad only workds with Sudo su -)
    usermod -a -G docker ${username}
    cat /etc/group

#Configure Storage Driver
    touch /etc/docker/daemon.json
    echo '{"storage-driver":"'${storagedriver}'"}' >> /etc/docker/daemon.json
    systemctl restart docker