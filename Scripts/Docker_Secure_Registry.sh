#Deploy a docker secure registry - CentOS (Secure Mode) - Run as Root
export username="fujitsu"
export certkeyname="dockreg"
export ipaddress="10.10.0.4"
export regusername="admin"
export regpassword="B52:bomb"

#No CP Prompt
unalias cp

#Install OpenSSL
yum install -y openssl

#Create Directories
cd /root
mkdir certs
mkdir auth

#Create Self signed key & certificate
openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/${certkeyname}.key -x509 -days 365 -out certs/${certkeyname}.crt -subj /CN=myregistrydomain.com

#Add local host file for domain name myregistrydomain.com
echo "${ipaddress} myregistrydomain.com" >> /etc/hosts

#Create directory for docker domain registry for certificates
mkdir -p /etc/docker/certs.d/myregistrydomain.com:5000
cd /etc/docker/certs.d/myregistrydomain.com:5000
yes | cp -rf /certs/${certkeyname}.crt ca.crt

#Configure the Docke Registry User authentication
docker pull registry:2
docker run --entrypoint htpasswd registry:2 -Bbn ${regusername} ${regpassword} > /auth/htpasswd

#Deploy the Registry
    docker container run -d -p 5000:5000 -v  /root/certs:/certs -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/${certkeyname}.crt -e REGISTRY_HTTP_TLS_KEY=/certs/${certkeyname}.key -v /root/auth:/auth -e REGISTRY_AUTH=htpasswd -e REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm" -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd registry:2

#Login to Docker Registry
    docker login myregistrydomain.com:5000/centos:v1

