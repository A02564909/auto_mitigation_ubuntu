#!/usr/bin/bash
#Pulling updates
apt-get update
apt-get upgrade
#Installing and enabling Universal Firewall.
apt install ufw
ufw enable
#Finding and deleting unwanted file types in the home directory.
find /home -type f | grep -if extensions.txt
for file in $(find /home -type f | grep -if extensions.txt); do rm -f "$file"; done
