#!/bin/bash
sudo apt update && sudo apt upgrade -y

sudo apt-get install ca-certificates curl gnupg lsb-release -y

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo usermod -a -G docker $USER
sudo usermod -a -G docker ubuntu

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


# setup wordpress app components
mkdir -p /var/www/wp
mkdir -p /var/www/wp/nginx
cd /var/www/wp

echo "${dockercompose}" > docker-compose.yml
echo "${nginx_conf}" > nginx/default.conf


docker-compose up -d