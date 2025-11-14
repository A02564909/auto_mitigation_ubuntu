#!/usr/bin/env bash
clear

# Read usernames from needfix.txt into an array
mapfile -t users < needfix.txt

for user in "${users[@]}"; do
	if id "$user" &>/dev/null; then
	
        	sudo chage -M 90 -m 10 -W 5 "$user"
        	echo "Updated password max days for $user"
   	 else	
        	echo "User $user not found, skipping"
    	fi
done

read -p "Uncompliant users fixed. Press enter to continue."
