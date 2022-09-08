#!/bin/bash

bash -it
exit

apt update -y
apt install -y perl6-readline dialog
apt upgrade -y
apt install -y certbot python3-certbot-nginx vim dnsutils cron

openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

cd /etc/ssl/
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

rm /etc/nginx/sites-enabled/default

echo '
15 3 * * * root /usr/bin/certbot renew --quiet && /usr/sbin/nginx -s reload
' >> /etc/crontab

service cron start


touch /etc/letsencrypt/options-ssl-nginx.conf

echo "
client_body_timeout 5s;
client_header_timeout 5s;

location ^~ /.well-known/ {
    default_type \"text/plain\";
    root    /etc/letsencrypt;
}
location = /.well-known/ {
    return 404;
}
" > /etc/nginx/todos.conf

#copiar nginx.conf para /etc/nginx/nginx.conf
#copiar criaHttp.sh e criaHttps.sh para /etc/nginx/conf.d/

nginx -g 'daemon off;'
#nginx -s reload
exit
















