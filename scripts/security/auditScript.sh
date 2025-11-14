#!/usr/bin/env bash
clear


#Audit Policies
apt update
apt install auditd
systemctl start auditd
systemctl enable auditd

read -p "Audit policies installed and enabled. Press Enter to continuee..."
