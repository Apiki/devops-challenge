#!/bin/bash

if [ ! -z "$NODE_NAME" ]; then
	envsubst '$NODE_NAME' < /var/www/html/wp-content/w3tc-config/master.php > /var/www/html/wp-content/w3tc-config/master.template
	mv /var/www/html/wp-content/w3tc-config/master.template /var/www/html/wp-content/w3tc-config/master.php
    # configuraÃ§Ã£o para ter um cÃ³digo php imutavÃ©l, por causa do cache do opcache. ViÃ¡vel em prod
    #echo 'opcache.validate_timestamps = 0' >> /usr/local/etc/php/conf.d/extra-conf.ini

    # Replace session.save_path and memcached session config
    sed -i -e "s/memcached-memcached-svc:11211/$NODE_NAME:5000/g" /usr/local/etc/php/conf.d/extra-conf.ini    

    # Check if newrelic should be installed
	if [ ! -z "$NR_INSTALL_KEY" ]; then
        # Install new relic 
        newrelic-install install

        # Replace PHP Application with our custom name.
        sed -i -e "s/PHP Application/$NR_APP_NAME/g" /usr/local/etc/php/conf.d/newrelic.ini        
	fi	
fi

# dev environment 
if [ ! -z "$MEMCACHED_SERVER" ]; then
    NODE_NAME=$MEMCACHED_SERVER
    envsubst '$NODE_NAME' < /var/www/html/wp-content/w3tc-config/master.php > /var/www/html/wp-content/w3tc-config/master.template
    mv /var/www/html/wp-content/w3tc-config/master.template /var/www/html/wp-content/w3tc-config/master.php
fi

exec /usr/local/bin/docker-entrypoint.sh "$@"