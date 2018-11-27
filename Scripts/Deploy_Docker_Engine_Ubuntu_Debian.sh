#!/bin/bash
# Install Docker Engine (Production Repo) - CentOS/Redhat
# pre-req - must be run with Root permssions

#Select the Docker Edition
    version="ce" # Options ee (Docker Enterprise Edition) or ce (Docker Communitiy Edition)
#Define User acount
    username="user" # You linux user account

#Get Docker Packages
    apt-get -y install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get -y update

#Install Docker Packages
    apt-get -y install docker-${version}

#Start Docker Engine
    service docker status

#Update docker group permission to allow more than root to run docker command
    usermod -aG docker ${username}
