 #!/bin/bash

SELFIP="$(ifconfig | grep inet | grep broadcast | cut -d " " -f 10)"
TARGETNETWORK="$(echo $SELFIP | sed 's:[^.]*$:0/24:')"

live_output=$(nethunter nmap -n -sn $TARGETNETWORK -oG - | grep Up | cut -d " " -f 2)

report_path = "./fuktermux/resources/reports"


nethunter touch /tmp/tmp_live-hosts.txt 
nethunter echo $live_output |nethunter xargs -n 1 |nethunter tee /tmp/tmp_live-hosts.txt

echo 'read -p "How would you name this network? "  network_name; while read -r live_host; do printf "\n\n Scanning $live_host\n\n"; nmap -sV --script vulners --script-args mincvss=7.0 -T5 --top-ports 1000 $live_host |tee -a /tmp/Full_Scan-$network_name-$(date +%Y_%m_%d); done < /tmp/tmp_live-hosts.txt' | nethunter tee /tmp/tmp_while-loop.txt

nethunter -r chmod +x /tmp/tmp_while-loop.txt

nethunter /tmp/tmp_while-loop.txt


nethunter rm /tmp/tmp_live-hosts.txt
nethunter rm /tmp/tmp_while-loop.txt
