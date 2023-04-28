#!bin/bash

BOOT_MIN=$(uptime -s | cut -d ":" -f 2)
BOOT_SEC=$(uptime -s | cut -d ":" -f 3)

DELAY=$(bc <<< $BOOT_MIN%10*60+$BOOT_SEC) #Vous devez installer la commande bc"sudo apt install bc"

# Attendre ce nombre de minutes
sleep $DELAY
