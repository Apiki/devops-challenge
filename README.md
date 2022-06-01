# Passos para a instalação e configuração das ferramentas do desafio. (executar como root)

1. `apt update && apt -y install nginx ca-certificates curl gnupg lsb-release`
2. `mkdir -p /etc/apt/keyrings`
3. `curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg`
4. `echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null`
5. `apt update`
6. `apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin`
7. `docker run --name mysql -e MYSQL_ROOT_PASSWORD=myrocks26 -d -p 3306:3306 mysql:5.7-debian`
8. `docker run --name wordpress -p 8080:80 -e WORDPRESS_DB_HOST=172.17.0.2 -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=myrocks26 -e WORDPRESS_DB_NAME=wordpress -d wordpress:6-php8.1-apache`
