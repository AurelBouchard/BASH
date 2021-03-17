#!/bin/bash

# le but de ce programme est de detecter sur quel port usb
# est connecte le capteur de
# temperature associe au ventilo du processeur
# dossierc cible : /sys/class/hwmon

# dossier cible :
ADRR=/sys/class/hwmon/

# fichier de controle
FANCTRL=/etc/fancontrol


val=0
for i in `seq 0 10`; do
	FILE=$ADRR"hwmon"$(($i))"/temp2_input"
	if [[ -f "$FILE" ]]; then		# recheche de la position du fichier de température
	#    echo "$FILE exists.";
	    SENSOR=$ADRR"hwmon"$(($i))"/temp2_input"
	    break
	fi

done

echo $SENSOR

