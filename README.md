Olá. Desde já eu agradeço a oportunidade de participar deste desafio e apresentar algumas das ferramentas que coloco à disposição da Apiki como profissional.

Sobre a entrega abaixo, gostaria de fazer algumas observações.

O executável oficial é o "criawp-single-docker.sh"
Ele exige um parâmetro para iniciar o processo de execução, que define o nome do banco de dados, e da docker.
Não existe nenhuma docker rodando no momento da entrega, portanto a execução do script pode ser feita sem riscos de problemas.

Os dados que podem ser alterados para a utilização deste script em outro ambiente estão no topo do arquivo.

É necessário executar o script como sudo.

Fiz alguns comentários entre o texto inicial deste arquivo.

Há ainda uma outra pasta, com uma versão da solução proposta para o teste que separa a execução nginx e do apache, permitindo que a mesma instância do nginx atue como proxy para várias instâncias do apache.

Fico à disposição para qualquer dúvida ou ainda se possível, eventuais correções, caso necessário.

att,

Henrique Moraes



# Desafio DevOps Apiki.

Objetivo é criar um processo automatizado para construção de um servidor web para [WordPress](https://wordpress.org/) em sua última versão.

O candidato deve seguir os seguintes **Requisitos**;

  - O projeto dever ser configurado na [AWS](https://aws.amazon.com/free/), crie uma conta Free.
        Instância disponível para acesso ssh em ec2-user@52.201.236.131 com a chave privada enviada por e-mail.

  - A máquina configurada deverar ter às portas 80, 443 e 22 abertas.
        Tanto a instância via security group, como a docker via exposição estão com as portas 80 e 443, a porta 22 está aberta apenas na instância.

  - Uso de Shell Script **Linux**.
  - [Docker](https://www.docker.com/) 
        A arquitetura do projeto foi feita em bash script, criando a docker com base na ubuntu:latest.
        O banco de dados utilizado é um rds mysql.
        O Wordpress é instalado através do wp-cli, sobre php 8.1 e apache 2.4.
        O nginx está fazendo proxy reverso na porta 80, direcionando o tráfego para a porta 801 onde o apache está ouvindo.
        Há uma pasta do host mapeada para ajudar na configuração de outras instâncias do apache que pdem rodar na mesma docker, em outras portas internas.

### Arquitetura!

  - [Nginx](https://www.nginx.com/) configurado como proxy para o Apache.
        Ouvindo na porta 80 e repassando as chamadas para a porta 801 de 127.0.0.1 na docker

  - [Apache](https://www.apache.org/) servidor para o WordPress.
        Ouvindo na porta 801 e rodando como único virtualhost, lendo e gravando os arquivos em /var/www/html

  - [PHP](https://php.net/) a última versão.
        Versão 8.1 empacotada junto com o ubuntu 22.04

  - [MySql](https://www.mysql.com/) Versão mínima requirida 5.7.
        RDS MySQL - Instância única.

  - [WordPress](https://wordpress.org) última versão configurada no servidor Apache.
        Versão 6.1.1 instalada via wp-cli

  
  **Modelo conceitual**

[![N|Solid](https://apiki.com/wp-content/uploads/2019/05/Screenshot_20190515_174205.png)](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)

---

### Se liga!

Você também pode usar como **Diferencial**:
  
  - [Docker Compose](https://docs.docker.com/compose/).
  - [Kubernetes](https://kubernetes.io/).
  - [Ansible](https://www.ansible.com/).

  - [RDS AWS](https://aws.amazon.com/pt/rds/).
        Utilizada instância única na mesma VPC da EC2 não exigindo o tratamento de rotas.


  - Outras tecnologias para somar no projeto.  

---

### Entrega

1. Efetue o fork deste repositório e crie um branch com o seu nome e sobrenome. (exemplo: fulano-dasilva)
2. Após finalizar o desafio, crie um Pull Request.
3. Aguarde algum contribuidor realizar o code review.
4. Deverá conter a documentação para instalação e configuração README.md.
5. Enviar para o email wphost@apiki.com e **colocar em cópia o email mecontrata@apiki.com** com os dados de acesso SSH com permissão root, da máquina configurada na AWS.

---

### Validação

* Será executado os precessos de instalação e configuração de acordo com a orientação da documentação em um servidor interno da Apiki.
* Será avaliado o processo de automação para criação do ambiente em cloud, tempo de execução e a configuração no server na AWS com os dados fornecidos pelo candidato.
* Deverar constar pelo menos 2 containers.
