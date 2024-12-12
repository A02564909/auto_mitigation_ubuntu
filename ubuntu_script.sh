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

#Open and Listening Ports.
apt install net-tools
echo "
The output of the netstat command that displays all the ports:" >> ubuntu_notes.txt
netstat -a >> ubuntu_notes.txt

echo "
The output of the ss command that displays all the ports and processes of listening ports:" >> ubuntu_notes.txt
ss -tlnp >> ubuntu_notes.txt

#How to close a port
echo "
Make sure to use ufw deny command to deny unwanted open ports." >> ubuntu_notes.txt

#Check for shared files and folders
echo "
Make sure to check for shared files and folders." >> ubuntu_notes.txt

#Audit Policies
apt update
apt install auditd
systemctl start auditd
systemctl enable auditd

#nginx and FTP Services
echo "
The output of the systemctl command that displays all of the unit files:" >> ubuntu_notes.txt
systemctl list-unit-files >> ubuntu_notes.txt
echo "
Use the systemctl stop and disable command to remove unwanted services." >> ubuntu_notes.txt

#Checking for unwanted file and folder permissions.
echo "
The output of the ls -alF command that displays read, write, and execute permission for the /etc directory." >> ubuntu_notes.txt
ls -alF /etc >> ubuntu_notes.txt
echo "
use the ls -l command to check other files and folders for unwanted permissions." >> ubuntu_notes.txt

#Configuring Account Lockout Policies
touch /usr/share/pam-configs/faillock
touch /usr/share/pam-configs/faillock_notify
echo "Input the required text into the faillock files under the /usr/share/pam-configs/ directory using the Battle Plan." >> ubuntu_notes.txt

#Configuring System Parameters
cp /etc/sysctl.conf /etc/sysctl.conf.backup
echo "Configure sytem parameters in the /etc/sysctl.conf file."

if  


