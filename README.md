Instalação do Ambiente usado para o Teste
==========================================

Para esse exercicio foi usado CentOS Linux 8

### Disabilitar SELinux

Mude selinux para "disabled"
    vim /etc/selinux/config

Salve o arquivo e reinicie o servidor
```sh
$ sudo shutdown -r now
```
### Script

Após a reinicialização, rode o script "script.sh".
Esse scrip instala:

- Docker
- Docker Compose
- Vim
- Git

Após o final do script, clone o repositório.

Entre no repositório e digite o comando:

```sh
$ docker-compose up -d
Creating network "devops-challenge_default" with the default driver
Creating db           ... done
Creating reverseproxy ... done
Creating wordpress    ... done
Creating apache       ... done
```

Esse comando cria:
- Proxy Reverso com Nginx
- Banco de dados mysql:5.7
- Apache + PHP 7.2 + Wordpress
- Apache

Apache + PHP 7.2 + Wordpress Acessivel pela porta padrão (80)
Apache de Exemplo acessivel pela porta 8080.
