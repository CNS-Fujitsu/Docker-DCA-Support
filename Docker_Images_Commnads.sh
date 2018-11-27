#Docker Image Comands
docker image

#Show all docker images
docker images

#Show all docker images with Digest
docker images --digests

#Show docker Images - Filter Options
docker images --filter "before=centos:6"
docker images --filter "since=centos:6"

#Show docker Images - Ids Only
docker images --quiet

#Show docker Images - Full Image Id
docker images --no-trunc

#Show docker Images - Individual Image
docker images {imagename}

#Download a docker image - Latest Tag
docker pull hello-world

#Dowload Docker Image - individual Tags
docker pull hello-world:linux

#Dowload Docker Image - all Tags
docker pull -a hello-world

#Dowload Docker Image - Untrusted Image
docker pull --disable-content-trust hello-world

#Search for Docker Images - all Images with keyword
docker search centos

#Search for Docker Images - Based on Star level
docker search --filter stars=50 centos

#Search for Docker Repository for Images - Based on Star level and offical status
docker search --filter "stars=50" --filter "is-official=true" centos

#Remove a local container image
docker rmi {imagename}

#Tag a Docker Image
docker tag {CurrentImageName:Tag} {NewImageName:Tag}
docker tag centos:6 mycentos:v1

#Tag a Docker Image and Include repo
docker tag {CurrentImageName:Tag} {RepoName}/{NewImageName:Tag}
docker tag centos:6 myrepo/mycentos:v1

#Show the history of a docker image
docker image history centos:6

#Backup a Docker Image to share with others
docker image save {imagename:tag} > {filename}.tar
docker image save myrepo/mycentos:v2 > mycentos.customer.tar

#Import a image to a docker engine from tar file - Docker Import
docker import {filename}.tar {imagename:tag}
docker import mycentos.customer.tar centos:6

#Import a image to a docker engine from tar file - Docker Load (Gives file original tag name)
docker load --input {filename}.tar
docker load --input mycentos.customer.tar

#Remvoe all images without a container attached
docker image prune -a

#Inspecting Images
docker image inspect {imagename:tag}

#Inspecting Images - Redirect to output file
docker image inspect {imagename:tag} > filename.output

#Inspecting Images - Format JSON
docker image inspect {imagename:tag} --format '{{.ContainerConfig.Hostname}}' 
docker image inspect centos:6 --format '{{.ContainerConfig.Hostname}}' 
docker image inspect centos:6 --format '{{json .ContainerConfig}}'

#Build a docker image (In folder with dockerfile)
docker build -t {imagename:tag} {context}
docker build -t centosyum:v1 .

#Build a docker Image, get lasest images and dont use cache, then squash to one layer
docker build --pull --no-cache --squash -t optimised:v1 --file Dockerfile .

#Review the Image Build layers & history
docker image history {imagename:tag}

#Review the Image Build layers & history - with full commands desplayed
docker image history {imagename:tag} --no-trunc

#Squash a docker images - Consolidate to save space
docekr image history {imagename:tag}
docker container run {imagename:tag}
docker export {containername} {filename}.tar
docker import {filename}.tar {imagename:tag}

#Push Image to secure registry
docker image pull  busybox
docker tag busybox myregistrydomain.com:5000/busybox
docker login myregistrydomain.com:5000/busybox
docker push myregistrydomain.com:5000/busybox

#Convert Docker container to an image
docker commit {containername} {imagename:tag}

#Whats in your docker secure Registry with curl (--insecure ignore self signed certificate issue)
curl --insecure -u "admin:B52:bomb" https://myregistrydomain.com:5000/v2/_catalog

#Show tages for image in Secure Registry
curl --insecure -u "admin:B52:bomb" https://myregistrydomain.com:5000/v2/busybox/tags/list

#Show manifest for image in Secure Registry
curl --insecure -u "admin:B52:bomb" https://myregistrydomain.com:5000/v2/busybox/manifests/latest

#Whats in your docker secure Registry with wget (--no-check-certificate ignore self signed certificate issue)
wget --no-check-certificate --http-user=admin --http-password=B52:bomb https://myregistrydomain.com:5000/v2/_catalog
