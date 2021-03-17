#!/bin/bash

# le but de ce programme est de fournir l'IP
# donnée à une adresse MAC par la freebox cristal
# cette donnée est accessible dans le fichier txt :
# http://192.168.0.254/pub/fbx_info.txt
# dans le paragraphe "Attributions dhcp"


# dossier cible :
MAC_TAB="http://192.168.0.254/pub/fbx_info.txt"

file=$(wget $MAC_TAB -q -O -)

lookfor=$1"      192.168.0."

if [ $# != 1 ]; then
	echo "nombre invalide d'arguments : fournir une adresse MAC ";
	echo "par ex: IPfromMAC BC:5F:F4:65:19:E8";
	exit
else

# ces 2 lignes affichent correctement la ligne avec MAC et IP :
#printf '%s\n' "$file" | grep -o "\<$lookfor[^[:blank:]]*"
#echo "$file" | grep -o "\<$lookfor[^[:blank:]]*"

line=$(echo "$file" | grep -o "\<$lookfor[^[:blank:]]*")

echo $line

IP=$(echo "$line" | grep -o "\<192[^[:blank:]]*")

echo $IP


fi

















