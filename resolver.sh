#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
   echo 'This script must be run as root'
   exit 1
fi

source .env

if [ -z $DOMAIN ]; then
	echo 'The $DOMAIN variable isn`t set'
	exit 1
fi

mkdir -p /etc/resolver

if [ ! -e /etc/resolver/$DOMAIN ]; then
	cat > /etc/resolver/$DOMAIN <<-EOL
		nameserver 127.0.0.1
		port 53535
	EOL
fi
