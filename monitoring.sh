#!/bin/bash

# Give access to ifconfig etc without sudo privileges 
export PATH=$PATH:/usr/sbin

# System architecture and kernel version
echo -ne '#ARCHITECTURE:\t\t\t'
uname -a

# Number of physical processors
echo -ne '#CPU PHYSICAL:\t\t\t'
grep processor /proc/cpuinfo | cut -d' ' -f2

# Number of virtual processors
echo -ne '#VCPU:\t\t\t\t'
lscpu | awk -F': +' '/^CPU\(s\)/ { print $2 }'

# RAM usage
echo -ne '#MEMORY USAGE:\t\t\t'
free | awk 'NR == 2 { \
	printf("%d/%dMB (%.2f%%)\n", $3/1000, $2/1000, ($3*100)/$2) \
}'

# Disk usage
echo -ne '#DISK USAGE:\t\t\t'
df / -hm | awk -F' +' 'NR==2 { \
	printf("%d/%dGB (%d%%)\n", $3, $2/1000, $5) \
}'

# CPU usage
echo -ne '#CPU LOAD:\t\t\t'
IDLE=$( top -bn 1 | awk -F', +' 'NR==3 {print $4}' )
if [[ $IDLE == *"wa" ]]
then
	echo "0.0%"
else
	IDLE=$( echo $IDLE | cut -d' ' -f1 )
	IDLE=$( bc -l <<<"100 - $IDLE" )
	echo "$IDLE%"
fi

# Last reboot datetime
echo -ne '#LAST BOOT:\t\t\t'
DATE=$(last reboot -Rx --time-format iso \
	| awk 'NR==2 { print $4 }' \
	| cut -d'T' -f1)
TIME=$(last reboot -Rx --time-format iso \
	| awk 'NR==2 { print $4 }' \
	| cut -d'T' -f2 \
	| cut -d'+' -f1)
echo "$DATE $TIME"

# LVM status
echo -ne '#LVM USE:\t\t\t'
LVM=$(lvm pvdisplay | awk 'NR==2 { print $1 }')
if [ $LVM = "PV" ]
then
	echo yes
else
	echo no
fi

# TCP active connections
echo -ne '#TCP CONNECTIONS:\t\t'
VAL=0
while read line
do	
	if [[ $line = *"ESTABLISHED"* ]]
	then
		((VAL++))
	fi
done < <(netstat -anp --tcp)
echo "$VAL ESTABLISHED"

# Number of users on the server
echo -ne '#USER LOG:\t\t\t'
cut -d: -f1,3 /etc/passwd | egrep ':[0-9]{4}$' | wc -l

# IPv4 and MAC address
echo -ne '#NETWORK:\t\t\t'
IP=$(ifconfig -a | awk 'NR==2 { print $2 }')
MAC=$(ifconfig -a | awk 'NR==4 { print $2 }')
echo "IP $IP ($MAC)"

# Number of commands executed by sudo
echo -ne '#SUDO\t\t\t\t'
CMD=$(grep COMMAND /var/log/sudo/sudo.log | wc -l);
echo "$CMD cmd"

#echo -e '\n=========================================================================\n'
