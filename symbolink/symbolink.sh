#!/bin/bash

# @Author : butch
# le but de ce programme est de faire des trucs cool


############ XDOTOOL !!!!!!!
# pour envoyer "ctrl+shift+c" (= copie du lien complet dans PCmanFM-Qt)
xdotool key ctrl+shift+c

# récupération du presse-papier :
FILE="$( xsel -b )"

# création direct du lien :
ln -s $"$FILE" $"$FILE-rac"

# nettoyage du clipboard :
xsel -i -b -z
exit 0
