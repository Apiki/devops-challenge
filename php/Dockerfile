FROM wordpress:5.4.2-php7.4-apache

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
  libtidy-dev \
  zlib1g-dev \
  libicu-dev \
  libpq-dev \
  libmemcached-dev \
  locales \
  gettext-base \
  vim \
  gnupg gnupg2 gnupg1
  
RUN localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8

ENV LANG pt_BR.UTF-8
ENV LC_ALL pt_BR.UTF-8
  
RUN pecl install apcu \
  pecl install msgpack \
  pecl install igbinary

RUN docker-php-ext-install pdo_mysql \
  && docker-php-ext-install tidy \
  && docker-php-ext-enable apcu \
  && docker-php-ext-enable msgpack \
  && docker-php-ext-enable igbinary

# InstalaÃ§Ã£o da extensÃ£o memcached
RUN curl -kL -o /tmp/memcached.tar.gz "https://github.com/php-memcached-dev/php-memcached/archive/v3.1.3.tar.gz" \
  && mkdir -p /usr/src/php/ext/memcached \
  && tar -C /usr/src/php/ext/memcached -zxvf /tmp/memcached.tar.gz --strip 1 \
  && docker-php-ext-configure memcached --enable-memcached-igbinary --enable-memcached-json --enable-memcached-msgpack

RUN docker-php-ext-install memcached

RUN apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
  rm -rf /var/lib/apt/lists/*

RUN { \
    echo 'memory_limit = 256M'; \
    echo 'post_max_size = 50M'; \
    echo 'upload_max_filesize = 50M'; \
    echo 'max_execution_time = 300'; \
    echo 'date.timezone = "America/Fortaleza"'; \
    echo 'max_input_vars = 4000'; \
    echo 'realpath_cache_size = 1M'; \
    echo 'realpath_cache_ttl = 300'; \
    echo 'output_buffering = 4096'; \
    echo 'short_open_tag = "off"'; \
    echo 'expose_php = "off"'; \    
    echo 'apc.shm_size = 256M'; \    
    echo 'apc.ttl = 7200'; \    
    echo 'apc.user_ttl = 7200'; \
    echo 'apc.gc_ttl = 3600'; \
    echo 'memcached.sess_binary_protocol = "Off"'; \
    echo 'session.save_handler = "memcached"'; \
    echo 'session.save_path = "memcached-memcached-svc:11211"'; \
} > /usr/local/etc/php/conf.d/extra-conf.ini

COPY php-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/php-entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT ["php-entrypoint.sh"]
CMD ["apache2-foreground"]
