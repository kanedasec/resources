 #!/bin/bash

SELFIP="$(ifconfig | grep inet | grep broadcast | cut -d " " -f 10)"
TARGETNETWORK="$(echo $SELFIP | sed 's:[^.]*$:0/24:')"
report_path="/home/kali/resources/reports"

nmap_output=$(nmap -sn $TARGETNETWORK -oG - | grep Up | cut -d " " -f 2)

datetoday=$(date +"%d_%m_%Y")

read -p "How would you name this network? "  network_name

touch /tmp/live_hosts-$network_name-$datetoday 
echo $nmap_output | xargs -n 1 | tee $report_path/live_hosts-$network_name-$datetoday

