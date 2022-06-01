# Passos para a instalação e configuração das ferramentas do desafio. (executar como root)

1. `apt update && apt -y install nginx ca-certificates curl gnupg lsb-release`
2. `mkdir -p /etc/apt/keyrings`
3. `curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg`
4. `echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null`
5. `apt update`
6. `apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin`
7. `docker run --name mysql -e MYSQL_ROOT_PASSWORD=myrocks26 -d -p 3306:3306 mysql:5.7-debian`
8. `docker run --name wordpress -p 8080:80 -e WORDPRESS_DB_HOST=172.17.0.2 -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=myrocks26 -e WORDPRESS_DB_NAME=wordpress -d wordpress:6-php8.1-apache`
9. `cd /etc/nginx/sites-enabled`
10. `> default`
11. `vim default`
12. 
```server {
    server_name 18.230.130.125;
    listen 80;
    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
    client_max_body_size 200M;
}
```
13. `/etc/init.d/nginx restart`
14. Observei que as variáveis de ambiente passadas na criação do conteiner do wordpress não funcionaram pois não alteraram o wp-config.php, então...
15. `passwd admin` (senha: myrocks26)
16. `vim /etc/ssh/sshd_config`
17. Alterar PasswordAuthentication no para yes
18. `/etc/init.d/ssh restart`
19. `docker exec -ti wordpress bash`
20. `apt update && apt -y install ssh`
21. `scp -C wp-config.php admin@172.17.0.1:.`
22. `exit`
23. `mv /home/admin/wp-config.php /root`
24. `docker rm -f wordpress`
25. `docker run --name wordpress -p 8080:80 -v /root/wp-config.php:/var/www/html/wp-config.php -d wordpress:6-php8.1-apache`
