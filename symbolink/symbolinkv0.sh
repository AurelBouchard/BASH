#!/bin/bash

# @Author : butch
# le but de ce programme est de faire des trucs cool


############ XDOTOOL !!!!!!!
# pour envoyer ctrl shift c (copie du lien complet dans PCmanFM-Qt)
xdotool key ctrl+shift+c

# récupération du presse-papier :
FILE="$( xsel -b)"

# extraction du nom de dossier
DIR=$( dirname "$FILE" )

# GUI : confirmation
zenity --question --title="Créer un lien symbolique" --no-wrap --text="Voulez-vous créer un lien symbolique pour le fichier :

$FILE ?

Il sera placé ici : $DIR
" || exit 0

# création du lien :
ln -s $"$FILE" $"$DIR/raccourci"

