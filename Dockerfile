FROM php:8.2-apache

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
RUN apt-get update \
    && apt-get install -y libpng-dev \
        libwebp-dev \
        libjpeg62-turbo-dev \
        libpng-dev libxpm-dev \
        libfreetype6-dev \
    && apt-get clean
RUN docker-php-ext-configure gd \
    --with-webp \
    --with-jpeg \
    --with-xpm \
    --with-freetype
RUN docker-php-ext-install gd

# Apache prefork config
COPY Docker/mpm_prefork.conf /etc/apache2/mods-enabled/mpm_prefork.conf

COPY . /var/www/html/
WORKDIR /var/www/html/
RUN mkdir -p img # Create if doesn't exist
