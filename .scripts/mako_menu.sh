#!/usr/bin/env bash

source $HOME/.scripts/bemenu-opts.sh

function main () {
    mode="("$(makoctl mode)"):"
    op=$( echo -e "󱈸 Actions\n Dismiss all\n Restore\n󱨩 Mode switch" | bemenu -i -l 4 --prompt "${mode}" --fn 'JetBrainsMono Nerd Font 20' --line-height 55 --ch 40 --cw 3 | awk '{print tolower($2)}' )

    case $op in 
        actions)
            makoctl menu bemenu -l 4 --prompt 'Choose Action: ' --fn 'JetBrainsMono Nerd Font 20' --line-height 55 --ch 40 --cw 3 
            main
            ;;
        dismiss)
            makoctl dismiss -a
            ;;
        restore)
            makoctl restore
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
                echo $op
                    ;;
            dnd)
                makoctl mode -s dnd && pkill -RTMIN+11 waybar
                echo $op
                    ;;
            unmuted)
                makoctl mode -s unmuted && pkill -RTMIN+11 waybar
                echo $op
    esac
}

if pgrep -x bemenu; then
    killall bemenu
else
    main
fi
