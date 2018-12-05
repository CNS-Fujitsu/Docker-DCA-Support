#!/bin/bash
# Install Docker EE - CentOS/Redhat
# pre-req - must be run with Root permssions
#usage ./Deploy_DockerEE_Engine_CentOS_RH_v1_1 "username" "Storage Driver" "Swarm Role" "Manager Host Name"
#Options....!
# username - provide username to be assigned to the docker group (Always Required)
# storage Driver - storage driver to be use - i.e devicemapper (Always Required)
# Swarm Role - role in a swarm cluster, chose item below (Always Required)
#   - none (not a swarm member)
#   - firstmanager (first swarm manager in a swarm cluster)
#   - manager (additional swarm manager in a swarm cluster)
#   - worker (worker node in a swarm cluster)
# Manager Host Name - Hostsname of swarm master (Not required if deploying firstmanager)
set -x

#Define Repo Store URL - Get from Docker Store
    EEREPO="https://storebits.docker.com/ee/trial/sub-a8c13ebb-fd06-4a31-abe2-e15b621af6ec"


#Config Varibales
    username="${1}"
    storagedriver="${2}"
    swarmrole="${3}"
    managername="${4}"
    managerkey="SWMTKN-1-3ahuvpjc37d7fylrdccpztww76p04fq7kgg10ravs0r4ozur3l-ab7w0huc3ezlslbnpygupzful"
    workerkey="SWMTKN-1-3ahuvpjc37d7fylrdccpztww76p04fq7kgg10ravs0r4ozur3l-ab7w0huc3ezlslbnpygupzful"
    stableversion="docker-ee-stable-18.09"

validatevars() {
    #validate that varables are valid
        if [ -z "${1}" ]; then
        echo "The Username was not provided"
        exit 1
        elif [ -z "${2}" ]; then
        echo "The storage driver was not provided"
        exit 1
        elif [ -z "${3}" ]; then
        echo "The swarm role was not provided"
        exit 1
        elif [ "${3}" = "manager" ]; then
            if [ -z "${4}" ]; then
                echo "The manager hostname was not provided"
                exit 1
            fi
        elif [ "${3}" = "worker" ]; then
            if [ -z "${4}" ]; then
                echo "The manager hostname was not provided"
                exit 1
            fi
        fi

    }

dockerdaemoninstall() {
    #Configure the Repo
        sh -c 'echo "'"${1}"'/centos" > /etc/yum/vars/dockerurl'

    #Install required packages
        yum install -y yum-utils \
        device-mapper-persistent-data \
        lvm2

    #Add the Docker EE stable repository:
        yum-config-manager --add-repo "${1}/centos/docker-ee.repo"

    #Install Docker EE
        yum-config-manager --enable ${2}
        yum -y install docker-ee

    #Start Docker Engine
        systemctl enable docker && systemctl start docker && systemctl status docker
    }

dockeruser() {
    #Update docker group permission to alow more the root to run docker (Command only workds with Sudo su -)
        usermod -a -G docker "${1}"
    }

dockerstoragedriver () {
    #Configure Storage Driver
        touch /etc/docker/daemon.json
        echo '{"storage-driver":"'"${1}"'"}' >> /etc/docker/daemon.json
        systemctl restart docker
    }

dockerswarmjoin() {
    #Join Docker Swarm
        if [ "${1}" != "none" ]; then 
            if [ "${1}" = "firstmanager" ]; then
                docker swarm init --advertise-addr "$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)"
                swnmanagerkey="$(docker swarm join-token manager)"
                echo "swarmmanagerkey:'${swnmanagerkey}'"
                swnworkerkey="$(docker swarm join-token worker)"
                echo "swarmworkerkey:'${swnworkerkey}'"
            elif [ "${1}" = "manager" ]; then
                docker swarm join --token "${3}" "${2}":2377
            elif [ "${1}" = "worker" ]; then
                docker swarm join --token "${4}" "${2}":2377
            fi
        fi
    }

main() {
    #run script functions
        validatevars "${2}" "${3}" "${4}" "${5}"
        dockerdaemoninstall "${1}" "${8}"
        dockeruser "${2}"
        dockerstoragedriver "${3}"
        dockerswarmjoin "${4}" "${5}" "${6}" "${7}"
}

#Run the main script
main "${EEREPO}" "${username}" "${storagedriver}" "${swarmrole}" "${managername}" "${managerkey}" "${workerkey}" "${stableversion}"