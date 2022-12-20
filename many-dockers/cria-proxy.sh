#!/bin/bash

#Criar pasta com os arquivos de configuração
banco=`TZ='America/Sao_Paulo' date +"%Y%m%d%H%M%S"`_$1

#Criar a docker com o proxy expondo a porta 80 e mapeando a pasta etc fora da docker na pasta atual
docker run -id --name proxy --hostname proxy -p 80:80 -v `pwd`/proxy:/opt/proxy --env TERM=linux --env DEBIAN_FRONTEND="noninteractive" ubuntu:latest
#instalar o apache2 e o proxy
docker exec proxy apt-get update
docker exec proxy apt-get install apt-utils -y
docker exec proxy apt-get install libterm-ui-perl -y
docker exec proxy echo 'tzdata tzdata/Areas select America' | docker exec proxy debconf-set-selections
docker exec proxy echo 'tzdata tzdata/Zones/America select Sao_Paulo' | docker exec proxy debconf-set-selections
docker exec proxy apt install tzdata -y
docker exec proxy apt-get install nginx -y
docker exec proxy rm /etc/nginx/conf.d/default.conf
docker exec proxy ln -s /opt/proxy/default.conf  /etc/nginx/conf.d/default.conf 
docker exec proxy rm -rf /etc/nginx/conf.d
docker exec proxy ln -s /opt/proxy/sites /etc/nginx/conf.d

docker exec proxy /etc/init.d/nginx start

