# Source: https://github.com/xbrowse/xbrowse-laptop/blob/master/bootstrap.sh

apt-get update 
apt-get upgrade -y

# basic system libs
apt-get install -y git vim build-essential wget curl unzip

#https://docs.puppetlabs.com/guides/install_puppet/install_debian_ubuntu.html
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i puppetlabs-release-trusty.deb
apt-get update
apt-get install -y puppet

# python
apt-get install -y python-dev python-setuptools
easy_install pip

# postgres 
apt-get install -y libpq-dev postgresql postgresql-contrib postgresql-devel
apt-get install -y mongodb
apt-get install -y libdbi-perl

apt-get install libmysqlclient-dev gfortran libopenblas-dev liblapack-dev libfreetype6-dev libpng-dev -y
apt-get install -y supervisor
apt-get install nginx -y

