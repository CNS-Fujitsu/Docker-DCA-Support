#!/bin/bash

#create a volume on a single node
docker volume create {volumename}

#Mount a volumne on a service
docker service create --name {servicename} -p {hostport}:{containerport} --mount source={volumename},target={pwd} httpd