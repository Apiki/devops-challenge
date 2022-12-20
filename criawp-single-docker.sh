#!/bin/bash

#Criar pasta com os arquivos de configuração
mkdir nginx
banco=`TZ='America/Sao_Paulo' date +"%Y%m%d%H%M%S"`_$1

#criar o arquivo de configuração do nginx

echo "server {

	listen 80;

	location / {

		proxy_pass         http://127.0.0.1:801;
		proxy_redirect     off;
		proxy_set_header   Host \$host;
		proxy_set_header   X-Real-IP \$remote_addr;
		proxy_set_header   X-Forwarded-For \$proxy_add_x_forwarded_for;
		proxy_set_header   X-Forwarded-Host \$server_name;

	}
}" > nginx/default.conf


#Criar a docker com o nginx expondo a porta 80 e mapeando a pasta etc fora da docker na pasta atual
docker run -id --name nginx -p 80:80 -v `pwd`/nginx:/opt/nginx --env TERM=linux --env DEBIAN_FRONTEND="noninteractive" ubuntu:latest
#instalar o apache2 e o nginx
docker exec nginx apt-get update
docker exec nginx apt-get install apt-utils -y
docker exec nginx apt-get install libterm-ui-perl -y
docker exec nginx echo 'tzdata tzdata/Areas select America' | docker exec nginx debconf-set-selections
docker exec nginx echo 'tzdata tzdata/Zones/America select Sao_Paulo' | docker exec nginx debconf-set-selections
docker exec nginx apt install tzdata -y
docker exec nginx apt-get install apache2 nginx -y
docker exec nginx apt-get install curl php-fpm php-mysql php-curl mysql-client vim -y
docker exec nginx /etc/init.d/php8.1-fpm start
#configurar o apache para executar na porta 801
docker exec nginx sed -i 's/80/801/' /etc/apache2/ports.conf
# recriar o arquivo default.conf do nginx
docker exec nginx mv /opt/nginx/default.conf  /etc/nginx/conf.d/default.conf -f
#iniciar o apache2
docker exec nginx /etc/init.d/apache2 start
docker exec nginx  a2enmod proxy_fcgi setenvif
docker exec nginx a2enconf php8.1-fpm
docker exec nginx /etc/init.d/apache2 restart
#iniciar o nginx


echo "server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        index index.php index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                try_files \$uri \$uri/ =404;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/run/php/php8.1-fpm.sock;
        }

        location ~ /\.ht {
                deny all;
        }
}
" > nginx/default
docker exec nginx mv /opt/nginx/default  /etc/nginx/sites-enabled/default -f
docker exec nginx /etc/init.d/nginx start
#instalar o wordpress
echo "curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
cd /var/www/html
wp core download --path=/var/www/html --locale=pt_BR --allow-root
wp config create --dbname=$banco --dbuser=hqmoraes --dbpass=ApikiMeContrata --dbhost=db-apiki.cwaw1inzljwb.us-east-1.rds.amazonaws.com --allow-root
wp db create --allow-root
wp core install --url=52.201.236.131 --title=\"Apiki me contrata\" --admin_user=hqmoraes --admin_password=ApikiMeContrata --admin_email=hq@hospedar.net --allow-root " > nginx/wp.sh
docker exec nginx chmod u+x /opt/nginx/wp.sh
docker exec nginx /bin/bash /opt/nginx/wp.sh
