 #!/bin/bash

SELFIP="$(ifconfig | grep inet | grep broadcast | cut -d " " -f 10)"
TARGETNETWORK="$(echo $SELFIP | sed 's:[^.]*$:0/24:')"

nmap_output=$(nethunter nmap -sn $TARGETNETWORK -oG - | grep Up | cut -d " " -f 2)

datetoday=$(date +"%d_%m_%Y")

read -p "How would you name this network? "  network_name

nethunter touch /tmp/live_hosts-$network_name-$datetoday 
nethunter echo $nmap_output |nethunter xargs -n 1 |nethunter tee /tmp/live_hosts-$network_name-$datetoday

