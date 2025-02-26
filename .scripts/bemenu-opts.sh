#!/usr/bin/env bash

# styling explanation
# --bdr border color
# --tb prompt background color
# --tf prompt font color
# --fb search background color
# --ff search font color
# --cb i have no idea
# --cf cursor color; vertical line in insert mode
# --nb alternating 'button' background; odd index
# --nf alternating 'button' font; odd index
# --hb highlighted background
# --hf highlighted font
# --fbb I fucking do not know
# --fbf the same as above
# --sb selected background
# --sf selected font color
# --ab alternating 'button' background; even index
# --af alternating 'button' font; even index
# --scb scrollbar background
# --scf scrollbar button (?)
#
# you can add transparency by adding two more values in hex 

export BEMENU_OPTS="--ignorecase \
		--list 25 \
		--prefix '>>>' \
		--prompt 'Apps:' \
		--no-spacing \
		--wrap \
		--fixed-height \
		--accept-single \
		--binding vim \
		--scrollbar autohide \
		--vim-esc-exits \
		--center \
		--grab \
		--border 2 \
		--line-height 20 \
		--ch 20 \
		--cw 2 \
		--monitor -1 \
		--no-overlap \
		--margin 0 \
		--width-factor 0.4 \
		--bdr '#e78a4e' \
		--tb '#282828' \
		--tf '#d4be98' \
		--fb '#282828' \
		--ff '#d4be98' \
		--cb '#e78a4e' \
		--cf '#d4be98' \
		--nb '#282828' \
		--nf '#d4be98' \
		--hb '#3b4439' \
		--hf '#d4be98' \
		--fbb '#ffffff' \
		--fbf '#000000' \
		--sb '#e78a4e' \
		--sf '#282828' \
		--ab '#32302f' \
		--af '#d4be98' \
		--scb '#1b1b1b' \
		--scf '#504945' \
		--fn 'JetBrainsMono Nerd Font 12' "
