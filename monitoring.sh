#!/bin/bash

architecture=$(uname -a)

physical_cpu=$(grep 'physical id' /proc/cpuinfo | uniq | wc -l)
virtual_cpu=$(grep processor /proc/cpuinfo | uniq | wc -l)

memory_used=$(free -h | grep Mem | awk '{print $3}')
memory_total=$(free -h | grep Mem | awk '{print $2}')
memory_percentage=$(free -k | grep Mem | awk '{printf("%.2f%%"), $3 / $2 * 100}')

disk_used=$(df -h --total | grep total | awk '{print $3}')
disk_total=$(df -h --total | grep total | awk '{print $2}')
disk_percentage=$(df -k --total | grep total | awk '{print $5}')

cpu_load=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')

last_boot=$(who -b | awk '{print($3 " " $4)}')

if [ $(lsblk | grep lvm | wc -l) -eq 0 ]; then
    lvm_use="no"
else
    lvm_use="yes"
fi

connections=$(grep TCP /proc/net/sockstat | awk '{print $3}')

users=$(who | wc -l)

ip=$(hostname -I | awk '{print $1}')
mac=$(ip link show | grep link/ether | awk '{print $2}')

sudo_commands=$(grep COMMAND /var/log/sudo/sudo.log | wc -l)

echo "
	#Architecture: $architecture
	#CPU physical : $physical_cpu
	#vCPU : $virtual_cpu
	#Memory Usage: $memory_used/$memory_total ($memory_percentage)
	#Disk Usage: $disk_used/$disk_total ($disk_percentage)
	#CPU load: $cpu_load
	#Last boot: $last_boot
	#LVM use: $lvm_use
	#Connections TCP : $connections ESTABLISHED
	#User log: $users
	#Network: IP $ip ($mac)
	#Sudo : $sudo_commands cmd
"
