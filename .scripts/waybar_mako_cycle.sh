#!/usr/bin/env bash

# fineman's script
# Feel free to steal it

modes=("default" "dnd" "unmuted")
len_modes=$((${#modes[@]}-1))

current_mode=$(makoctl mode)

function modes_cycle () {
# ! gives an index of array
  for i in "${!modes[@]}"; do
    if [ "${modes[$i]}" == "$current_mode" ]; then 
      if [ $i -lt $len_modes ]; then
        current_mode="${modes[$i+1]}"
      elif [ $i -eq 2 ]; then
        current_mode="${modes[0]}"
      fi
    break
    fi
  done

  # set mako mode and echo current for waybar
  makoctl mode -s "$current_mode"
}

modes_cycle && pkill -RTMIN+11 waybar
