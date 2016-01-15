FROM debian:jessie

WORKDIR /tmp
RUN apt-get -y update && apt-get -y install wget git build-essential unzip curl

ADD etc/apt/ /etc/apt/
RUN wget -q http://www.dotdeb.org/dotdeb.gpg && \
	apt-key add dotdeb.gpg && \
	rm dotdeb.gpg

# Install packages
RUN apt-get -y update && \
	apt-get -y install procps net-tools nano less monit locales-all \
		nginx-full php7.0-fpm php7.0-cli php-all-dev \
		php7.0-intl php7.0-mysql \
		php7.0-curl php7.0-mcrypt

RUN git clone https://github.com/igbinary/igbinary7.git && cd igbinary7 && phpize && ./configure && make && make install

RUN apt-get install -y libmemcached-dev pkg-config
RUN git clone https://github.com/php-memcached-dev/php-memcached.git && ls -la && \
    cd php-memcached \
    && git checkout php7 && phpize && ./configure && make && make install \
    && echo "extension=memcached.so" | tee /etc/php/mods-available/memcached.ini \
    && ln -s /etc/php/mods-available/memcached.ini /etc/php/7.0/fpm/conf.d/20-memcached.ini \
    && ln -s /etc/php/mods-available/memcached.ini /etc/php/7.0/cli/conf.d/20-memcached.ini \
    && rm -rf php-memcached

RUN git clone https://github.com/phpredis/phpredis.git && ls -la
RUN cd phpredis && git checkout php7 && phpize && ./configure --enable-redis-igbinary && make && make install \
    && echo "extension=redis.so" | tee /etc/php/mods-available/redis.ini \
    && ln -s /etc/php/mods-available/redis.ini /etc/php/7.0/fpm/conf.d/20-redis.ini \
    && ln -s /etc/php/mods-available/redis.ini /etc/php/7.0/cli/conf.d/20-redis.ini \
    && rm -rf phpredis

ADD https://github.com/xdebug/xdebug/archive/master.zip /xdebug-master.zip
RUN unzip /xdebug-master.zip \
    && cd xdebug-master \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && echo "zend_extension=xdebug.so" | tee /etc/php/mods-available/xdebug.ini \
    && ln -s /etc/php/mods-available/xdebug.ini /etc/php/7.0/fpm/conf.d/10-xdebug.ini \
    && ln -s /etc/php/mods-available/xdebug.ini /etc/php/7.0/cli/conf.d/10-xdebug.ini \
    && cd / \
    && rm xdebug-master.zip \
    && rm -rf xdebug-master

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Configure nginx
RUN rm -f /etc/nginx/sites-enabled/* /etc/nginx/sites-available/*
COPY nginx/* /etc/nginx/
# Copy directly into sites-enabled to save a build step
COPY nginx/sites-available/* /etc/nginx/sites-enabled/
COPY nginx/conf.d/* /etc/nginx/conf.d/
#override listen tcp

#not sure why is /run by default instead of /var/run
#RUN sed -i -r 's@listen = /run/php/php7.0-fpm.sock@listen = /var/run/php/php7.0-fpm.sock@' /etc/php/7.0/fpm/pool.d/www.conf
#in case we want tcp instead of socket
RUN sed -i -r 's@listen = /run/php/php7.0-fpm.sock@listen = 127.0.0.1:9000@' /etc/php/7.0/fpm/pool.d/www.conf
#php datetime
#RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php7/fpm/php.ini
#RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php7/cli/php.ini

RUN service php7.0-fpm restart

# Configure monit to run the required services
COPY monit/* /etc/monit/conf.d/

EXPOSE 80 443

# Monit will host all of the services
CMD ["/usr/bin/monit", "-I", "-c", "/etc/monit/monitrc"]
