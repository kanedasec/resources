 #!/bin/bash

SELFIP="$(ifconfig | grep inet | grep broadcast | cut -d " " -f 10)"
TARGETNETWORK="$(echo $SELFIP | sed 's:[^.]*$:0/24:')"
report_path = "./fuktermux/resources/reports"

#check for live hosts and save it in a file
live_output=$(nmap -n -sn $TARGETNETWORK -oG - | grep Up | cut -d " " -f 2)
touch /tmp/tmp_live-hosts.txt 
echo $live_output |xargs -n 1 |tee /tmp/tmp_live-hosts.txt

#scan the hosts enumerated above and save the results in a file
read -p "How would you name this network? " network_name
while read -r live_host
do printf "\n\n Scanning $live_host\n\n"
nmap -sV --script vulners --script-args mincvss=7.0 -T5 --top-ports 1000 $live_host |tee -a $report_path/Full_Scan-$network_name-$(date +%Y_%m_%d)
done < /tmp/tmp_live-hosts.txt

rm /tmp/tmp_live-hosts.txt

