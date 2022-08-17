#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install ca-certificates curl gnupg lsb-release -y

# Install docker

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo groupadd docker
sudo usermod -aG docker $USER

# Install Docker-compose

curl -SL https://github.com/docker/compose/releases/download/v2.7.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x usr/local/bin/docker-compose

# Configuration wordpress

mkdir wordpress
cd ~/wordpress/

docker-compose up -d
docker container ls


 
