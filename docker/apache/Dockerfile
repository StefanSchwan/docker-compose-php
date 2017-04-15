FROM php:7-apache

# COPY ./bin /opt/docker/bin
# RUN chmod +x /opt/docker/bin/*

# RUN apt-get update && apt-get install -y \
#         mysql-client \
#         wget \
#         git \
#         vim \
#         imagemagick \
#         less \
#         tree \
#         rsync \
#         zip \
#         libxml++2.6-dev \
#         libpng-dev \
#         ghostscript \
#         libfreetype6-dev \
#         libjpeg62-turbo-dev \
#         libmcrypt-dev \
#         libpng12-dev \
#         golang-go \
#      && docker-php-ext-install -j$(nproc)\
#         mysqli \
#         soap \
#         zip \
#         iconv \
#         mcrypt \
#      && docker-php-ext-configure gd --with-freetype-dir=/usr/local/include/ --with-jpeg-dir=/usr/local/include/ \
#      && docker-php-ext-install -j$(nproc) gd
#      && apk del
#         freetype-dev \
#         imagemagick \
#         libmcrypt-dev \
#         libfreetype-dev \
#         libjpeg-turbo-dev \
#         libpng-dev \
#         libpng12-dev \
#         libxml2-dev \
#         libxml++2.6-dev \


RUN mkdir /opt/go && export GOPATH=/opt/go && go get github.com/mailhog/mhsendmail
