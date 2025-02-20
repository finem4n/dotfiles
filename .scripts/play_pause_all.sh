#!/usr/bin/env bash

playing=$(playerctl -a status | grep -c Playing)

function pause_and_remember () {
	last_player=$(playerctl status -a --format "{{status}}{{playerName}}" | grep Playing | sed 's/Playing//' | head -n 1)
	playerctl pause --ignore-player=$last_player --all-players
	playerctl pause --player=$last_player
}

if [ "$#" -eq 0 ]; then
	if [ $playing -eq 0 ]; then
		playerctl play --player=playerctld
	else
		pause_and_remember
	fi
elif [ "$1" == "--pnr" ]; then
	pause_and_remember
fi
