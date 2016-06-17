#!/bin/bash

#sed -i -r 's/StartServers.*$/StartServers 1'/ /etc/apache2/mods-available/mpm_prefork.conf
#sed -i -r 's/MinSpareServers.*$/MinSpareServers 1'/ /etc/apache2/mods-available/mpm_prefork.conf
#sed -i -r 's/MaxRequestWorkers.*$/MaxRequestWorkers 20'/ /etc/apache2/mods-available/mpm_prefork.conf

# default
# admin_login = "admin"
# admin_password = "12345"
# /var/www/html/data/_data_/_default_/configs/application.ini

source /etc/apache2/envvars
exec apache2 -D FOREGROUND
