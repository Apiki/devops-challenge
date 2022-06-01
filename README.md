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
12. ``` server {
    server_name ibradim.org.br www.ibradim.org.br;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    client_max_body_size 200M;
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/ibradim.org.br/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/ibradim.org.br/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.ibradim.org.br) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = ibradim.org.br) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    server_name ibradim.org.br www.ibradim.org.br;

    listen 80;
    return 404; # managed by Certbot




}
```
13. 
