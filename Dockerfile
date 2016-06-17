FROM ubuntu:xenial
#FROM php:7-fpm-alpine
MAINTAINER Philipp Hellmich <phil@hellmi.de>

# Install plugins
RUN apt-get update && \
  apt-get -y install wget unzip apache2 libapache2-mod-php php-curl php-xml php-sqlite3 && \
  rm -rf /var/lib/apt/lists/*

# init
RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.1.1/dumb-init_1.1.1_amd64.deb && \
  dpkg -i dumb-init_*.deb && rm dumb-init_*.deb

RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
  ln -sf /dev/stdout /var/log/apache2/other_vhosts_access.log && \
  ln -sf /dev/stderr /var/log/apache2/error.log

# Download latest stable version of Rainloop into /var/www/html
RUN rm -fr /var/www/html && wget -q http://repository.rainloop.net/v2/webmail/rainloop-latest.zip \
  -O /tmp/latest.zip && \
  unzip /tmp/latest.zip \
  -d /tmp && \
  mkdir /var/www/html && \
  mkdir /var/www/html/rainloop && \
  mkdir /var/www/html/data && \
  mv /tmp/rainloop /var/www/html && \
  chown www-data.www-data /var/www/html/data && \
  chown root.root /var/www/html/rainloop && \
  find /var/www/html/rainloop -type d -exec chmod 755 {} \; && \
  find /var/www/html/rainloop -type f -exec chmod 644 {} \; && \
  rm /tmp/latest.zip

RUN cp /var/www/html/rainloop/v/*/index.php.root /var/www/html/index.php

ADD vhost.conf /etc/apache2/sites-available/000-default.conf

VOLUME  ["/var/www/html/data"]

EXPOSE 80

ADD run.sh /run.sh
RUN chmod +x /*.sh

# Server CMD
CMD ["dumb-init", "/run.sh"]
