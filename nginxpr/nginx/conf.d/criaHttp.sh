#!/bin/bash

site="${1}"

siteExiste="$(dig +short ${site})"
if [ -z "${siteExiste}" -o -z "${site}" ] ; then
    echo "Aviso: DNS ${site} não existe"
    #exit 2
fi


echo "
server {
	listen 80;
	server_name "${site}";
	access_log /dev/stdout;
	error_log /dev/stdout;
	include /etc/nginx/todos.conf;
	#add_header Strict-Transport-Security \"\";

	location / {
		proxy_pass	http://"${site}";
	}


	#return 301 https://\$host\$request_uri;
}" > /etc/nginx/conf.d/"${site}".conf

echo "
upstream "${site}" {
	server		172.31.4.151:8100		fail_timeout=5;
}" >> /etc/nginx/conf.d/upstream.conf


nginx -s reload && echo "OK - systemctl reload nginx" || echo "ERRO: systemctl reload nginx"






