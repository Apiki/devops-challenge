#!/bin/bash

###################################################################
# Script Name   : Script DevOps Challenge Apiki                                                                                             
# Description	: Script Wordpress Docker Compose                                                                               
# Version       : 1.0                                                                                           
# Author       	: Vinicius Gonçalves                                                
# E-mail        : vinicius.eng97@gmail.com                                           
###################################################################

sudo apt-get update -y && sudo apt-get update -y &&

sudo apt-get install ca-certificates curl gnupg lsb-release -y &&

sudo mkdir -p /etc/apt/keyrings &&
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg &&

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null &&

sudo apt-get update -y && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y &&

sudo wget https://github.com/viniciussgoncalves/devops-challenge/raw/vinicius-goncalves/docker-compose.yaml &&
sudo wget https://github.com/viniciussgoncalves/devops-challenge/raw/vinicius-goncalves/nginx.conf

sudo docker compose up -d