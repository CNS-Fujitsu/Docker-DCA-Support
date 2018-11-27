#Apache Website
ARG TAGVERSION=6
FROM centos:${TAGVERSION}

LABEL CreatedBy="Steve Owens"
LABEL Maintainer="Fujitsu"
LABEL Version="1.0.0.1"

RUN yum update -y && \
    yum install -y httpd net-tools && \
    mkdir -p /run/httpd && \
    rm -rf /run/http/* /tmp/httpd*

COPY sourcecode /var/www/html/
CMD ls -al / | wc -l
ENV ENVIRONMENT="production"
VOLUME /mymount  

EXPOSE 80

ENTRYPOINT apachectl "-DFOREGROUND"