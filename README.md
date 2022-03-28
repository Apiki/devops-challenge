# Desafio DevOps Apiki - Jonathan Barbosa Farias.

O Objetivo é criar um processo automatizado para construção de um servidor web para [WordPress](https://wordpress.org/) em sua última versão.

### Ferramentas Utilizadas

  - [Docker Compose](https://docs.docker.com/compose/).
  - [Terraform](https://www.terraform.io/).
  - [RDS AWS](https://aws.amazon.com/pt/rds/).
  - [EC2 AWS](https://aws.amazon.com/pt/ec2/).
  - [Nginx](https://nginx.org/en/)

Informações;

  - A chave de acesso foi enviada pelo email, junto com as instruções de acesso ao ec2;
  - A instância ec2 foi configurada para ter as portas 80, 443 e 22 abertas;
  - No GitHub se fará presente um arquivo docker-compose.yml, mas ele só servirá para testes, o docker-compose utilizado está dentro da pasta templates;
  - Todas as variáveis de ambiente estaram no Terraform, no arquivo variables (que será enviado por email);
  - O terraform irá configurar a instância e o RDS, além de instalar o docker, docker-compose e também inicia-los;
  
Execução;

  - Insira o arquivo variables enviado por email na pasta terraform;
  - Insira as variáveis access_key e secret_key da conta da AWS da APIKI no arquivo variables para a execução do Terraform;
  - Rode os comandos do terraform;
    - terraform init
    - terraform apply -auto-approve
  - Ao final da execução será informado o dns e ip da instância;
  - O arquivo .pem é gerado na execução do Terraform
  - Dependendo da instância é necessário esperar um pouco para a conclusão da execução dos comandos;
  - Os comandos executados na instância podem ser visualizados no arquivo templates/userdata.tpl.
