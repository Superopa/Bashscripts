#!/bin/bash
#Script voor het installeren van een Nagios Client
echo "Dit script installeert een Nagios client en zorgt ervoor dat de logs gestuurd worden naar de server.";
sudo apt-get install syslog-ng;
echo "Maakt een back-up van de standaard config file.";
sudo mv /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf.BAK;
echo "Maakt nu een nieuwe config file.";
echo '@version: 3.5
@include "scl.conf"
@include "`scl-root`/system/tty10.conf"
source s_local { system(); internal(); };
destination d_syslog_tcp {
              syslog("10.0.0.9" transport("tcp") port(514)); };
log { source(s_local);destination(d_syslog_tcp); };' >> /etc/syslog-ng/syslog-ng.conf;
echo "Bestand succesvol aangemaakt. Herstarten van de services...";
sudo systemctl start syslog-ng;
sudo systemctl enable syslog-ng;
echo "Kloar.";