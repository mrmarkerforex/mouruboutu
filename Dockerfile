# Utilise une image officielle PHP avec Apache
FROM php:8.2-apache

# Installe les dépendances système
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    curl \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-install pdo pdo_mysql zip mbstring exif pcntl

# Installe Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Copie les fichiers de ton projet dans le conteneur
COPY . /var/www/html/

# Donne les bons droits
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Configure Apache
COPY ./public /var/www/html

# Active mod_rewrite pour Laravel
RUN a2enmod rewrite
COPY ./apache.conf /etc/apache2/sites-available/000-default.conf
