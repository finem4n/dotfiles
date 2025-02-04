#!/bin/bash

source $HOME/.scripts/bemenu-opts.sh

menu=$( echo -e "󱅞 Lock\n󰒲 Suspend\n󰍃 Logout\n󰜉 Reboot\n󰐥 Shutdown" | \
	bemenu --list 5 --prompt "What you wanna do?" | \
	awk '{print tolower($2)}' )

if pgrep -x bemenu; then
	killall bemenu
else	
	case $menu in 
		lock)
			hyprlock &>/dev/null
			;;
		suspend)
			systemctl suspend
			;;
		logout)
			swaymsg exit
			;;
		reboot)
			reboot
			;;
		shutdown)
			poweroff
			;;
	esac
fi
