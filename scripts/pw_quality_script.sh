#!/usr/bin/env bash
clear

#Copy the original of the soon-to-be edited files to a backup file.
cp /etc/pam.d/common-auth /etc/pam.d/common-auth.bk
cp /etc/pam.d/common-password /etc/pam.d/common-password.bk
cp /etc/pam.d/common-session /etc/pam.d/common-session.bk
cp /etc/security/pwquality.conf /etc/security/pwquality.conf.bk

# Define file paths for PAM and related configuration files
common_auth="/etc/pam.d/common-auth"
common_password="/etc/pam.d/common-password"
common_session="/etc/pam.d/common-session"
pwquality_conf="/etc/security/pwquality.conf"

# Securing common-auth file (remove nullok, add deny 5 and unlock_time 900)
sed -i 's/auth.*required.*pam_unix.so//' $common_auth
sed -i '/^auth.*required.*pam_unix.so/ s/$/ auth required pam_unix.so deny=5 unlock_time=900/' $common_auth

# Securing common-password file (set retry, minlen, and credit values)
sed -i 's/^password.*pam_unix.so.*/password [success=1 default=ignore] pam_unix.so retry=4 minlen=10 difok=4 ucredit=2 lcredit=2 dcredit=1 ocredit=1 reject_username enforce_for_root/' $common_password

# Securing common-session file (add session required pam_unix.so)
sed -i 's/^session.*required.*pam_unix.so.*/session required pam_unix.so/' $common_session

# Securing pwquality.conf file (set password complexity and enforce root)
echo "minlen = 14" > $pwquality_conf
echo "minclass = 4" >> $pwquality_conf
echo "ucredit = -1" >> $pwquality_conf
echo "lcredit = -1" >> $pwquality_conf
echo "dcredit = -1" >> $pwquality_conf
echo "ocredit = -1" >> $pwquality_conf
echo "difok = 5" >> $pwquality_conf
echo "dictcheck = 1" >> $pwquality_conf

# Set correct permissions and ownership for all files
chmod 644 $common_auth $common_password $common_account $common_session $pwquality_conf
chown root:root $common_auth $common_password $common_account $common_session $pwquality_conf

read -p "PAM configuration files secured. Press any key to continue..."
