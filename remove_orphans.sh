#!/bin/bash

# @Author : butch
# le but de ce programme est de faire des trucs cool


# variables :



# fonctions :
getorphans()
{
	echo "run deborphan"
	ORPHANS=$(deborphan)""
}




# MAIN
#echo "apt remove "$ORPHANS

getorphans


while (( $ORPHANS -ne "" )); do
	echo "remove orphans : "$ORPHANS
	apt remove $ORPHANS && echo "done"
	getorphans

done

echo "no more orphans"
exit 0
