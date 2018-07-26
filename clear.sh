#!/bin/bash

$ x="$(dpkg --list | grep php | awk '/^ii/{ print $2}')"
$ apt-get --purge remove $x

unlink /etc/apache2/mods-enabled/php5.conf
unlink /etc/apache2/mods-enabled/php5.load

service apache2 restart
