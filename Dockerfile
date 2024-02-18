# Use the official PHP image as the base image
FROM php:cli

# Set the working directory in the container
WORKDIR /var/www/html

# Install PHP extensions and other dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    git \
    curl \
    && docker-php-ext-install zip pdo pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

# Clone the Symfony demo app from GitHub
#RUN git clone https://github.com/symfony/demo .

COPY . .

# Install Symfony dependencies

RUN composer install  --no-dev --optimize-autoloader --no-scripts --no-plugins

# Expose port 8000 to the outside world
EXPOSE 8000

# Command to run the Symfony application
CMD ["symfony", "server:start", "--no-tls", "--port=8000", "--allow-http"]

