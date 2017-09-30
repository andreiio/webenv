#!/usr/bin/env bash

# Populate the /config dir if it's empty
if [ -d /config -a -z "$(ls -A /config)" ]; then

	mkdir -p /config/ssl

	mv /httpd.conf /config/httpd.conf
	mv /sites /config

	sed -i "s/DOMAIN/$DOMAIN/g" /config/sites/default.conf
fi

# Populate the /www dir if it's empty
if [ -d /www -a -z "$(ls -A /www)" ]; then
	mkdir -p www/$DOMAIN
fi

# Generate self signed certificate for current domain
if [ ! -f "/config/ssl/$DOMAIN.crt" ]; then
	conf="/config/ssl/$DOMAIN-openssl.conf"
	path="/config/ssl/$DOMAIN"

	mv /openssl.conf $conf
	sed -i "s/DOMAIN/$DOMAIN/g" $conf

	openssl req -verbose -new -newkey rsa:2048 -days 3650 -nodes -x509 \
	    -config $conf \
	    -extensions v3_req \
	    -keyout $path.key \
	    -out $path.crt

	# Cleanup
	rm -- $conf
fi

# Remove old pid file
if [ -f /var/run/apache2/apache2.pid ]; then
	rm /var/run/apache2/apache2.pid
fi

# Start apache
apachectl -f /config/httpd.conf -DFOREGROUND
