#!/bin/bash

# doit etre executer par pcmanfmqt

sleep 0.2

xdotool key ctrl+shift+c
sleep 0.2

#JAVAFILE=$( xsel -b) # ok
#echo $JAVAFILE # ok

xdotool key F4
sleep 0.5


xdotool type 'cd ..'

xdotool key Return

xdotool type 'javamake $(echo $(xsel -b))'

xdotool key Return
