#!/bin/bash
#Script voor het configureren van de Nagios server om een host toe te voegen.
echo "Dit script zorgt ervoor dat de server de client kan accepteren.";
read -p "Geef een hostnaam op (Deze is zichtbaar in het Nagios overzicht): " hostname;
read -p "Geef het ip-adres op van de client: " ipaddress;
echo "Weghalen van het #'je in /usr/local/nagios/etc/server"
echo "cfg_dir=/usr/local/nagios/etc/servers" >> /usr/local/nagios/etc/nagios.cfg;
echo "Maak een folder aan en maak een host.cfg bestand, waarin de client informatie wordt verwerkt.";
mkdir /usr/local/nagios/etc/servers
touch /usr/local/nagios/etc/servers/host.cfg
echo "#Define a host for the remote machine
define host {
        use                          linux-server
        host_name            		 $hostname
        alias                        remotehost
        address                      $ipaddress
        register                     1
}" >> /usr/local/nagios/etc/servers/host.cfg;
echo "Script afgerond.";
