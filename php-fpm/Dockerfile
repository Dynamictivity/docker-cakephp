FROM ubuntu:14.04

MAINTAINER Travis Rowland <travis.rowland@gmail.com>

# Environment Variables
ENV DEBIAN_FRONTEND noninteractive
ENV TIMEZONE            UTC
ENV PHP_MEMORY_LIMIT    512M
ENV MAX_UPLOAD          50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST        100M

# Update packages
RUN apt-get clean && \
    apt-get autoremove

# Install required packages
RUN apt-get update && \
    apt-get -y install \
    php5 \
    php-pear \
    php5-ldap \
    php5-pgsql \
    php5-mcrypt \
    php5-gmp \
    php5-json \
    php5-mysql \
    php5-gd \
    php5-odbc \
    php5-xmlrpc \
    php5-memcache \
    php5-mssql \
    php5-curl \
    php5-imagick \
    php5-intl \
    php5-fpm \
    git \
    curl \
    wget

# Set environment variables
RUN sed -i '/daemonize /c daemonize = no' /etc/php5/fpm/php-fpm.conf && \
    sed -i "s|;*clear_env\s*=\s*yes|clear_env = no|g" /etc/php5/fpm/php-fpm.conf && \
	  sed -i '/^listen /c listen = 0.0.0.0:9000' /etc/php5/fpm/pool.d/www.conf && \
	  sed -i 's/^listen.allowed_clients/;listen.allowed_clients/' /etc/php5/fpm/pool.d/www.conf && \
	  sed -i "s|;*listen\s*=\s*/||g" /etc/php5/fpm/pool.d/www.conf && \
	  sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php5/fpm/php.ini && \
	  sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php5/fpm/php.ini && \
    sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php5/fpm/php.ini && \
    sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php5/fpm/php.ini && \
    sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php5/fpm/php.ini && \
    sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php5/fpm/php.ini && \

    # Install composer
    curl -sS https://getcomposer.org/installer | php && \
        mv composer.phar /usr/local/bin/composer && \
        echo "PATH=$PATH:/usr/local/bin" >> ~/.bash_profile && \
        echo "export PATH" >> ~/.bash_profile && \
        . ~/.bash_profile

# Set Workdir
WORKDIR /www

# Expose volumes
VOLUME ["/www"]

# Expose ports
EXPOSE 9000

ADD app.php /
ADD mysql-sessions.php /
ADD init.sh /
RUN chmod 765 /init.sh
RUN mkdir /root/.ssh
ADD id_rsa /
RUN mv /id_rsa /root/.ssh/id_rsa
RUN chmod 600 ~/.ssh/id_rsa
RUN  echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config

# Entry point
ENTRYPOINT ["/init.sh"]
