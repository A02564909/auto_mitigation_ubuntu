awk -F: '$3 >=1000 && $3 <= 65533 {print $1}' /etc/passwd >> authUsers # lists the user accounts and their UID's and outputs them into the authUsers file.
# 1 through 999 = package account and not a user

