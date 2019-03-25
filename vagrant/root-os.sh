#! /bin/bash
#
# This file is about provisioning the OS, with the root user.

CONFIGS='/vagrant/vagrant'
APACHE_CONFIGS='/etc/apache2'
APACHE_SITES_PATH="$APACHE_CONFIGS/sites-available"

APACHE_MODULES=''
APT_PACKAGES=''

if [[ -s $CONFIGS/apache-modules.cfg ]]; then
    APACHE_MODULES=$(cat $CONFIGS/apache-modules.cfg)
fi

if [[ -s $CONFIGS/apache-modules.cfg ]]; then
    APT_PACKAGES=$(cat $CONFIGS/apt-packages.cfg)
fi

echo "
`date '+%H:%M'`: Bootstrapping…
=============================================================================="

echo "
`date '+%H:%M'`: Updating Ubuntu repositories…
=============================================================================="
apt-get update

## @todo Upgrade system environments in an non-interactive way.
# echo "
# `date '+%H:%M'`: Upgrading Ubuntu packages…
# =============================================================================="
# sudo apt upgrade -y

echo "
`date '+%H:%M'`: Installing needed packages…
=============================================================================="
apt-get install -y $(cat /vagrant/vagrant/apt-packages.cfg)

echo "
`date '+%H:%M'`: Updating Apache configuration…
=============================================================================="
sed -i s#/var/www/html#/vagrant/spip#g $APACHE_SITES_PATH/000-default.conf
sed -i s#/var/www#/vagrant/spip#g $APACHE_CONFIGS/apache2.conf

echo "
`date '+%H:%M'`: Enabling Apache modules…
=============================================================================="
sudo a2enmod $APACHE_MODULES

echo "
`date '+%H:%M'`: restarting Apache server…
=============================================================================="
sudo service apache2 restart


