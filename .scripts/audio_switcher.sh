#!/usr/bin/env bash
# vim:foldmethod=marker
# dmenu pipewire audio switcher by Konrad Marciniak aka fineman

source ~/.scripts/bemenu-opts.sh

if pgrep -x bemenu; then
	killall bemenu
else	
	pactl_output=$(pactl list sinks)
	sinks=$(echo "$pactl_output" | grep "Sink #")

	opt_sink=()
	opt_port=()
	options_strings=()
	dmenu_strings=()

	index=0
	# NOTE  I don't really understand it, but bash executes while loops in sub-shells. Because of that variables chagnes aren't saved. 
	while IFS= read -r sink; do
		sink_num=$(echo "$sink" | sed 's/Sink #//')
		sink_block="$(echo "$pactl_output" | awk "/$sink/{flag=1;next}/Active Port:/{flag=0}flag" )"
		description="$(echo "$sink_block" | grep "Description:" | sed 's/Description: //' | sed 's/^[ \t]*//')"
		sink_ports="$(echo "$sink_block" | awk "/Ports:/{flag=1;next}flag" | sed 's/:.*//' | sed 's/^[ \t]*//')"
			while IFS= read -r port; do
				index=$((index+1))
				opt_sink+=("$sink_num")
				opt_port+=("$port")
				options_strings+=("$sink_num '$port'")
				dmenu_strings+=("[[ $index ]] $port >>> $description")
			done <<< "$sink_ports"
	done <<< "$sinks"

	out_num=$(printf '%s\n' "${dmenu_strings[@]}" | bemenu --list ${#dmenu_strings[@]} --prompt 'Audio Outputs:' | sed -n 's/.*\[\[ \(.*\) \]\].*/\1/p')
	if [ ! -n "$out_num" ]; then
		exit 1
	fi

	out_num=$((out_num-1))

	pactl set-default-sink "${opt_sink[$out_num]}"
	pactl set-sink-port "${opt_sink[$out_num]}" "${opt_port[$out_num]}"
fi
