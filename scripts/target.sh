 #!/bin/bash

report_path="/home/kali/resources/reports"

read -p "What is the IP of the target? " target_ip
printf "\n\n Scanning $target_ip\n\n"
nmap -sV --script vulners --script-args mincvss=7.0 -T5 --top-ports 1000 $target_ip |tee -a $report_path/Full_Scan-$target_ip-$(date +%Y_%m_%d)

