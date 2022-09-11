**Projeto Wordpress**

Este projeto tem como objetivo disponibilizar um site wordpress na AWS de forma automatizada utilizando as seguintes tecnologias:

* Terraform
  * Provisiona a VPC;
  * Cria uma máquina EC2 na AWS.
* Ansible
  * Faz a atualização dos pacotes;
  * Instala o Docker, Docker-Compose e o nginx;
  * Clona o repositório https://github.com/nunes-raphael/wordpress.git;
  * Executa o docker-compose para a criação dos containers wordpress + mysql; 
  * Configura o nginx como proxy reverso.
* ShellScript
  * Através do shell script é criada uma pipeline para construção do albiente 100% automatizada. 
    
INSTRUÇOES DE USO:

Pré-requisito:
Na máquina que será executada o script 'run.sh' é necessário instalar o terraform e o ansible:

Terraform - Procedimento de Instalação
* https://learn.hashicorp.com/tutorials/terraform/install-cli

Ansible - Procedimento de Instalação
* https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

CONFIGURANDO O AMBIENTE:

* Clonar o repositório: 
  - https://github.com/nunes-raphael/infraestrutura-devops.git;
* Criando a infraestrutura na AWS
  - ./run.sh
* Excluindo a infraestrutura na AWS
  - ./run.sh --destroy
* Acessando o servidor na AWS
  - cd ./aws_ec2
  - ssh-add wordpress-ec2.pem
