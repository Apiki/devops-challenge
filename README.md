# Desafio DevOps Apiki.

Objetivo é criar um processo automatizado para construção de um servidor web para [WordPress](https://wordpress.org/) em sua última versão.

\* Bonus: Utilização do AWS S3 para armazenamento mais econômico de medias do WordPress.

## Arquitetura

  - Banco de dados [AWS RDS](https://aws.amazon.com/pt/rds/) rodando [MySQL](https://www.mysql.com/).
  - Imagem Docker [Nginx](https://www.nginx.com/) configurado como proxy para image WordPress Apache.
  - Imagem Docker [WordPress](https://wordpress.org) rodando [Apache](https://www.apache.org/) e [PHP](https://php.net/).
  - Bucket [AWS S3](https://aws.amazon.com/pt/s3/) e [AWS IAM](https://aws.amazon.com/pt/iam/) para medias do WordPress.
  - Domínio, DNS, CDN e SSL com [Cloudflare](https://www.cloudflare.com/pt-br/).
  
## Requerimentos

  - [AWS EC2](https://aws.amazon.com/pt/ec2/).
  - [AWS RDS](https://aws.amazon.com/pt/rds/). 
  - [AWS S3](https://aws.amazon.com/pt/s3/).
  - [Docker](https://www.docker.com/).
  - [Docker Compose](https://docs.docker.com/compose/).
  - [Media Cloud](https://br.wordpress.org/plugins/ilab-media-tools/).

## Instalação

  - Provisionamento de banco de dados MySQL no AWS RDS.
  - Provisionamento de bucket AWS S3.
  - Configuração de usuários e políticas AWS IAM para o AWS S3.
  - Provisionamento de instancia EC2.
  - Configuração das portas 22, 80 e 443 no grupo de segurança.
  - Configuração de domínio, DNS, CDN e SSL. 
  - Instalação do Docker e Docker composer.
  - Download do `docker-compose.yml`, `.env` e certificado `SSL`.
  - Configuração do banco de dados no arquivo `.env`.
  - Provisionamento de containers Docker `docker composer up -d`
  - Complete a instalação do WordPress e do plugin Media cloud.

\* Observação: os arquivos `.env` e o certificado `SSL` serão enviados por e-mail.

## Utilização

Acesse a URL: https://apiki.vitor.guia.nom.br/wp-login.php
Preencha o usuário e a senha que serão fornecidos por e-mail.

Acesso o servidor com a chave que será fornecida pelo e-mail.

```sh
$ ssh -i apiki-key.pem admin@3.93.148.249
```

## Testes para entrega

![Portas abertas](https://apiki-bucket.s3.amazonaws.com/2022/07/portas.png)

![Containers Docker](https://apiki-bucket.s3.amazonaws.com/2022/07/containers.png)

![Resposta SSH](https://apiki-bucket.s3.amazonaws.com/2022/07/ssh.png)

![Resposta HTTP](https://apiki-bucket.s3.amazonaws.com/2022/07/http.png)
