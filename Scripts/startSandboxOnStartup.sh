#!/bin/bash

name="SARndbox"
command="./sandbox.sh"
resetCommand="./resetSandbox.sh"
attempts=5
delay=5

i=1
result=0

sleep $delay
while [ $i -le $attempts ]
do
    $resetCommand
    sleep 1
    $command &
    sleep $delay
    if result="$(xdotool search -name $name)"
    then
        result=1
        break
    else
	notify-send "$name" "$name failed to open, attempt $i of $attempts" -t 1000
        result=0
    fi
    i=$((i+1))
done

if [ $result -eq 0 ]
then
    notify-send "$name" "$name failed to open, consider restarting"
fi

read -n 1 -s -p "Press any key to close ..."
