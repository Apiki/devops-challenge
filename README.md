# Desafio DevOps Apiki - Claudiomar Estevam

Objetivo é criar um processo automatizado para construção de um servidor web para [WordPress](https://wordpress.org/) em sua última versão.

O candidato deve seguir os seguintes **Requisitos**;

  - O projeto dever ser configurado na [AWS](https://aws.amazon.com/free/), crie uma conta Free.
  - A máquina configurada deverar ter às portas 80, 443 e 22 abertas.
  - Uso de Shell Script **Linux**.
  - [Docker](https://www.docker.com/) 

### Arquitertura!

  - [Nginx](https://www.nginx.com/) configurado como proxy para o Apache.
  - [Apache](https://www.apache.org/) servidor para o WordPress.
  - [PHP](https://php.net/) a última versão.
  - [MySql](https://www.mysql.com/) Versão mínima requirida 5.7.
  - [WordPress](https://wordpress.org) última versão configurada no servidor Apache.
  
  **Modelo conceitual**

[![N|Solid](https://apiki.com/wp-content/uploads/2019/05/Screenshot_20190515_174205.png)](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)

---

### Se liga!

Você também pode usar como **Diferencial**:
  
  - [Docker Compose](https://docs.docker.com/compose/).
  - [Kubernetes](https://kubernetes.io/).
  - [Ansible](https://www.ansible.com/).
  - [RDS AWS](https://aws.amazon.com/pt/rds/).
  - Outras tecnologias para somar no projeto.  

---

### Entrega

1. Efetue o fork deste repositório e crie um branch com o seu nome e sobrenome. (exemplo: fulano-dasilva)
2. Após finalizar o desafio, crie um Pull Request.
3. Aguarde algum contribuidor realizar o code review.
4. Deverá conter a documentação para instalação e configuração README.md.
5. Enviar para o email wphost@apiki.com os dados de acesso SSH com permissão root, da máquina configurada na AWS.

---

### Validação

* Será executado os precessos de instalação e configuração de acordo com a orientação da documentação em um servidor interno da Apiki.
* Será avaliado o processo de automação para criação do ambiente em cloud, tempo de execução e a configuração no server na AWS com os dados fornecidos pelo candidato.
* Deverar constar pelo menos 2 containers.
