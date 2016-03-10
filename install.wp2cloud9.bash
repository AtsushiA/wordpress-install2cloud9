#!/bin/bash
##
## WordPress (Ja) & WP-CLI Installation Shell to Cloud9:
## USE IT AT YOUR OWN RISK!


## Download & Set WP-CLI Commnad
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

## Download WordPress Core
wp core download --locale=ja --path=${GOPATH}

## Set WP BASIC Auth Plugin (mu-pluguins)
mkdir -p ${GOPATH}/wp-content/mu-plugins/
wget -O ${GOPATH}/wp-content/mu-plugins/wp-basic-auth.php https://raw.githubusercontent.com/wokamoto/wp-basic-auth/master/plugin.php

## Start MySQL
mysql-ctl start

## WordPress Configure to Cloud9
wp core config --dbname=c9 --dbuser=${C9_USER} --dbpass= --dbhost=localhost --dbprefix=wordpress_

## Set "Stop Apache" cron
mkdir -p ${GOPATH}/.for_wordbench
echo "* */5 * * * /etc/init.d/apache2 stop >/dev/null 2>&1" > ${GOPATH}/.for_wordbench/crontab
sudo cron start
sudo crontab -u root ${GOPATH}/.for_wordbench/crontab

## restart crond
sudo service crond restart

## Set README.md
rm ${GOPATH}/README.md
curl -o ${GOPATH}/README.md https://raw.githubusercontent.com/AtsushiA/wordpress-install2cloud9/for_wordbench/README.md
echo "
  あなたのWordPressのURLは
  https://${C9_HOSTNAME}
  です。
" >> ${GOPATH}/README.md

## Start Apache
sudo sudo /etc/init.d/apache2 start
echo open https://${C9_HOSTNAME}
