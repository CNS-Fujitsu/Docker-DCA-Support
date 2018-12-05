# Crearte the user UCP client package from the gui

# on the systems you need to configure download the UCP client Package

mkdir /ucp
cd /ucp 
unzip /ucp-bundle-{username}.zip
eval  $(<env.sh)
env | grep DOCKER
docker image ls

#now grant a role to the user to run the commands on the remote node
