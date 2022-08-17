ARG ARG_WORDPRESS_PHP_APACHE_VERSION
FROM wordpress:${ARG_WORDPRESS_PHP_APACHE_VERSION}

SHELL ["/bin/sh", "-c"]

RUN apt update && \
  apt upgrade -y && \
  apt install -y \
    sudo \
    locales-all \
    bash-completion \
    dh-autoreconf \
    cmake \
    git-core \
    curl \
    wget \
    zip \
    vim && \
  update-alternatives --config editor && \
  apt autoremove --purge && \
  apt autoclean

ARG ARG_LINUX_LOCALE
ENV LC_ALL=$ARG_LINUX_LOCALE LANG=$ARG_LINUX_LOCALE LANGUAGE=$ARG_LINUX_LOCALE

RUN getent passwd '1000' | cut -d: -f1 | { read username; [ -z "$username" ] && exit 0 || deluser --remove-home $username; } && \
  addgroup --gid '1000' user && \
  adduser --disabled-password --gecos '' --uid '1000' --gid '1000' user && \
  passwd -d root && \
  echo 'user ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers && \
  chown user:user -R /usr/local

USER user
WORKDIR /home/user

# ARG ARG_NODE_VERSION
# RUN wget -nv "https://nodejs.org/dist/v${ARG_NODE_VERSION}/node-v${ARG_NODE_VERSION}-linux-x64.tar.gz" && \
#   tar -xf "node-v${ARG_NODE_VERSION}-linux-x64.tar.gz" --directory '/usr/local' --strip-components '1' && \
#   rm -rf "node-v${ARG_NODE_VERSION}-linux-x64.tar.gz" && \
#   npm install -g yarn

# RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
#   php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
#   php composer-setup.php --install-dir='/usr/local/bin' --filename='composer' && \
#   php -r "unlink('composer-setup.php');" && \
#   rm -rf composer-setup.php && \
#   echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.bashrc

RUN sudo chown user:user -R /usr/src/wordpress && \
  sudo chown user:user -R /var/www/html

RUN locale && \
  php -v
  # echo "node: `node -v`" && \
  # echo "npm: `npm -v`" && \
  # echo "yarn: `yarn -v`" && \
  # composer --version
