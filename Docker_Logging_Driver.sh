#!/bin/bash
#Select a docker storage device (CentOS)

#find out what storage device docker engine is using
docker info | grep Logging

#Change docker logging driver (Run as sudo)
cd /etc/docker
vim daemon.json

#Configure the syslog
    {"log-drive":"syslog",
        "log-opts": {
            "syhslog-address":"udp://x.x.x.x:514",
        }
    }

systemctl restart docker

