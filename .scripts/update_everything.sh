#!/usr/bin/env bash

# TODO add colors
# TODO learn to better format outputs

function omz_custom_plugins {
	echo "Git pulling custom Oh My Zsh plugins"
	echo ""
	for i in $HOME/.oh-my-zsh/custom/plugins/*/.git; do
		working_dir_path="$(dirname $i)"
		working_dir=$(echo $working_dir_path | rev | cut -d'/' -f1 | rev)
		echo "	pulling $working_dir in $working_dir_path"
		git -C "$working_dir_path" pull
	done
	echo ""
	echo "Finished pulling omz custom plugins"
	echo ""
}

omz_custom_plugins