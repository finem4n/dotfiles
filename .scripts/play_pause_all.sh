#!/usr/bin/env bash

playing=$(playerctl -a status | grep -c Playing)
if [ $playing -eq 0 ]; then
	playerctl play --player=playerctld
else
	last_player=$(playerctl status -a --format "{{status}}{{playerName}}" | grep Playing | sed 's/Playing//' | head -n 1)
	playerctl pause --ignore-player=$last_player --all-players
	playerctl pause --player=$last_player
fi
