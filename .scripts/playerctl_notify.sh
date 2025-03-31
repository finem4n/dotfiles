#!/usr/bin/env bash
# inspired by https://old.reddit.com/r/commandline/comments/16hdobx/how_to_get_notifications_when_changing_songs_on/ 

sleep 0.5
player_status=$(playerctl status)

if [ "$player_status" = "Playing" ] || [ "$player_status" = "Paused" ];
then
	player=$(playerctl metadata --format "{{playerName}}")
	title=$(playerctl metadata title)
	artist=$(playerctl metadata --format "{{ artist }}")
	
	notify-send -a focused -t 1000 -h string:x-canonical-private-synchronous:"playerctl_notify" "$player_status on $player" "$title\n$artist"
fi

