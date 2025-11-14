#!/usr/bin/env bash
clear

# Read usernames from needfix.txt into an array
mapfile -t users < needfix.txt

for user in "${users[@]}"; do
	if id "$user" &>/dev/null; then # Check if user id is valid--"&>dev/null" prevents every single user's id from printing on output.
			# Fix password expiration periods
        	sudo chage -M 90 -m 10 -W 5 "$user"
        	echo "Updated password max days for $user"
   	 else	
        	echo "User $user not found, skipping" # Prints if user ID is not found.
    	fi
done

read -p "Uncompliant users fixed. Press enter to continue."
