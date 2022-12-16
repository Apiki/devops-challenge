# Solução do Desafio DevOps Apiki.

 **Solução**:

## Criar VPC:
    - VPC Only
    - Name tag: vpc-wp
    - CIDR: 10.0.0.0/16 [ No Overlap com On-p ]

## Criar Subnet Publica e Privada:
    - Name: Public Subnet
    - AZ: us-east-1a
    - CIDR: 10.0.0.0/24

    - Name: Private Subnet 1
    - AZ: us-east-1a
    - CIDR: 10.0.1.0/24

    - Name: Private Subnet 2
    - AZ: us-east-1b
    - CIDR: 10.0.2.0/24

## Criar EC2 com Terraform no AWS Cloud Shell:
  
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo 
    https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
    sudo yum -y install terraform

## Download dos arquivos do Terraform no AWS Cloud Shell
    
    mkdir terraform
    cd terraform
    copie os arquivos main.tf e provider.tf do repo para dentro da pasta terraform/ 
    
## Editar variáveis do arquivo 'main.tf'
    VPC-id:  xxxxxxxxxxxx (id da VPC que você criou)
    SSH Key: xxxxxxxxxxxx (crie ou informe chave ssh existente)
    
## Executando o Terraform

    terraform init
    terraform plan
    terraform apply

    ls | novo arquivo foi criado: 'terraform.tfstate'

## Criar BD RDS:

    RDS | Create database
    Standard create
    MySql | Version: MySql x.x.x(última versão)
    Template: Free Tier

    DB instance identifier: dbwp
    Credentials Settings: admin | admin123456
    DB instance class: db.t2.micro

    Connectivity
    VPC: vpc-wp
    VPC security group: (criado pelo Terraform)
    AZ: us-east-1a
    Database port: 3306

## Logando na EC2 via ssh
    abrir Terminal ou Gitbash
    edite execute o comando (ssh -i "key.pem" ubuntu@ipExterno)
    
## Instalar Ngix, Apache, e Wordpress via script
    #!/bin/bash
    cd /tmp
    sudo wget https://raw.githubusercontent.com/mrodrigochaves/description-ssh/main/install.sh
    sudo chmod +x install.sh
    sudo ./install.sh

## Alterar Parâmetros para configuração:
    sudo cp wp-config-sample.php wp-config.php
    
    Database Name: Initial database name configurado. (Ex.: wordpress)
    Username: usuário do banco. (Ex.: admin)
    Password: senha do usuário do banco.
    Database Host: endpoint do banco.

## Instalar o MySQL Client
    sudo apt install mysql-client
    mysql -V
    mysql -u USERNAME -p PASSWORD -h HOST-OR-SERVER-IP
    
## Acessar Wordpress no navegador
    na console da AWS copie o ip público da EC2
    cole no browser
    termine a configuração do Wordpress