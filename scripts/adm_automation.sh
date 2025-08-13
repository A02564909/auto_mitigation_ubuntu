#!/usr/bin/env bash

clear

# check if authAdmins file exists
if [[ ! -f authAdmins ]]; then
    echo "Error: authAdmins file not found!"
    exit 1
fi

# Get a list of system admins
sysAdmins=$(awk -F: '$1 == "adm" {
    n = split($4, users, ",");
    for (i=1; i<=n; i++) print users[i]
}' /etc/group
)

# Read authorized admins from file into array
mapfile -t admins < authAdmins

# Clear output files
> AddauthAdmins
> UnauthAdmins

#Add missing authorized admins
for admin in "${admins[@]}"; do
    if ! grep -qx "$admin" <<< "$sysAdmins"; then
        echo "Should add missing authorized admin: $admin" >> AddauthAdmins
    fi
done

# Remove unauthorized admins
while read -r sysAdmin; do
	keep=false
	for authAdmin in "${admins[@]}"; do
		if [[ "$sysAdmin" == "$authAdmin" ]]; then
			keep=true
			break
		fi
	done
	
	if [[ "$keep" == false ]]; then
		echo "$sysAdmin" >> UnauthAdmins
	fi
	
done <<< "$sysAdmins"

echo "System admins detected:"
printf "'%s'\n" $sysAdmins

echo "Authorized admins listed:"
printf "'%s'\n" "${admins[@]}"

read -p "Unauthorized users will appear in the UnauthAdmins file. Press Enter to exit."
