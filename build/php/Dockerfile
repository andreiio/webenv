FROM ubuntu:16.04

RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update && apt-get install -y --no-install-recommends \
	php7.0-fpm \
	php7.0-dba \
	php7.0-bcmath \
	php7.0-bz2 \
	php7.0-cgi \
	php7.0-cli \
	php7.0-common \
	php7.0-curl \
	php7.0-gd \
	php7.0-gmp \
	php7.0-imap \
	php7.0-intl \
	php7.0-ldap \
	php7.0-mbstring \
	php7.0-mcrypt \
	php7.0-mysql \
	php7.0-odbc \
	php7.0-readline \
	php7.0-soap \
	php7.0-sqlite3 \
	php7.0-tidy \
	php7.0-tokenizer \
	php7.0-xml \
	php7.0-xmlrpc \
	php7.0-zip \
	php-xdebug \
	&& rm -rf /var/lib/apt/lists/*

COPY root /

CMD ["/init.sh"]

VOLUME ["/www"]

EXPOSE 9000
