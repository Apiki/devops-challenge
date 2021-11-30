# Desafio DevOps Apiki

Processo automatizado para construção de um servidor web para WordPress em sua última versão.

1. [Terraform](https://www.terraform.io/) para provisionar:

  - Instância EC2 na [AWS](https://aws.amazon.com/free/)
  - Grupos de segurança para liberar as portas: 22(SSH), 80(HTTP), 443(HTTPS) e 3306(MYSQL).
  - Shell Script **Linux** para criar o arquivo **init.sh** responsável pela instalação do [Docker](https://www.docker.com/).


2. [Ansible](https://www.ansible.com/) para instalar as dependências:
  
  - Copia o arquivo docker-compose.yml.
  - Executa os containers.




## Terraform

O arquivo **main.tf** e seus auxiliares **vars.tf** (variáveis) e **sgroup.tf** (grupo de segurança da AWS) são responsáveis por criar a instância EC2, com as configurações de acesso necessárias para o projeto.

Além disso, um scrip **init.sh** é executado durante a inicialização da intância e o responsável por criar uma memória de swap no linux, fazer o update os pacotes e instalar o Docker, Docker-compose e o NGINX.

Comando:

```bash
terraform apply
```


## Ansible

O arquivo **wpapiki.yml** contém as instruções para copiar e executar o arquivo **docker-compose.yml**

Comando:

```bash
ansible-playbook -i ansible/hosts ansible/wpapiki.yml -u ubuntu --private-key apiki-devops-challenge.pem
```