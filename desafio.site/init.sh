#!/bin/bash
export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin
####################################################################
## SCRIPT DE INSTALAÇÃO DO DESAFIO DEVOPS APIKI
## AUTOR:    T. FONTOURA
## OBJETIVO: CONFIGURAR SERVIDOR LINUX UBUNTU COM DOCKER, 
##           CRIANDO CONTAINERS PARA WORDPRESS E APACHE, 
##           E NGINX COMO PROXY REVERSO.
####################################################################
# Verifica se eh root
if [[ $EUID -ne 0 ]]; then
   echo "ATENCAO: Este script deve ser rodado como root. Use sudo." 
   exit 1
fi


#Atualiza nova instancia - comentei o upgrade para ser mais rápida a instalação para a avaliação. Em produção, deve ser atualizada.
sudo apt update
#sudo apt -y upgrade

# Para e desabilita Apache para nao ocupar a porta 80, se estiver instalado.
sudo systemctl disable apache2 && sudo systemctl stop apache2

# Cria log
#exec 3>&1 4>&2
#trap 'exec 2>&4 1>&3' 0 1 2 3
#exec 1>instala.log 2>&1


##################################################
# CRIAR AS VARIAVEIS #
######################
# Se quisermos, podemos pedir input do usuario para senhas e users aqui. Para este desafio, eu hardcoded as senhas e outras informacoes no yml.

# Conteudo do arquivo nginx.conf
__nginxconf="
user www-data;
worker_processes auto;
pid /run/nginx.pid;

events {
  worker_connections 10;
}

http {
 
	 fastcgi_read_timeout 240;
     fastcgi_send_timeout 240;
     fastcgi_buffers 16 16k;
     fastcgi_buffer_size 32k;


	##
	# Basic Settings
	##

	sendfile on;
	tcp_nopush on;
	tcp_nodelay on;

client_max_body_size 30M;
client_body_timeout   60;
client_header_timeout 60;
send_timeout          60;

	keepalive_timeout 65;
	types_hash_max_size 2048;

	include /etc/nginx/mime.types;
	default_type application/octet-stream;

	##
	# SSL Settings
	##

	ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
	ssl_prefer_server_ciphers on;

    gzip on;
    gzip_comp_level 5;
    gzip_min_length 256;
    gzip_types
        application/atom+xml
        application/javascript
        application/json
        application/rss+xml
        application/vnd.ms-fontobject
        application/x-font-ttf
        application/x-web-app-manifest+json
        application/xhtml+xml
        application/xml
        font/opentype
        image/svg+xml
        image/x-icon
        text/css
        text/plain
        text/x-component;    
    gzip_disable msie6;


# Default server configuration
#
server {
        listen 80 default_server;
        listen [::]:80 default_server;

    client_max_body_size 100M;

 

    location / {



        proxy_pass http://wordpressFontoura;
        #set  http://wordpressFontoura;
        #proxy_pass ;
            proxy_redirect     off;
            proxy_set_header   Host \$host;
            proxy_set_header   X-Real-IP \$remote_addr;
            proxy_set_header   X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Host \$server_name;
    }
}

}

"

#echo "$__nginxconf"

# Conteudo do arquivo docker-compose.yml
__dockercompose="
version: '3'

services:
  webserver:
    image: nginx:latest
    depends_on:
      - wordpressFontoura
    volumes:
      - /home/ubuntu/efs/conf/nginx.conf:/etc/nginx/nginx.conf:ro
#    networks:
 #     - net
    ports:
      - 80:80
    deploy:
      replicas: 1
      update_config:
        parallelism: 1
        #delay: 10s
      resources:
        limits:
            cpus: '0.25'
            memory: 75M
      restart_policy: 
        condition: always

  wordpressFontoura:
    image: wordpress:latest
    depends_on:
      - db
    restart: always
    environment:
     WORDPRESS_DB_HOST: db
     WORDPRESS_DB_USER: fonfontoura
     WORDPRESS_DB_PASSWORD: Asa345fGt
     WORDPRESS_DB_NAME: fontoura_wordpress
    volumes:
      - /home/ubuntu/efs/www:/var/www/html
 #   networks:
 #     - net
    deploy:
      replicas: 1
      update_config:
        parallelism: 1
        #delay: 10s
      resources:
        limits:
            cpus: '0.5'
            memory: 200M 

  db:
    image: mysql:5.7
    restart: always
    command: --default-authentication-plugin=mysql_native_password
    environment:
      MYSQL_ROOT_PASSWORD: '23Tf;yx'
      MYSQL_DATABASE: fontoura_wordpress
      MYSQL_USER: fonfontoura
      MYSQL_PASSWORD: Asa345fGt
      #MYSQL_RANDOM_ROOT_PASSWORD: '1'
    volumes:
      - volumemysqldb:/var/lib/mysql
 #   networks:
 #     - net
    deploy:
      replicas: 1
      update_config:
        parallelism: 1
      resources:
        limits:
            cpus: '0.5'
            memory: 400M

#networks:
#  net:
  #  external: true
volumes:
  volumemysqldb:
    #drive: local

"

#echo "$__dockercompose"

#### FIM DE CRIAR AS VARIAVEIS ###################

# Abaixo, instalacao colocada dentro de uma funcao para prevenir problemas caso o curl pare no meio do download.
instala(){
    echo
	echo ">>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<"
	echo ">> Iniciando a instalação. Aguarde. <<"
	echo ">>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<"
    echo
	
    # INSTALAR DOCKER
	# Usando um script pronto para instalar docker, assim ganhamos tempo e podemos usar este script para outras distros no futuro.
	curl -fsSL https://get.docker.com | sudo bash

	# INSTALAR DOCKER-COMPOSE 
	# Se quisermos uma versao especifica, usamos a linha abaixo. Isso é interessante caso tenhamos duvida sobre a compatibilidade de novas versoes com nosso arquivo de configuracao.  Para este desafio, que é um teste, vou utilizar s outra linha que baixa a última versão disponivel do docker-compose.
	# sudo curl -L "https://github.com/docker/compose/releases/download/v2.3.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	 sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	 
	# Tornar o arquivo executavel
	 sudo chmod +x /usr/local/bin/docker-compose
	 
	# Aqui vou criar os caminhos. Para este teste, vou colocar tudo na home do ubuntu, assim fica mais facil ser avaliado. Ideal seria usar EFS, mas não daria para vocês replicarem no servidor local da Apiki. Por isso, façamos de conta que o diretório efs foi montado a partir de EFS. Se usássemos EFS, poderiamos manter nele o que quiséssemos usar, como arquivos de configuracao ou versoes de software que queremos usar. Porém, como não configurei um endpoint efs, vou criar "on the fly" os arquivos e diretorios que vou precisar nos seguintes caminhos:
	 
	# ~/efs/
    #     |_docker/
	#	  |_conf/
	#	  |_www/
	

	mkdir /home/ubuntu/efs
	mkdir /home/ubuntu/efs/conf
	mkdir /home/ubuntu/efs/www
	mkdir /home/ubuntu/efs/docker

	# Mudar o owner para www-data, senao teremos problemas de permissoes.
	sudo chown 33:33 /home/ubuntu/efs/www
	
	# Cria arquivos
	echo "$__nginxconf"     > /home/ubuntu/efs/conf/nginx.conf
	echo "$__dockercompose" > /home/ubuntu/efs/docker/docker-compose.yml

    echo "Instalando..."
	echo

       # Roda docker-compose
       sudo docker-compose -f /home/ubuntu/efs/docker/docker-compose.yml up -d 

    echo
    echo "Instalação concluida"
    echo
    echo "Verificando instalacao..."
	echo
	sleep 5
    echo "Aguarde..."
	echo
	sleep 10

	
    # Pegar o IP e finalizar
       meuIP=$(curl -sS http://checkip.amazonaws.com)

       #Verificar se está funcionando o webserver
       out=$(curl -k -I -L -s  "$meuIP" | grep -E -i 'http/[[:digit:]]*')
 
       if [ "$out" != "" ]
       then
              if [[ $out =~ .*200.* ]] 
	       then
		       echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
			   echo ">>         >>           S U C E S S O !          <<             <<"
			   echo ">>     Agora voce pode acessar este servidor pelo endereço      <<"
               echo ">>                  http://"$meuIP"                        <<" 
			   echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
			   echo
			   #Avaliador: neste ponto eu poderia fazer uma lambda para acessar a API do Cloudflare e adicionar um registro A no DNS do domínio desafio.site para acessar este server pelo nome ao invés do IP. Algo como http://server-do-desafio.desafio.site
			   echo
			   echo "E assim concluímos o desafio ;)"
			   echo "                  - T. Fontoura"
			   echo
	       else
		       echo "ALGO DEU ERRADO, SERVIDOR NAO ESTA FUNCIONANDO!"
		       echo "Headers para $meuIP:"
		       echo "$out"
	       fi
       fi

echo
echo "Lembrando: O IP externo do server é "$meuIP

}

# Como falei, estamos rodando a instalacao dentro de uma funcao para prevenir problemas caso o curl pare no meio do download. Aqui estamos no EOF.
instala
