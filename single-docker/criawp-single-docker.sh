#!/bin/bash
if [ -z "$1"  ]
then
        echo "É necessário informar um nome, sem acentos e sem espaços ou caracteres especiais. Pode ter números ou _. Tente outra vez, por favor!"
else

#Criar pasta com os arquivos de configuração
banco=`TZ='America/Sao_Paulo' date +"%Y%m%d%H%M%S"`_$1
dbhost="db-apiki.cwaw1inzljwb.us-east-1.rds.amazonaws.com"
user="hqmoraes"
passwd="ApikiMeContrata"
wp_user="hqmoraes"
wp_passwd="ApikiMeContrata"
wp_email="hq@hospedar.net"
url_externo="52.201.236.131"
url_interno="127.0.0.1:801"
#criar o arquivo de configuração do nginx

echo "server {

	listen 80;

	location / {

		proxy_pass         http://$url_interno;
		proxy_redirect     off;
		proxy_set_header   Host \$host;
		proxy_set_header   X-Real-IP \$remote_addr;
		proxy_set_header   X-Forwarded-For \$proxy_add_x_forwarded_for;
		proxy_set_header   X-Forwarded-Host \$server_name;

	}
}" > nginx/default.conf


#Criar a docker com o nginx expondo a porta 80 e mapeando a pasta etc fora da docker na pasta atual
docker run -id --name $1 -p 80:80 -p 443:443 -v `pwd`/nginx:/opt/nginx --env TERM=linux --env DEBIAN_FRONTEND="noninteractive" ubuntu:latest
#instalar o apache2 e o nginx
docker exec $1 apt-get update
docker exec $1 apt-get install apt-utils -y
docker exec $1 apt-get install libterm-ui-perl -y
docker exec $1 echo 'tzdata tzdata/Areas select America' | docker exec $1 debconf-set-selections
docker exec $1 echo 'tzdata tzdata/Zones/America select Sao_Paulo' | docker exec $1 debconf-set-selections
docker exec $1 apt install tzdata -y
docker exec $1 apt-get install apache2 nginx -y
docker exec $1 apt-get install curl php-fpm php-mysql php-curl mysql-client vim -y
docker exec $1 /etc/init.d/php8.1-fpm start
#configurar o apache para executar na porta 801
docker exec $1 sed -i 's/80/801/' /etc/apache2/ports.conf
# recriar o arquivo default.conf do nginx
docker exec $1 mv /opt/nginx/default.conf  /etc/nginx/conf.d/default.conf -f
#iniciar o apache2
docker exec $1 /etc/init.d/apache2 start
docker exec $1  a2enmod proxy_fcgi setenvif
docker exec $1 a2enconf php8.1-fpm
docker exec $1 /etc/init.d/apache2 restart
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
docker exec $1 mv /opt/nginx/default  /etc/nginx/sites-enabled/default -f
docker exec $1 /etc/init.d/nginx start
#instalar o wordpress
echo "curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
cd /var/www/html
wp core download --path=/var/www/html --locale=pt_BR --allow-root
wp config create --dbname=$banco --dbuser=$user --dbpass=$passwd --dbhost=$dbhost --allow-root
wp db create --allow-root
wp core install --url=$url_externo --title=\"Apiki me contrata\" --admin_user=$wp_user --admin_password=$wp_passwd --admin_email=$wp_email --allow-root " > nginx/wp.sh
docker exec $1 chmod u+x /opt/nginx/wp.sh
docker exec $1 /bin/bash /opt/nginx/wp.sh

fi
