#!/usr/bin/env bash
clear

#Open and Listening Ports
apt install net-tools
echo "
The output of the netstat command that displays all the ports." >> ubuntu_notes.txt
netstat -a >> ubuntu_notes.txt

echo "
The output of the ss command that displays all the ports and processes of listening ports:" >> ubuntu_notes.txt
ss -tlnp >> ubuntu_notes.txt

#List Services
echo "
The output of the systemctl command (list-unit-files) that displays all of the unit files:" >> ubuntu_notes.txt
systemctl list-unit-files >> ubuntu_notes.txt

echo "
The ouput of the systemctl command (list-unit-files --state=masked) that displays masked unit files:" >> ubuntu_notes.txt
systemctl list-unit-files --state=masked >> ubuntu_notes.txt

#Check for shared files and folders
echo "
The output of the ls -alF command that displays read, write, and execute permission for the /etc directory." >> ubuntu_notes.txt
ls -alF /etc >> ubuntu_notes.txt

#Check for unauthorized users in admin groups
echo "
Check for unauthorized users in admin groups." >> ubuntu_notes.txt
grep -e root -e adm -e sudo -e lpadmin -e syslog /etc/group >> ubuntu_notes.txt

#Check for unauthorized or unnecessary installed packages.
echo "
The output of the apt commandthat lists all isntalled packages:" >> ubuntu_notes.txt
apt list --installed >> ubuntu_notes.txt
