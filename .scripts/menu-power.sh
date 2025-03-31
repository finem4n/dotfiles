#!/usr/bin/env bash

source $HOME/.scripts/bemenu-opts.sh

if pgrep -x bemenu; then
	killall bemenu
else	
	menu=$( echo -e "󱅞 Lock\n󰒲 Suspend\n󰍃 Logout\n󰜉 Reboot\n󰐥 Shutdown" | \
		bemenu --list 5 --fn 'JetBrains Mono 20' --line-height 55 --ch 40 --cw 3 --prompt "What you wanna do?" | \
		awk '{print tolower($2)}' )

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
			$HOME/git/swayapps/cliphist/v0-5-0/cliphist wipe
			reboot
			;;
		shutdown)
			$HOME/git/swayapps/cliphist/v0-5-0/cliphist wipe
			poweroff
			;;
	esac
fi
