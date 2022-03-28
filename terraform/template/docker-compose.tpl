version: \"3.9\"
services:
    wp:
        image: wordpress:5.9.2-php8.1-apache
        container_name: wp_container
        restart: always
        environment:
            WORDPRESS_DB_HOST: ${dbhost}
            WORDPRESS_DB_USER: ${dbuser}
            WORDPRESS_DB_PASSWORD: ${dbpassword}
            WORDPRESS_DB_NAME: ${dbname}

    nginx:
        depends_on: 
            - wp
        image: nginx:1.20-alpine
        restart: always
        command: \"/bin/sh -c 'nginx -s reload; nginx -g \\\"daemon off;\\\"'\"
        ports:
            - \"${external_port}:80\"
        volumes:
            - ./nginx:/etc/nginx/conf.d/