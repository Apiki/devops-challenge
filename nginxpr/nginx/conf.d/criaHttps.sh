#!/bin/bash

unalias mv 2> /dev/null

site="${1}"

mv -f /etc/nginx/conf.d/"${site}".conf /etc/nginx/conf.d/"${site}".conf.bkp

echo "

server {
	listen 80;
	server_name "${site}";
	access_log /dev/stdout;
	error_log /dev/stdout;
	include /etc/nginx/todos.conf;
	#add_header Strict-Transport-Security \"\";

	return 301 https://\$host\$request_uri;
}

server {
        listen 443 ssl;
        server_name     "${site}";
        access_log      /dev/stdout;
        error_log       /dev/stdout;
	include /etc/nginx/todos.conf;

        ssl_certificate /etc/letsencrypt/live/"${site}"/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/"${site}"/privkey.pem;
        include /etc/letsencrypt/options-ssl-nginx.conf;
        ssl_dhparam /etc/ssl/certs/dhparam.pem;

	location / {
		proxy_pass		http://"${site}";
	}

	add_header Strict-Transport-Security \"max-age=63072000; includeSubdomains; \";
	add_header X-Frame-Options \"DENY\";

}" >> /etc/nginx/conf.d/"${site}".conf

certbot certonly --webroot -w /etc/letsencrypt/ -d "${site}" && echo "OK - certbot certonly --webroot -w /etc/letsencrypt/ -d ${site}" || {
	echo "ERRO - certbot certonly --webroot -w /etc/letsencrypt/ -d ${site}"
	echo "Verificar o arquivo /etc/nginx/conf.d/${site}.conf"
	exit 1
}

#sed -i 's!#return 301 https://\$host\$request_uri;!return 301 https://\$host\$request_uri;!g' /etc/nginx/conf.d/"${site}".conf

nginx -s reload && echo "OK - systemctl reload nginx" || echo "ERRO: systemctl reload nginx"



