

### Recriando esse ambiente só será necessário usar o comando
 O Ambiente que usei foi ubuntu 18, porém roda também na 20 e 22
 O dominio deve ser no arquivo default.conf e também no docker-compose.yml na parte do certbot, alterando para o respectivo dominio.
 Feito isso é só rodar esse comando.
 ./script.sh depois de clonar os arquivos.
 

### Abaixo está somente como observação um exemplo de configuração do zero.


## Resolução
Exemplo de material.
Prerequisites
- [Install Docker on Ubuntu 22.04](https://www.cloudbooklet.com/how-to-install-docker-on-ubuntu-22-04/). 
- [Install Docker Compose on Ubuntu 22.04.](https://www.cloudbooklet.com/install-and-use-docker-compose-with-docker-on-ubuntu-22-04/).
Please make sure you have completed all the above mentioned steps

Domain pointed to your server IP address.
Docker installed and configured.
Docker Compose installed and configured.
Once you have all the prerequisites done you can proceed to make the setup and configure WordPress.

Step 1: Create a project directory
SSH to your server and start by creating a new project directory named apki-project. You can also name it whatever you need.

mkdir apki-project
Step 2: Create Docker Compose YML File
Now navigate inside the project directory and create a new docker-compose.yml file with the following configuration.

cd apki-project
Create a new docker-compose.yml file.

nano docker-compose.yml
Copy the entire contents below and paste it in the file.

Make sure to replace the below mentioned environment variables.

version: "3.9"
services:
    wordpress:
        container_name: wordpress
        image: wordpress:php8.1-apache
        restart: always
        stdin_open: true
        tty: true
        environment:
            WORDPRESS_DB_HOST: mariadb
            WORDPRESS_DB_USER: apkiuser
            WORDPRESS_DB_PASSWORD: apkipassword
            WORDPRESS_DB_NAME: apki
        volumes:
            - wordpress_data:/var/www/html
            - ./wordpress:/var/www/html
    mariadb:
        container_name: mariadb
        image: mariadb
        restart: always
        environment:
            MYSQL_DATABASE: apki
            MYSQL_USER: apkiuser
            MYSQL_PASSWORD: apkipassword
            MYSQL_RANDOM_ROOT_PASSWORD: 'root_pass'
        volumes:
            - db_data:/var/lib/mysql
    nginx:
        container_name: nginx
        image: nginx:latest
        restart: unless-stopped
        ports:
            - 80:80
            - 443:443
        volumes:
            - ./nginx/conf:/etc/nginx/conf.d
            - ./certbot/conf:/etc/nginx/ssl
            - ./certbot/data:/var/www/html
    certbot:
        container_name: certbot
        image: certbot/certbot:latest
        command: certonly --webroot --webroot-path=/var/www/html --email iohan15@hotmail.com --agree-tos --no-eff-email -d ec2-54-191-26-93.us-west-2.compute.amazonaws.com -d www.ec2-54-191-26-93.us-west-2.compute.amazonaws.com
        volumes:
            - ./certbot/conf:/etc/letsencrypt
            - ./certbot/logs:/var/log/letsencrypt
            - ./certbot/data:/var/www/html
volumes:
    db_data:
    wordpress_data:
Hit CTRL-X followed by Y and ENTER to save and exit the file.

### Here are the configuration details.

version: Compose file version which is compatible with the Docker Engine. You can check compatibility here.
services: here we have 4 services named wordpress, mariadb, nginx and certbot.
image: We use latest WordPress with PHP 8.1, Apache, Mariadb, Nginx and Certbot images available in Docker hub.
volumes:
wordpress: we have configured this directory to be synced with the directory we wish to use as the web root inside the container.
conf: here we will place the Nginx configuration file to be synced with the default Nginx conf.d folder inside the container.
cedtbot/conf: this is where we will receive the SSL certificate and this will be synced with the folder we wish to inside the container.
ports: configure the container to listen upon the listed ports.
command: the command used to receive the SSL certificate.
environment: here we list all the environment variables that are available for the WordPress image.
WORDPRESS_DB_HOST: Here we are using the service name of MariaDB container.
WORDPRESS_DB_USER: Same as the one we have configured in mariadb service.
WORDPRESS_DB_PASSWORD: Same as the one we have configured in mariadb service.
WORDPRESS_DB_NAME: Same as the one we have configured in mariadb service.
### Step 3: Configure Nginx
### As per the docker-compose.yml configuration we need to create the default.conf file inside the nginx/conf directory.

### Create the directory besides your docker-compose.yml file to hold the configuration file.

mkdir -p nginx/conf
Create a file named default.conf.

nano nginx/conf/default.conf

### Place the following configurations, here we use reverse proxy configuration to wordpress container running Apache.

 server {
    listen [::]:80;
    listen 80;

    server_name ec2-54-191-26-93.us-west-2.compute.amazonaws.com www.ec2-54-191-26-93.us-west-2.compute.amazonaws.com;

    root /var/www/html;
    index index.php;

    location ~ /.well-known/acme-challenge {
        allow all; 
        root /var/www/html;
    }

    location / {
        try_files $uri @apache;
    }

    location ~ ^/.user.ini {
        deny all;
    }

    location ~*  .(svg|svgz)$ {
        types {}
        default_type image/svg+xml;
    }

    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }

    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }

    location @apache {
        proxy_set_header X-Real-IP  $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $host;
        proxy_pass http://wordpress:80;
    }

    location ~[^?]*/$ {
        proxy_set_header X-Real-IP  $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $host;
        proxy_pass http://wordpress:80;
    }

    location ~ .php$ {
        proxy_set_header X-Real-IP  $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $host;
        proxy_pass http://wordpress:80;
    }

    location ~/. {
        deny all;
        access_log off;
        log_not_found off;
    }
} 
### Hit CTRL-X followed by Y and ENTER to save and exit the file.

### Now you have your docker compose configuration and your Nginx configuration.

### Step 4: Deploy WordPress with Docker Compose
### Start the containers using the following command, you will receive the SSL certificates once the containers are started.

docker-compose up -d

### Once all containers are started you will see two additional directories certbot and wordpress created alongside your docker-compose.yml file.

### The directory wordpress holds all your WordPress website source code.

### The directory certbot holds all the files related to your SSL certificates.

### To view the containers you can execute the following command.

docker-compose ps

### Este processo é opcional, não vai funcionar no dominio padrão da AWS, mas se for qualquer outro DNS funcionaria.


### Step 5: Configure Let’s Encrypt SSL with Nginx
### As you have received the Let’s Encrypt SSL certificate you can configure HTTPS and setup redirection to HTTPS.

### Edit the default.conf and make the following changes.

nano nginx/conf/default.conf
server {
    listen [::]:80;
    listen 80;

    server_name ec2-54-191-26-93.us-west-2.compute.amazonaws.com www.ec2-54-191-26-93.us-west-2.compute.amazonaws.com;

    return 301 https://www.ec2-54-191-26-93.us-west-2.compute.amazonaws.com$request_uri;
}

 server {
    listen [::]:443 ssl http2;
    listen 443 ssl http2;

    server_name ec2-54-191-26-93.us-west-2.compute.amazonaws.com;

    ssl_certificate /etc/nginx/ssl/live/ec2-54-191-26-93.us-west-2.compute.amazonaws.com/fullchain.pem;
    ssl_certificate_key /etc/nginx/ssl/live/ec2-54-191-26-93.us-west-2.compute.amazonaws.com/privkey.pem;

    return 301 https://www.ec2-54-191-26-93.us-west-2.compute.amazonaws.com$request_uri; 
}

server {
    listen [::]:443 ssl http2;
    listen 443 ssl http2;

    server_name www.ec2-54-191-26-93.us-west-2.compute.amazonaws.com;

    ssl_certificate /etc/nginx/ssl/live/ec2-54-191-26-93.us-west-2.compute.amazonaws.com/fullchain.pem;
    ssl_certificate_key /etc/nginx/ssl/live/ec2-54-191-26-93.us-west-2.compute.amazonaws.com/privkey.pem;

    root /var/www/html;
    index index.php;

    location ~ /.well-known/acme-challenge {
         allow all; 
         root /var/www/html;
    }

    location / {
        try_files $uri @apache;
    }

    location ~ ^/.user.ini {
        deny all;
    }

    location ~*  .(svg|svgz)$ {
        types {}
        default_type image/svg+xml;
    }

    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }

    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }

    location @apache {
        proxy_set_header X-Real-IP  $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $host;
        proxy_pass http://wordpress:80;
    }

    location ~[^?]*/$ {
        proxy_set_header X-Real-IP  $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $host;
        proxy_pass http://wordpress:80;
    }

    location ~ .php$ {
        proxy_set_header X-Real-IP  $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $host;
        proxy_pass http://wordpress:80;
    }

    location ~/. {
        deny all;
        access_log off;
        log_not_found off;
    }
} 
### Hit CTRL-X followed by Y and ENTER to save and exit the file.

### Now restart the Nginx service to load the new configurations.

docker-compose restart nginx