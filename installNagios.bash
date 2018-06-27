#!/bin/bash
#Script voor het maken van een minion
#source https://support.nagios.com/kb/article/nagios-core-installing-nagios-core-from-source-96.html#Ubuntu
echo "Eerst wordt de machine ge-update en de benodigde bestanden geinstalleerd...";
sudo apt-get install -y python-software-properties build-essential;
sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php;
sudo apt-get update;
sudo apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libgd-dev;
echo "Machine is succesvol ge-update. Nu worden de bestanden gedownload en uitgepakt.";
cd /tmp;
sudo wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.3.4.tar.gz;
sudo tar xzf nagioscore.tar.gz;
echo "Bestanden zijn binnen gehaald, nu volgt installeren...";
cd /tmp/nagioscore-nagios-4.3.4/;
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled;
sudo make all;
echo "De basis van Nagios is geinstalleerd. Er worden nu een gebruiker en groep aangemaakt, waarop de Nagios service zal draaien.";
sudo useradd nagios;
sudo usermod -a -G nagios www-data;
echo "Binaries, HTML Files en CGIs installeren...";
sudo make install;
sudo make install-init;
sudo update-rc.d nagios defaults;
echo "Installeer externe command file...";
sudo make install-commandmode;
echo "Installeer voorbeeld configuratie file, dit bestand is nodig om Nagios te laten draaien...";
sudo make install-config;
echo "Installeer Apache en de benodigde bestanden...";
sudo make install-webconf;
sudo a2enmod rewrite;
sudo a2enmod cgi;
sudo ufw allow Apache;
sudo ufw reload;
echo "Er moet een wachtwoord worden aangemaakt voor de webinterface. De gebruikersnaam is nagiosadmin.";
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin;
echo "Apache webserver herstarten...";
sudo systemctl restart apache2.service;
echo "Nagios-core starten...";
sudo systemctl start nagios.service
echo "De basis is nu geinstalleerd. Ga naar het ip-adres van de server om te kijken of het draait. Voorbeeld: http:10.0.55.6/nagios";
echo "Nu worden de benodigde plugins nog geinstalleerd. Eerst worden weer extra libraries geinstalleerd...";
sudo apt-get install -y autoconf gcc libc6 libmcrypt-dev make libssl-dev wget bc gawk dc build-essential snmp libnet-snmp-perl gettext;
echo "Downloaden en uitpakken van de plugins...";
cd /tmp;
sudo wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.2.1.tar.gz;
sudo tar zxf nagios-plugins.tar.gz;
echo "Compileren en installeren van de plugins...";
cd /tmp/nagios-plugins-release-2.2.1/;
sudo ./tools/setup;
sudo ./configure;
sudo make;
sudo make install;
echo "De plugins zijn geinstalleerd, herstarten van Nagios...";
sudo systemctl restart nagios.service
echo "Nagios is succesvol geinstalleerd!"
