#!/bin/bash

apt-get install -y php-pear libmcrypt-dev
export PHP_PEAR_PHP_BIN=/usr/local/php7/bin/php

echo -e "\e[33m------\e[0m"
echo -e "\e[33mATENÇÃO: tecle ENTER para a pergunta 'libmcrypt prefix? [autodetect]'\e[0m"
echo -e "\e[33m------\e[0m"

pecl install mcrypt-1.0.1

echo "extension=mcrypt.so" > /usr/local/php7/etc/conf.d/mcrypt.ini

# Remove os programas usados para instalar o mcrypt no PHP.
x="$(dpkg --list | grep php | awk '/^ii/{ print $2}')"
apt-get --purge -y remove $x

/etc/init.d/php7-fpm restart

