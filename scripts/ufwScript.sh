#!/usr/bin/env bash
clear

# Installation of UFW
apt-get purge -y nftables 	# Removes nftables
apt-get install -y ufw
ufw reset			# Removes all rules
ufw default deny incoming 	# Blocks all incoming connections
ufw default allow outgoing	# Allows all outbound connections. Change to deny for more advanced competitions
ufw enable			# Enables the firewall
# write new rules if needed (allowing scoring engine)
ufw reload			# Loads new rules (if you wrote them above) 
ufw logging high		# logs all access attempts
apt-get autoremove
apt-get clean
