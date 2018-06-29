#!/bin/bash
#Script voor het maken van een minion
clear;
echo "Dit script zorgt ervoor dat deze machine een Minion wordt";
echo "Downloaden van saltstack install bestand...";
curl -L https://bootstrap.saltstack.com -o install_salt.sh;
echo "Installeren van saltstack...";
read -p "Wat is het ip adres van de master?" ip;
sudo sh install_salt.sh -A $ip;
echo "Installatie is voltooid. Herstarten van de saltstack-minion service..."
sudo systemctl restart salt-minion
echo "Restart succesvol. Het kan 5 minuten duren voordat de minion zich aanbied bij de master.";
