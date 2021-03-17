#!/bin/bash
if [ $# != 2 ]; then
	echo "nombre invalide d'arguments, donner les bornes.";
	echo "par ex ./testIP.sh 10 30 fera un ping de 192.168.0.10 à 192.168.0.30";
	exit
else

	if [ $1 -lt $2 ] ; then
		mini=$1
		maxi=$2
	else
		mini=$2
		maxi=$1
	fi

	i=$mini
	while (( $i < $maxi )); do
		ping -c 1 -W 1 192.168.0.${i} -q

		if [ ${?} = 0 ]; then
			echo " "
			echo " "
			echo " "
			echo " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  192.168.0.$i répond correctement au ping"
			sleep 10
			clear;
		else clear;
		fi
		
	i=$((i+1));
	done

fi
