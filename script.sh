#!/bin/bash

echo "Atualização da vm"
apt-get update -y
apt-get upgrade -y
echo "Instalando Docker"
sudo apt-get install docker.io
echo "update"
sudo apt update -y
udo usermod -aG docker ubuntu
sudo curl -L https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "subindo docker compose up"
docker-compose up -d
docker-compose ps
cp default.conf nginx/conf/
docker-compose restart nginx