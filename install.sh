#!/bin/bash
cd "$(dirname "$0")"

# Create a dir for storing PHP module conf
mkdir /usr/local/php7/etc/conf.d

# Symlink php-fpm to php7-fpm
ln -s /usr/local/php7/sbin/php-fpm /usr/local/php7/sbin/php7-fpm

# Add config files
cp php-src/php.ini-production /usr/local/php7/lib/php.ini
cp conf/www.conf /usr/local/php7/etc/php-fpm.d/www.conf
cp conf/php-fpm.conf /usr/local/php7/etc/php-fpm.conf
cp conf/modules.ini /usr/local/php7/etc/conf.d/modules.ini

# Add mod_fastcgi files
cp conf/fastcgi.load /etc/apache2/mods-available/fastcgi.load
cp conf/fastcgi.conf /etc/apache2/mods-available/fastcgi.conf
cp conf/mod_fastcgi.so /usr/lib/apache2/modules/mod_fastcgi.so

mkdir /var/lib/apache2
mkdir /var/lib/apache2/fastcgi
chgrp www-data /var/lib/apache2/fastcgi/
chmod 775 /var/lib/apache2/fastcgi/

a2enmod actions cgid fastcgi
service apache2 restart

# Add the init script
cp conf/php7-fpm.init /etc/init.d/php7-fpm
chmod +x /etc/init.d/php7-fpm
update-rc.d php7-fpm defaults

cp conf/php7-fpm.conf /etc/apache2/conf.d/php7-fpm.conf

service php7-fpm start
