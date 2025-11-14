#!/usr/bin/env bash
clear 

sed -i.bk 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS 10/' /etc/login.defs
sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS 60/' /etc/login.defs
sed -i 's/^PASS_WARN_AGE.*/PASS_WARN_AGE 5/' /etc/login.defs

read -p "Password Expiration configured. Press Enter to continue...."
