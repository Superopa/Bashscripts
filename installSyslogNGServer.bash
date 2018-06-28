#!/bin/bash
#Script voor het installeren van een Nagios Server
echo "Dit script installeert syslog-ng en maakt hiervan een server.";
sudo apt-get install syslog-ng;
echo "Maakt een back-up van de standaard config file.";
sudo mv /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf.BAK;
echo "Maakt nu een nieuwe config file.";
echo '@version: 3.5
@include "scl.conf"
@include "`scl-root`/system/tty10.conf"
    options {
        time-reap(30);
        mark-freq(10);
        keep-hostname(yes);
        };
    source s_local { system(); internal(); };
    source s_network {
        syslog(transport(tcp) port(514));
        };
    destination d_local {
    file('"/var/log/syslog-ng/messages_${HOST}"'); };
    destination d_logs {
        file(
            "/var/log/syslog-ng/logs.txt"
            owner("root")
            group("root")
            perm(0777)
            ); };
    log { source(s_local); source(s_network); destination(d_logs); };' >> /etc/syslog-ng/syslog-ng.conf
echo "Het bestand logs.txt wordt nu gemaakt in het nieuwe mapje /var/log/syslog-ng.";
sudo mkdir /var/log/syslog-ng;
sudo touch /var/log/syslog-ng/logs.txt;
sudo systemctl start syslog-ng;
sudo systemctl enable syslog-ng;
