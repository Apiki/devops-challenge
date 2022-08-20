FROM technical_challenge_03_app:latest

COPY --chown=user:user . /var/www/html

RUN sudo sed "s/\$scheme/https/g" -i /etc/nginx/sites-available/default

WORKDIR /var/www/html
