#!/usr/bin/env bash
clear

apt upgrade -y     # Upgrades installed packages to the latest version available
apt install -f -y  # Fixes broken dependencies
apt autoremove -y  # Remove unnecessary packages
apt clean -y       # Removes unnecessary package files to clean local repositories.
