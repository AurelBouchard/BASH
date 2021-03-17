#!/bin/bash

#exit 0

#xdotool key F4 &

pid=$$

#prev=$((-1))


prev=$(($pid-1))
echoprev=$prev

sleep 1

echo "---" >> ~/test.log
echo "new launch of test. PID = "$! >> ~/test.log

xdotool key Return

last=$!


# GUI : arrêter
zenity --warning --title="Arrêter" --no-wrap --text="Cliquer pour arrêter le test
current $$
launch $!
prev $echoprev
last $last
pid $pid
" && kill $$

sleep 10

echo "il reste du code"
