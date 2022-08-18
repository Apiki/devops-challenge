# Resolução desafio Apiki

## Funcionamento

A aplicação se resume em 3 containers:

1. App - Contém o web server Apache, Php8.1 e o Wordpress instalado.
2. Nginx - Nginx com configuração para proxy reverso do web server.
3. Mysql - banco de dados independente com a função de servir o Wordpress.

## Entrega

Está tudo pronto, sempre quando ouver um Push no repositório irá desencadear um estágio via Github-actions que tem como função instalar as dependêcias e realizar o deploy em uma instância EC2 na AWS.
**_NOTE:_**  As credenciais para acesso da instância precisam ser registradas via github secrets, as mesmas foram enviadas via email.


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
