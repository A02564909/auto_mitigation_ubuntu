#!/usr/bin/env bash
clear

# Initialize Password Expiration Period Rules variables
MAX=90
MIN=10
WARN=5

getent passwd | while IFS=: read user _ uid _ _ _ _; do
    # Check UID is non-empty and numeric
    if [ -n "$uid" ] && [[ "$uid" =~ ^[0-9]+$ ]] && [ "$uid" -ge 1000 ]; then
        
        # Extract password aging safely
        read -r max min warn <<< $(sudo chage -l "$user" | awk -F: '
            /Maximum number of days/ {gsub(/ /,"",$2); max=$2}
            /Minimum number of days/ {gsub(/ /,"",$2); min=$2}
            /Number of days of warning/ {gsub(/ /,"",$2); warn=$2}
            END {print max, min, warn}'
        )
        
        # Default to 0 if empty (prevents integer errors)
        max=${max:-0}
        min=${min:-0}
        warn=${warn:-0}

        # Compare against policy
        if [ "$max" -eq "$MAX" ] && [ "$min" -eq "$MIN" ] && [ "$warn" -eq "$WARN" ]; then
            echo "$user: OK"
        else
            echo "$user: NOT OK (max=$max, min=$min, warn=$warn)"
        fi
    fi
done
