#!/bin/sh
SERVICE=srv

### Maraidb install
sudo apt install -y mariadb-server
sudo mysql_secure_install

### PHP 
# prerequiremnets
sudo apt install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add -
sudo apt update -y 

# install
sudo apt install -y \
	php8.1 \
	php8.1-bz2 \
	php8.1-cgi \
	php8.1-curl \
	php8.1-fpm \
	php8.1-gd \
	php8.1-intl \
	php8.1-mbstring \
	php8.1-mysql \
	php8.1-opcache \
	php8.1-xml \
	php8.1-zip 

# config 
sudo cp /etc/php/8.1/fpm/pool.d/www.conf /etc/php/8.1/fpm/pool.d/$SERVICE.conf
sudo sed -i 's/\[www\]/\['$SERVICE'\]/' /etc/php/8.1/fpm/pool.d/$SERVICE.conf
sudo sed -i 's/php8.1-fpm.sock/php8.1-fpm_'$SERVICE'.sock/' /etc/php/8.1/fpm/pool.d/$SERVICE.conf 

sudo service php8.1-fpm restart 

### NGiNX
sudo apt install -y nginx 
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.orig
sudo rm -rf /etc/nginx/sites-enabled/default
sudo cp default.conf /etc/nginx/sites-available/default
sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

sudo service nginx restart
