#!/usr/bin/env bash
clear

# 1. #Remove unecessary packages from the system. Add and remove based on the machine.
apt purge -y snort nmap wireshark tcpdump netcat-openbsd netcat-traditional filezilla samba ophcrack hydra cups avahi-daemon telnet doona xprobe amule zangband

# 2. Update APT index
apt update

# 3. Fix any partially installed packages (if needed)
dpkg --configure -a

# 4. Perform a safe upgrade
apt upgrade -y

# 5. Install and enable unattended-upgrades
apt install -y unattended-upgrades 
systemctl enable --now unattended-upgrades

# 6. Clean up
apt autoremove -y   # removes obselete packages no longer needed
apt autoclean   # clears the apt cache

read -p "Updates run, unnecessary package(s) removed, and unattended-upgrades installed and enabled. Press Enter to continue..."


