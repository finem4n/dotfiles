#!/usr/bin/env bash

source $HOME/.scripts/bemenu-opts.sh

function main () {
    mode="("$(makoctl mode)"):"
    op=$( echo -e "󱈸 Actions\n Restore\n Dismiss all\n󱨩 Mode switch" | bemenu -i -I $1 -l 4 --prompt "${mode}" --fn 'JetBrainsMono Nerd Font 20' --line-height 55 --ch 40 --cw 3 | awk '{print tolower($2)}' )

    case $op in 
        actions)
            makoctl menu bemenu -l 4 --prompt 'Choose Action: ' --fn 'JetBrainsMono Nerd Font 20' --line-height 55 --ch 40 --cw 3 
            main 0
            ;;
        restore)
            makoctl restore
            main 1
            ;;
        dismiss)
            makoctl dismiss -a
            main 2
            ;;
        mode)
            mode_switch
            ;;
    esac
}

function mode_switch () {
    mode="("$(makoctl mode)"):"
    op=$( echo -e "󰂚 Default\n󰂛 DND\n󰂞 Unmuted" | bemenu -i -l 3 --prompt "${mode}" --fn 'JetBrainsMono Nerd Font 20' --line-height 55 --ch 40 --cw 3 | awk '{print tolower($2)}' )

    case $op in 
        default)
            makoctl mode -s default && pkill -RTMIN+11 waybar
            ;;
        dnd)
            makoctl mode -s dnd && pkill -RTMIN+11 waybar
            ;;
        unmuted)
            makoctl mode -s unmuted && pkill -RTMIN+11 waybar
            ;;
    esac
}

if pgrep -x bemenu; then
    killall bemenu
elif [ "$1" == "--actions" ]; then
    makoctl menu bemenu -l 4 --prompt 'Choose Action: ' --fn 'JetBrainsMono Nerd Font 20' --line-height 55 --ch 40 --cw 3 
else
    main 0
fi
