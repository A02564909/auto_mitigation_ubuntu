#!/usr/bin/bash
#Pulling updates
echo "
Make sure to apt autoremove unwanted softwares" >> ubuntu_notes.txt
apt-get update
apt-get upgrade

#Installing and enabling Universal Firewall.
apt install ufw
ufw enable

#Finding and deleting unwanted file types in the home directory.
find /home -type f | grep -if extensions.txt
for file in $(find /home -type f | grep -if extensions.txt); do rm -f "$file"; done

#PW Policy
apt install libpam-pwquality
cp /etc/pam.d/common-password /etc/pam.d/common-password.backup 

#Open and Listening Ports
apt install net-tools
echo "
The output of the netstat command that displays all the ports:" >> ubuntu_notes.txt
netstat -a >> ubuntu_notes.txt

#How to close a port
echo "
Make sure to use ufw deny command to deny unwanted open ports." >> ubuntu_notes.txt

#Check for shared files and folders
echo "
Make sure to check for shared files and folders." >> ubuntu_notes.txt

#Audit Policies
sudo apt update
sudo apt install auditd
sudo systemctl start auditd
sudo systemctl enable auditd

#nginx and FTP Services
echo "
The output of the systemctl command that displays all of the unit files:" >> ubuntu_notes.txt
systemctl list-unit-files >> ubuntu_notes.txt
echo "
Use the systemctl stop and disable command to remove unwanted services." >> ubuntu_notes.txt
