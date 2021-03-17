#!/bin/bash

# doit etre executer par pcmanfmqt
xdotool key F4

sleep 1

#xdotool type 'nohup simpleserver >> ~/.simpleserver.log' # && sleep 5 & exit'
xdotool type 'simpleserver' # && sleep 5 & exit'
xdotool key Return

