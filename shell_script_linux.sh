#!/bin/bash

###################################################################
# Script Name   : Script DevOps Challenge Apiki                                                                                             
# Description	  : Script Wordpress Docker Compose                                                                               
# Version       : 1.0                                                                                           
# Author       	: Vinicius Gonçalves                                                
# E-mail        : vinicius.eng97@gmail.com                                           
###################################################################

# CRIANDO SENHA USUÁRIO ROOT
sudo sh -c 'echo root:apiki | chpasswd'

# ATUALIZAÇOES
sudo apt-get update -y && sudo apt-get update -y &&

# INSTALANDO DOCKER ENGINE
sudo apt-get install ca-certificates curl gnupg lsb-release -y &&
sudo mkdir -p /etc/apt/keyrings &&
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg &&
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null &&
sudo apt-get update -y && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y &&

# BAIXANDO COMPOSE E .CONF DO NGINX PROXY
sudo wget https://github.com/viniciussgoncalves/devops-challenge/raw/vinicius-goncalves/docker-compose.yaml &&
sudo wget https://github.com/viniciussgoncalves/devops-challenge/raw/vinicius-goncalves/nginx.conf &&

# CRIANDO E POPULANDO .ENV (em produção .env ficaria em um repositório privado e não seria populado pelo script)
echo '# wordpress
WORDPRESS_DB_HOST: db
WORDPRESS_DB_USER: apiki-user
WORDPRESS_DB_PASSWORD: apiki-pass
WORDPRESS_DB_NAME: db-wordpress-apiki

#db
MYSQL_DATABASE: db-wordpress-apiki
MYSQL_USER: apiki-user
MYSQL_PASSWORD: apiki-pass' > .env &&

# SUBINDO SERVIÇOS
sudo docker compose up -d &&

# FIM
echo "Instalação Finalizada!"