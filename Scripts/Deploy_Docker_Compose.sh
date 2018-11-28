#!/bin/bash

#Install Docker Compose (v3)
    yum install -y epel-release
    yum install -y pyhton-pip
    pip install --upgrade pip
    pip install --upgrade --force-reinstall pip==9.0.3 # Temporay work around as PIP version 10.x causes next command to fail
    pip install docker-compose

