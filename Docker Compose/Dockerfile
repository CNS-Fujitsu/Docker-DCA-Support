# Simple Web Server
FROM Centos:latest 
LABEL maintainer="steve.owens@uk.fujitsu.com"

RUN yum install -y httpd
RUN echo "Our Container Website" >> /var/www/html/index.html

EXPOSE 80

ENTRYPOINT apachectl -DFOREGROUND