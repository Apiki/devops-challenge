curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
cd /var/www/html
wp core download --path=/var/www/html --locale=pt_BR --allow-root
wp config create --dbname=20221219_apiki3 --dbuser=hqmoraes --dbpass=ApikiMeContrata --dbhost=db-apiki.cwaw1inzljwb.us-east-1.rds.amazonaws.com --allow-root
wp db create --allow-root
wp core install --url=52.201.236.131 --title="Apiki me contrata" --admin_user=hqmoraes --admin_password=ApikiMeContrata --admin_email=hq@hospedar.net --allow-root 
