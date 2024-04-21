#!/bin/bash

_source="$HOME/.config"
_dest="$HOME/git/dotfiles/.config"

items=(
	"waybar"
)

for item in "${items[@]}"; do
	fileSource="$_source/$item"
	fileDest="$_dest/$item"
	cp -R $fileSource $fileDest
done
