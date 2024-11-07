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
echo"
Name: Enforce failed login attempt counter
Default: no
Priority: 0
Auth-Type: Primary
Auth:
  [default=die]  pam_faillock.so authfail
  sufficient  pam_faillock.so authsucc

" > /usr/share/pam-configs/faillock
touch /usr/share/pam-configs/faillock_notify
echo "
Name: Notify on failed login attempts
Default: no
Priority: 1024
Auth-Type: Primary
Auth:
       requisite  pam_faillock.so preauth
" > /usr/share/pam-configs/faillock_notify
pam-auth-update

#Configuring System Parameters
cp /etc/sysctl.conf /etc/sysctl.conf.backup
echo "
#
# /etc/sysctl.conf - Configuration file for setting system variables
# See /etc/sysctl.d/ for additional system variables.
# See sysctl.conf (5) for information.
#

#kernel.domainname = example.com

# Uncomment the following to stop low-level messages on console
#kernel.printk = 3 4 1 3

###################################################################
# Functions previously found in netbase
#

# Uncomment the next two lines to enable Spoof protection (reverse-path filter)
# Turn on Source Address Verification in all interfaces to
# prevent some spoofing attacks
#net.ipv4.conf.default.rp_filter=1
#net.ipv4.conf.all.rp_filter=1

# Uncomment the next line to enable TCP/IP SYN cookies
# See http://lwn.net/Articles/277146/
# Note: This may impact IPv6 TCP sessions too
net.ipv4.tcp_syncookies=1

# Uncomment the next line to enable packet forwarding for IPv4
net.ipv4.ip_forward=0

# Uncomment the next line to enable packet forwarding for IPv6
#  Enabling this option disables Stateless Address Autoconfiguration
#  based on Router Advertisements for this host
#net.ipv6.conf.all.forwarding=1


###################################################################
# Additional settings - these settings can improve the network
# security of the host and prevent against some network attacks
# including spoofing attacks and man in the middle attacks through
# redirection. Some network environments, however, require that these
# settings are disabled so review and enable them as needed.
#
# Do not accept ICMP redirects (prevent MITM attacks)
#net.ipv4.conf.all.accept_redirects = 0
#net.ipv6.conf.all.accept_redirects = 0
# _or_
# Accept ICMP redirects only for gateways listed in our default
# gateway list (enabled by default)
# net.ipv4.conf.all.secure_redirects = 1
#
# Do not send ICMP redirects (we are not a router)
#net.ipv4.conf.all.send_redirects = 0
#
# Do not accept IP source route packets (we are not a router)
#net.ipv4.conf.all.accept_source_route = 0
#net.ipv6.conf.all.accept_source_route = 0
#
# Log Martian Packets
#net.ipv4.conf.all.log_martians = 1
#

###################################################################
# Magic system request Key
# 0=disable, 1=enable all, >1 bitmask of sysrq functions
# See https://www.kernel.org/doc/html/latest/admin-guide/sysrq.html
# for what other values do
#kernel.sysrq=438
" > /etc/sysctl.conf



