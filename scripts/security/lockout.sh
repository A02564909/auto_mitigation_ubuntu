#!/usr/bin/env bash
clear 

# Creates and configures an account lockout policy.

touch /usr/share/pam-configs/faillock
cp /usr/share/pam-configs/faillock /usr/share/pam-configs/faillock.bk

sudo tee /usr/share/pam-configs/faillock > /dev/null << EOL
Name: Enforce failed login attempt counter
Default: no
Priority: 0
Auth-Type: Primary
Auth:
	[default=die]  pam_faillock.so authfail
	sufficient  pam_faillock.so authsucc

EOL

touch /usr/share/pam-configs/faillock_reset
cp /usr/share/pam-configs/faillock_reset /usr/share/pam-configs/faillock_reset.bk

sudo tee /usr/share/pam-configs/faillock_reset > /dev/null << EOL
Name: Notify on account lockout
Default: no
Priority: 1024 Auth-
Type: Primary Auth:
requisite pam_faillock.so preauth
EOL

touch /usr/share/pam-configs/faillock_notify
cp /usr/share/pam-configs/faillock_notify /usr/share/pam-configs/faillock_notify.bk

sudo tee /usr/share/pam-configs/faillock_notify > /dev/null << EOL
Name: Notify on account lockout
Default: no
Priority: 1024 Auth-
Type: Primary Auth:
requisite pam_faillock.so preauth
EOL

pam-auth-update
