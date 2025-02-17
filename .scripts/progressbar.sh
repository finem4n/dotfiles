#!/usr/bin/env bash
# fineman's script

# Arguments:
# first -- type of input
#	Possible types:
#	--volume
#	--volume-mute
#	--mic-volume
#	--mic-mute
#	--brightness
# second -- output name
#	This one I used to tell mako on what output progressbar must be displayed. I parse it as app_name via -a flag.

if [ "$#" -ne 1 ] && [ $# -ne 2 ]; then
    echo "Illegal number of parameters"
    exit
fi

notify_type="progressbar"
app_name="$2"

if [ "$app_name" ==  "" ]; then
	app_name="focused"
fi

if [ $1 = "--volume" ]; then
	muted=$(echo $(pactl get-sink-mute @DEFAULT_SINK@) | grep -oE 'yes|no')
	if [ $muted = "yes" ]; then
	name="Volume Muted"
	elif [ $muted = "no" ]; then
	name="Volume"
	fi
	value=$(echo $(pactl get-sink-volume @DEFAULT_SINK@) | grep -oP '/ \K[0-9.]+(?=% /)' | head -n1)

elif [ $1 = "--volume-mute" ]; then
	muted=$(echo $(pactl get-sink-mute @DEFAULT_SINK@) | grep -oE 'yes|no')
	if [ $muted = "yes" ]; then
		name="Muted"
		value=0
	elif [ $muted = "no" ]; then
		name="Volume Unmuted"
		value=$(echo $(pactl get-sink-volume @DEFAULT_SINK@) | grep -oP '/ \K[0-9.]+(?=% /)' | head -n1)
	fi

elif [ $1 = "--mic-volume" ]; then
	muted=$(echo $(pactl get-source-mute @DEFAULT_SOURCE@) | grep -oE 'yes|no')
	if [ $muted = "yes" ]; then
		name="Mic Muted"
	elif [ $muted = "no" ]; then
		name="Mic Unmuted"
	fi
	value=$(echo $(pactl get-source-volume @DEFAULT_SOURCE@) | grep -oP '/ \K[0-9.]+(?=% /)' | head -n1)

elif [ $1 = "--mic-mute" ]; then
	muted=$(echo $(pactl get-source-mute @DEFAULT_SOURCE@) | grep -oE 'yes|no')
	if [ $muted = "yes" ]; then
		name="Mic Muted"
		value=0
	elif [ $muted = "no" ]; then
		name="Mic Unmuted"
		value=$(echo $(pactl get-source-volume @DEFAULT_SOURCE@) | grep -oP '/ \K[0-9.]+(?=% /)' | head -n1)
	fi

elif [ $1 = "--brightness" ]; then
	name="Brightness"
	value=$(brightnessctl -m  | awk -F, '{print substr($4, 0, length($4)-1)}')
else
	echo "Check arguments"
	exit
fi

notify () {
	notify-send -a "$app_name" -e -h string:x-canonical-private-synchronous:${notify_type} \
		-t 1000 -h int:value:$2 "$1: $2%"
}

notify "$name" $value
