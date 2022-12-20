#!/bin/bash


if [ -z "$1"  ] 
then
	echo "É necessário informar um nome, sem acentos e sem espaços ou caracteres especiais. Pode ter números ou _. Tente outra vez, por favor!"
else 

#Criar pasta com os arquivos de configuração
banco=`TZ='America/Sao_Paulo' date +"%Y%m%d%H%M%S"`_$1

#criar o arquivo de configuração do web


#Criar a docker com o web expondo a porta 80 e mapeando a pasta etc fora da docker na pasta atual
docker run -id --name $1 --hostname $1  -v `pwd`/web:/opt/web --env TERM=linux --env DEBIAN_FRONTEND="noninteractive" ubuntu:latest
ipwp=`docker inspect $1 | grep IPAddress | grep -v null -m 1 | cut -d: -f2 | cut -d, -f1 | sed 's/"//g' | sed 's/ //g'`
docker exec $1 apt-get update
docker exec $1 apt-get install apt-utils -y
docker exec $1 apt-get install libterm-ui-perl -y
docker exec $1 echo 'tzdata tzdata/Areas select America' | docker exec $1 debconf-set-selections
docker exec $1 echo 'tzdata tzdata/Zones/America select Sao_Paulo' | docker exec $1 debconf-set-selections
docker exec $1 apt install tzdata -y
docker exec $1 apt-get install apache2 -y
docker exec $1 apt-get install curl php-fpm php-mysql php-curl mysql-client vim -y
docker exec $1 /etc/init.d/php8.1-fpm start
#iniciar o apache2
docker exec $1 /etc/init.d/apache2 start
docker exec $1  a2enmod proxy_fcgi setenvif
docker exec $1 a2enconf php8.1-fpm
docker exec $1 /etc/init.d/apache2 restart
#Instalar o wordpress
echo "curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
cd /var/www/html
wp core download --path=/var/www/html --locale=pt_BR --allow-root
wp config create --dbname=$banco --dbuser=hqmoraes --dbpass=ApikiMeContrata --dbhost=db-apiki.cwaw1inzljwb.us-east-1.rds.amazonaws.com --allow-root
wp db create --allow-root
wp core install --url=$ipwp --title=\"Apiki me contrata\" --admin_user=hqmoraes --admin_password=ApikiMeContrata --admin_email=hq@hospedar.net --allow-root " > web/wp.sh
docker exec $1 chmod u+x /opt/web/wp.sh
docker exec $1 /bin/bash /opt/web/wp.sh



echo "
server {
    listen       80;
    listen  [::]:80;
    server_name  $1;

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    location /$1 {
        proxy_pass http://$ipwp/;
    }
}
" > proxy/sites/$1.conf

docker exec proxy /etc/init.d/nginx restart

fi
