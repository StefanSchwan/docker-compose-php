FROM php:7.0-fpm-alpine

ENV PATH /var/www/html/vendor/bin:$PATH
ADD ./etc/php.ini.development /usr/local/etc/php/php.ini
ADD ./bin /opt/docker/bin/
RUN apk add --update --no-cache \
          alpine-sdk \
          autoconf \
          bash \
          freetype-dev \
          imagemagick \
          libltdl \
          libmcrypt \
          libmcrypt-dev \
          libjpeg-turbo-dev \
          libpng-dev \
          libxml2-dev \
          less \
          mysql-client \
          openssl \
          ghostscript \
          git \
          go \
          rsync \
          tree \
          wget \
          vim \
    && docker-php-ext-install \
          iconv \
          mcrypt \
          mysqli \
          soap \
          zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/local/include/ --with-jpeg-dir=/usr/local/include/ \
    && docker-php-ext-install gd \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && apk del \
          alpine-sdk \
          autoconf \
          freetype-dev \
          imagemagick \
          libmcrypt-dev \
          libjpeg-turbo-dev \
          libpng-dev \
          libxml2-dev \
    && rm -rf /var/cache/apk/* \
    && mkdir /opt/go && export GOPATH=/opt/go && go get github.com/mailhog/mhsendmail
