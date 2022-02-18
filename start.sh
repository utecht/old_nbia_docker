#!/bin/bash

docker compose up mysql -d
docker compose up solr -d
docker compose up openldap -d
echo "Sleeping for 30 seconds to wait for database/solr to initialize"
sleep 30
docker compose up tomcat
