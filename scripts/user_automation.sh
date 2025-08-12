#!/usr/bin/env bash
clear

# Get a list of system users with UID between 1000 and 65533
sysUsers=$(awk -F: '$3 >=1000 && $3 <= 65533 {print $1}' /etc/passwd)

# Read authorized users from file into array
mapfile -t users < authUsers # Ensure this file exists

# Backup the original password file.
cp /etc/passwd /etc/passwd.bk

# Add missing authorized users
for user in "${users[@]}"; do
	if ! echo "$sysUsers" | grep -q "^$user$"; then
		useradd -m "$user"
	fi
done

# Remove unauthorized users
echo "$sysUsers" | while read -r sysUser; do
	for authUser in "${users[0]}"; do
 		keep=false
		if [[ "$sysUser" == "$authUser" ]]; then
			keep=true
			break
		fi
	done
 
	if [[ "$keep" == false ]]; then
		echo "$sysUser" >> UnauthUsers
  	fi
done

read -p " Unauthorized user will appear in the Unauth file."




