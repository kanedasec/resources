#!/bin/bash
report_path="/home/kali/resources/reports"

read -p "Who is the target? (name between single quotes, username, e-mail, ip, domain) " OSINT_TARGET
spiderfoot -q -u all -s $OSINT_TARGET | tee -a $report_path/Spiderfoot_Scan-$OSINT_TARGET-$(date +%Y_%m_%d)