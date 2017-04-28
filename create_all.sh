#!/bin/bash

echo 'Deleting previous docker containers'
docker rm -f database wru_1 wru_2 wru_nginx_1
docker rmi server_1 wru_nginx

echo 'Copying schema to /tmp'
cp database/WRUSchema.sql /tmp


echo 'Starting database'
docker run --name database -d -p 3306:3306 -v /tmp:/tmp -e MYSQL_PASS=comsc -e MYSQL_USER=root -e STARTUP_SQL=/tmp/WRUSchema.sql tutum/mysql:5.5

echo 'Bulding servers'
cd server_1
docker build -t server_1 .

cd ..

echo 'Starting server 1'
docker run --name wru_1 -d -p 8080:8080 server_1 /bin/bash -c 'cd /root/docker_WRU/build/libs && java -jar wru-project-0.0.1-SNAPSHOT.jar --spring.profiles.active=production'

echo 'Starting server 1'
docker run --name wru_2 -d -p 8082:8082 server_1 /bin/bash -c 'cd /root/docker_WRU/build/libs && java -jar wru-project-0.0.1-SNAPSHOT.jar --spring.profiles.active=production --server.port=8082'

echo 'Building custom nginx'
cd nginx 
docker build -t wru_nginx .

cd ..

echo 'Starting wru nginx'
docker run --name wru_nginx_1 -d -p 8081:8081 wru_nginx
