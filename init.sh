#!/bin/bash

#Força execução com root
[ `whoami` = root ] || { sudo "$0" "$@"; exit $?; }

echo "Atualizando os pacotes"
sudo apt update -y &> /dev/null
echo "Instalando o ansible"
sudo apt install ansible -y &> /dev/null

echo "Rodando ansible"

ansible-playbook docker_install.yml -i hosts -e ansible_ssh_private_key_file=./lucas_apiki.pem