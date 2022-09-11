#!/bin/bash

case "$1" in
    --help)
        echo "./run.sh --destroy -> Apaga toda a infraestrutura na AWS"
    ;;
    --destroy)        
        cd $PWD/aws_ec2
        terraform destroy -auto-approve
        sed -i 's/default = "vpc-[0-9].*/default = VPCID/g' main.tf
        sed -i 's/default = "subnet-[0-9].*/default = SUBNET/g' main.tf
        cd ..
        cd $PWD/aws_vpc
        echo "Apagando Instancia EC2"
        terraform destroy -auto-approve
    ;;
    *)
        echo -e "\n Rodando terraform Init - VPC"
        sleep 1
        cd $PWD/aws_vpc 
        terraform init 
        echo -e "\n ========================= \n"
        echo "Rodando terraform Apply"
        terraform apply -auto-approve
        sleep 1
        export VPC="$(terraform show | grep "vpc_id" | head -1 | awk '{print $3}')"
        export SUBNET="$(terraform show | grep "subnet" | head -1 | awk '{print $3}')"
        export IPADDR="$(terraform show | grep "^ip_address" | awk '{print $3}' | awk -F'"' '{print $2}')"
        sed -i "s/VPCID/$VPC/g" ../aws_ec2/main.tf
        sed -i "s/SUBNET/$SUBNET/g" ../aws_ec2/main.tf

        cd ..
        echo -e "\n Rodando terraform Init - EC2"
        sleep 1
        cd $PWD/aws_ec2
        terraform init
        echo -e "\n ========================= \n"
        echo "Rodando terraform Apply"
        terraform apply -auto-approve
        echo "Servidor Provisionado na EC2 AWS"
        terraform show | grep "public_dns" | awk '{print $3}' > ../ansible_server/hosts
        sleep 1

        cd ..
        echo -e "\n Executando o Ansible"
        sleep 30
        cd $PWD/ansible_server
        ansible-playbook -u ubuntu provisioning.yml -i hosts
        echo -e "\n Fim da Execução"

        echo -e "\n Validando Site..."
        sleep 5
        cd ..
        cd aws_ec2

        export IPADDR="$(terraform show | grep "^ip_address" | awk '{print $3}' | awk -F'"' '{print $2}')"
        export STATUS="$(curl -o /dev/null -s -w "%{http_code}\n" http://$IPADDR)"               
        
        if [ $STATUS -eq 302 ]
        then
        	echo -e "\033[01;32m Status do Site\033[0m: UP"
            echo -e "\033[01;32m URL Configuração WordPress\033[0m: http://$IPADDR:8080/wp-admin/"
            echo -e "\033[01;32m URL de Acesso ao WordPress\033[0m: http://$IPADDR"
        else
        	echo -e "\033[01;31m Site Down \033[0m"
        fi
    ;;
esac