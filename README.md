# Resolução desafio Apiki

## Funcionamento

A aplicação se resume em 3 containers:

1. App - Contém o web server Apache, Php8.1 e o Wordpress instalado.
2. Nginx - Nginx com configuração para proxy reverso do web server.
3. Mysql - banco de dados independente com a função de servir o Wordpress.

## Entrega

Está tudo pronto, sempre quando ouver um Push no repositório irá desencadear um estágio via Github-actions que tem como função instalar as dependêcias e realizar o deploy em uma instância EC2 na AWS.


> **_NOTE:_**  As credenciais para acesso da instância precisam ser registradas via github secrets, as mesmas foram enviadas via email.
