#!/bin/bash


# definitions à modifier si nécessaire
#iface=eth0
AVAIL_PORT_INT=("40040" "40030" "40050" "40060" "40070")	# liste des ports interne perso
ALTER_PORT_INT=("8000" "8001" "8002" "8003" "8004")	# 8000 utilisé par defaut par SimpleHTTPServer

PORT_EXT="8000"	# 8000 par défaut

# version box
box=no
box=freebox
#box=bbox
#box=livebox


echo "simple server v3, box : "$box

getIPonline ()
{
	echo "check IP online ..."
	# methode check sur le web :
	IP_EXT=$(wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d' ' -f 2 | cut -d\< -f 1)
}

function valid_ip() # By Mitch Frazier @ Emerson Electric as embedded systems programmer ^^
# Test an IP address for validity:
# Usage:
#      valid_ip IP_ADDRESS
#      if [[ $? -eq 0 ]]; then echo good; else echo bad; fi
#   OR
#      if valid_ip IP_ADDRESS; then echo good; else echo bad; fi
#
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}



# pour le journal de log
echo "------- STARTING SIMPLESERVER, PID = $$ --------"


# lecture d'option'
# 0 ou 1 option possible : -noweb
noweb=false #par defaut
if [ $# -gt 0 ]; then
	param=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	if [[ "$param" == "-noweb" ]]; then
		echo "try no web if possible"
		noweb=true
	else
		echo "try lan + web"
	fi
fi


# adresse IP locale
echo "check local IP with iface"
IP_LOCAL=$(ifconfig $iface | awk '/inet/{gsub(" *inet addr:","");print $2; exit}')


# mise à zero des variables déterminées en suivant
IP_EXT=""
PORT_INT=""
#PORT_EXT=""


# lecture des données fournies par la Freebox :
if [[ box -eq freebox ]]; then
	echo "check Freebox ..."
	MAC_TAB="http://192.168.0.254/pub/fbx_info.txt"

	# maj IP externe
	lookfor="Adresse IP                     " # ne pas enlever les espaces

	file=$(wget $MAC_TAB -q -O -)

	line=$(echo "$file" | grep -o "\<$lookfor[^[:blank:]]*")

	IP_EXT=$(echo $line | sed 's/Adresse IP //')

	valid_ip $IP_EXT
	if [[ $? -eq 0 ]]; then
		echo "public IP looks ok : "$IP_EXT
	else
		getIPonline
		valid_ip $IP_EXT
		if [[ $? -eq 0 ]]; then
			echo "IP found over the web : "$IP_EXT
		else
			echo "No IP found over the web"
		fi
	fi

	# redirection de port
	if [[ "$noweb" -eq false ]]; then
		echo "check redirection de port ..."

		for i in ${AVAIL_PORT_INT[*]}; do # * ou @
			echo "test du port "$i
			if nc -z -w2 localhost $i ; then
				echo "next"
			else
				echo "attribution du port"
				PORT_INT=$i
				break
			fi
		done

		if [[ "$PORT_INT" -eq "" ]]; then
			echo "pas de redirection disponible"
			noweb=true
		else

			echo "port interne sélectionné : "$PORT_INT

			lookfor=$PORT_INT
			line=$(echo "$file" | grep -o ".*$lookfor")
			echo "parametres trouvés :"
			echo $line
			if [ "$line" != "" ]; then
				PROTOCOL=$(echo "$line" | grep -o "TCP")
				if [ $PROTOCOL != "TCP" ]; then
					echo "La redirection doit être TCP"
					IP_EXT=""
					PORT_EXT=""
				else
					echo "maj de ip local et port ext"
					IP_LOCAL=$(echo "$line" | awk '{print $3}')
					echo $IP_LOCAL
					PORT_EXT=$(echo "$line" | awk '{print $2}')
					echo $PORT_EXT
				fi
			else

			echo "pas de redirection prévue dans la box"
				IP_EXT=""
				PORT_EXT=""
				noweb=true
			fi
		fi
	#else # si noweb
	fi # end of redirection de port




fi # end of if freebox



DIR="$PWD"
echo "dossier : "$DIR


# GUI : confirmation
zenity --question --title="Mise en ligne" --no-wrap --text="Le répertoire :
$DIR
sera accessible en local à l'adresse :
$IP_LOCAL:$PORT_INT

et sur le web à l'adresse :
$IP_EXT:$PORT_EXT

Continuer ?" --ok-label="Oui" --cancel-label="Non"

if [[ $? -eq 1 ]] ; then
	echo "abandon du "$$
	exit 0
else
	echo "confirmation par user"
sleep 1
	# mise en route du serveur
	nohup python -m SimpleHTTPServer $PORT_INT >> /dev/null & serv=$! # NE PAS MODIFIER LA METHODE blabla & tutu !
	echo "PID du serveur python : "$serv

fi

# GUI : arrêter
echo "invite pour extinction (fenêtre zenity)"
nohup zenity --warning --title="Arrêter" --no-wrap --ok-label="Arrêter" --text="Cliquer pour arrêter le serveur
sur le port $PORT_INT
($DIR)" >> /dev/null && echo "serveur $serv arrêté par l'utilisateur" && kill $serv

exit 0
