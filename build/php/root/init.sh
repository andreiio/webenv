#!/usr/bin/env bash

cp /overrides.conf /etc/php/7.0/fpm/pool.d/z-overrides.conf

# Remove old pid file
if [ -f /run/php-fpm.pid ]; then
	rm /run/php-fpm.pid
fi

# Start php
/usr/sbin/php-fpm7.0 --nodaemonize
