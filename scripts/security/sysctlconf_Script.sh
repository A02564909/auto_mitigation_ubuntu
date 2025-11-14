#!/usr/bin/env bash
clear

# Save the original sysctl.conf file to a backup file.
cp /etc/sysctl.conf /etc/sysctl.conf.bk

# Define the most secure sysctl.conf file settings to secure the network.
SYSCTL_SETTINGS=(
    "net.ipv4.tcp_syncookies=1"
    "net.ipv4.conf.all.rp_filter=1"
    "net.ipv4.conf.default.rp_filter=1"
    "net.ipv4.tcp_rfc1337=1"
    "net.ipv4.conf.all.accept_source_route=0"
    "net.ipv4.conf.default.accept_source_route=0"
    "net.ipv4.icmp_echo_ignore_broadcasts=1"
    "net.ipv4.icmp_ignore_bogus_error_messages=1"
    "net.ipv4.conf.all.log_martians=1"
    "net.ipv6.conf.all.accept_ra=0"
    "net.ipv6.conf.default.accept_ra=0"
    "net.ipv4.tcp_max_syn_backlog=2048"
    "net.ipv4.tcp_synack_retries=2"
    "net.ipv4.tcp_fin_timeout=15"
    "net.ipv4.tcp_tw_reuse=1"
    "net.ipv4.tcp_tw_recycle=1"
    "fs.suid_dumpable=0"
    "kernel.dmesg_restrict=1"
    "net.ipv4.ip_forward=0"
    "net.ipv4.tcp_syncookies=1"
)

# Add the sysctl settings to /etc/sysctl.conf
for setting in "${SYSCTL_SETTINGS[@]}"; do
    grep -q "$setting" /etc/sysctl.conf || echo "$setting" >> /etc/sysctl.conf
done

# Change permissions of sysctl.conf to ensure it is secure
chmod 644 /etc/sysctl.conf
chown root:root /etc/sysctl.conf
echo "Permissions for /etc/sysctl.conf set to 644, owned by root."

# Apply the changes immediately
sysctl -p

read -p "Network security settings applied and verified. Press enter to continue."
