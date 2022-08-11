# Desafio DevOps Apiki
# Mateus Assis
# Utilizando codigos terraform 
# Maquina contem conteiner docker 
# Instalação dos serviços solicitados 
# PHP versão mais atual 
# Ngnix como prox reverso na porta 81
# Apache
# Mysql como banco de dados


# Instalação: 

# Acessando como root
sudo su - 
# Atualizando 
sudo apt update
# Instalando Apache e liberando para acesso HTTP
sudo apt install apache2
sudo ufw app list
sudo ufw app list
sudo ufw allow in "Apache"
# Instalação de MYSQL-SERVER
sudo apt install mysql-server
# Instalação do PHP
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php8.0 libapache2-mod-php8.0
sudo systemctl restart apache2
sudo apt update
sudo apt install php8.0-fpm libapache2-mod-fcgid
sudo a2enmod proxy_fcgi setenvif
sudo a2enconf php8.0-fpm
systemctl restart apache2
sudo apt install php8.0-mysql php8.0-gd
# Criando banco de dados WordPress
mysql -u root -p
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER 'wordpressuser'@'%' IDENTIFIED WITH mysql_native_password BY '*******';
GRANT ALL ON wordpress.* TO 'wordpressuser'@'%';
FLUSH PRIVILEGES;
EXIT;
# Instalando extensões PHP adicionais 
sudo apt update
sudo apt install php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip
sudo systemctl restart apache2
# Habilitando o .taccess
sudo nano /etc/apache2/sites-available/wordpress.conf
adicionar o conteudo: 
<Directory /var/www/wordpress/>
	AllowOverride All
</Directory>
sudo a2enmod rewrite
sudo apache2ctl configtest
sudo systemctl restart apache2

# Instalando WordPress
cd /tmp
curl -O https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
touch /tmp/wordpress/.htaccess
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
mkdir /tmp/wordpress/wp-content/upgrade
sudo cp -a /tmp/wordpress/. /var/www/wordpress
sudo chown -R www-data:www-data /var/www/wordpress
sudo find /var/www/wordpress/ -type d -exec chmod 750 {} \;
sudo find /var/www/wordpress/ -type f -exec chmod 640 {} \;
curl -s https://api.wordpress.org/secret-key/1.1/salt/ (GERAR CHAVE secret-key)
sudo nano /var/www/wordpress/wp-config.php (adicionar as chaves criadas)
sudo nano /var/www/wordpress/wp-config.php (adicionar também o banco de dados criado)
# instalando o nginx 
apt-get install nginx -y
nano /etc/nginx/sites-available/default
editar a porta para 81
nginx -t
systemctl restart nginx
