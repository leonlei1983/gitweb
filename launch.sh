#!/bin/bash

echo "revise user id in /var/www/gitweb ..."
chown -R $USERID:$USERID /var/www/gitweb

echo "apache2 start ..."
/usr/sbin/apache2ctl -D FOREGROUND
