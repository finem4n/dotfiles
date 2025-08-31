#!/usr/bin/env bash

# TODO Add cargo
GREEN='\033[0;32m'
DEFAULT_COL='\033[0m'

echo_info () {
  echo -e "${GREEN}$1${DEFAULT_COL}"
}

function omz_custom_plugins {
  echo "Git pulling custom Oh My Zsh plugins"
  echo ""
  for i in $ZSH/custom/plugins/*/.git; do
    working_dir_path="$(dirname $i)"
    working_dir=$(echo $working_dir_path | rev | cut -d'/' -f1 | rev)
    echo_info "  pulling $working_dir in $working_dir_path"
    git -C "$working_dir_path" pull
  done
  echo ""
  echo_info "Finished pulling omz custom plugins"
  echo ""
}

up_the_bingo_date () {
  echo_info "Updating go packages"
  echo_info "Updating cliphist"
  go install go.senan.xyz/cliphist@latest
  echo_info "Finished updating go packages"
}

omz_custom_plugins
up_the_bingo_date
