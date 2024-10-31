#!/usr/bin/bash
#Forensics Questions
echo "Make Sure to complete and document the Forensics Questions." >> ubuntu_notes.txt

#Users
echo "Make sure to do the users" >> ubuntu_notes.txt

#Pulling updates
echo "Make sure to apt autoremove unwanted softwares" >> ubuntu_notes.txt
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
echo 

#Lockout Policy
cp /etc/pam.d/common-auth /etc/pam.d/common-auth.backup

#Open and Listening Ports
apt-get install nettools
echo "The output of the netstat command that displays all the ports." >> ubuntu_notes.txt
netstat -a >> ubuntu_notes.txt

#How to close a port
echo "Make sure to use ufw deny command to deny unwanted open ports." >> ubuntu_notes.txt

#Check for shared files and folders
echo "Make sure to check for shared files and folders" >> ubuntu_notes.txt

#Audit Policies
sudo apt update
sudo apt install auditd
sudo systemctl start auditd
sudo systemctl enable auditd

#Disable Root Login
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

#nginx and FTP Services
systemctl list-unit-files

#Change Password Expiration Period
cp /etc/login.defs /etc/login.defs.backup
