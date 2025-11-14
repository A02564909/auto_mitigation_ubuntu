#!/usr/bin/env bash
clear

apt update
apt full-upgrade -y # Upgrades packages and Installs new dependencies
apt autoremove -y  # Remove unnecessary packages
apt clean -y       # Removes unnecessary package files to clean local repositories.
#apt install -f -y  # Fixes broken dependencies--use only if indicated by errors.

read -p "Updates were run--restart may be necessary. Press enter to continue."
