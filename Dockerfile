# Use the official PHP 8.1-FPM image
FROM php:8.1-fpm

# Install Apache
RUN apt-get update && apt-get install -y \
    apache2 \
    libapache2-mod-fcgid

# Enable necessary Apache modules
RUN a2enmod proxy proxy_fcgi setenvif

# Copy Apache configuration
COPY apache-config/000-default.conf /etc/apache2/sites-available/000-default.conf

# Configure Apache to use PHP-FPM
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Copy website files
COPY html/ /var/www/html/

# Ensure Apache PID file directory exists
RUN mkdir -p /var/run/apache2

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
