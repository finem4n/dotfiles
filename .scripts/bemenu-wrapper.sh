#!/usr/bin/env bash
# vim:foldmethod=marker
# fineman's script

source $HOME/.scripts/bemenu-opts.sh

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    exit
fi

# Cliphist isn't packaged for Fedora and I don't like putting executables in /usr/local/bin/ when I'm the only user
export PATH=$PATH:$HOME/git/swayapps/cliphist/v0-5-0/

# Check if bemenu is already running. If true then kill bemenu. (Toggle Bemenu)
if pgrep -x bemenu; then
	killall bemenu
else	
	if [ "$1" == "--drun" ]; then
		j4-dmenu-desktop --dmenu="bemenu" \
				--display-binary --term-mode kitty --no-generic --use-xdg-de --case-insensitive
	elif [ "$1" == "--cliphist" ]; then
		 cliphist list | bemenu --prompt "cliphist:" | cliphist decode | wl-copy
	fi
fi
