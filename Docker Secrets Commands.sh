#!/bin/bash

#Create Secret from File
docker secret create {secretname} {filename}

#Create Secret from Command Line
echo "{Password}" | docker secret create {secretname} -

#Display all Secrets
docker secret ls

#Inspect a Secret
Docker secret inspect {secretname}

#Map a secret to a service
Docker service create --name my_sql --secret {secretname}

#Secret Example - Create Postgres Service
echo "username" | docker secret create psql_user
echo "password" | docker secret create psql_pass
Docker service create --name mysql1 --secret mysql_user --secret mysql_pass -e POSTGRES_PASSWORD_FILE=/run/secrets/psql_pass -e POSTGRES_USER_FILE=/run/secrets/psql_user postgres

#Replace Secrets


