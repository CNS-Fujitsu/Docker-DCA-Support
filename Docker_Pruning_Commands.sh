#!/bin/bash

#Commands only remove from one node

#Remove all unused dangling images, containers, networks, dangling build cache - User Created
docker system prune

#Remove all unused dangling images, containers, networks, dangling build cache and volumes - User Created
docker system prune --volumes

#Remove all unused images, containers, networks, build cache - User Created
docker system prune -a

#Remove all unused images, containers, networks, build cache and volumes - User Created
docker system prune -a --volumes