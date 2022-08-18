FROM ubuntu:latest


ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN echo "tzdata tzdata/Areas select America" > /tmp/preseed.txt; \
    echo "tzdata tzdata/Zones/Europe select Boa_Vista" >> /tmp/preseed.txt; \
    debconf-set-selections /tmp/preseed.txt && \
    apt update && \
    apt install -y tzdata

RUN apt install systemctl apache2 apache2-utils ghostscript libapache2-mod-php php8.1 php8.1-mysql curl -y

RUN curl https://wordpress.org/latest.tar.gz | tar zx -C /var/www/html
RUN chown -R www-data:www-data /var/www/html/
RUN chmod -R 755 /var/www/html/

COPY --chown=www-data:www-data wp-config.php /var/www/html/wordpress/wp-config.php

CMD ["apache2ctl", "-D", "FOREGROUND"]