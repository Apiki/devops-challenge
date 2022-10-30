# Desafio DevOps Apiki.

Objetivo é criar um processo automatizado para construção de um servidor web para [WordPress](https://wordpress.org/) em sua última versão.

Para a implementação o colaborador deve seguir os seguintes **Passos**;

### Criando instância!

- Criar uma instância EC2 na AWS com as seguintes características:
  - Selecionar a imagem **Ubuntu Server**.
  - Em configurações de rede, habilitar **SSH, HTTP e HTTPS**.
- Após a instância ser criada, acesse a mesma via SSH.

### Executando Script de instalação!

- Após estar conectado, execute o seguinte script para instalação:
  - $sudo wget https://github.com/viniciussgoncalves/devops-challenge/raw/vinicius-goncalves/shell_script_linux.sh && sudo bash shell_script_linux.sh
- Aguardar até que a mensagem **"Instalação Finalizada!"** apareça.

**Obs:** Dependendo do ambiente, será solicitado a senha de permissão para execução do script.

### Acessando o WordPress!

- Para acessar e configurar o WordPress:
  - Abra o navegador de sua preferência e acesse a URL:
  - http://ip-servidor/wp-admin/

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

- Será executado os precessos de instalação e configuração de acordo com a orientação da documentação em um servidor interno da Apiki.
- Será avaliado o processo de automação para criação do ambiente em cloud, tempo de execução e a configuração no server na AWS com os dados fornecidos pelo candidato.
- Deverar constar pelo menos 2 containers.
