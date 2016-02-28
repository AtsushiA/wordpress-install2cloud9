#!/bin/bash
##
## WordPress (Ja) & WP-CLI Installation Shell to Cloud9:
## USE IT AT YOUR OWN RISK!


## Download & Set WP-CLI Commnad
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

## Download WordPress Core
wp core download --locale=ja --path=/home/ubuntu/workspace

## Start MySQL
mysql-ctl start

## WordPress Configure to Cloud9
wp core config --dbname=c9 --dbuser=${$C9_USER} --dbpass= --dbhost=localhost --dbprefix=wordpress_
