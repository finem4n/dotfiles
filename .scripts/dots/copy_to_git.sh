#!/bin/bash

_source="$HOME/.config"
_dest="$(dirname "$0")/../../.config"

items=(
	"waybar"
	"sworkstyle"
)

for item in "${items[@]}"; do
	fileSource="$_source/$item/."
	fileDest="$_dest/$item/"
	cp -R $fileSource $fileDest
done
