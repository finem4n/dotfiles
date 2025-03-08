#!/bin/bash 
# fineman's script

url="$1"

# via xdg-open
# xdg-open "$url"

# Activity Manager - am command
nohup am start --user 0 -a android.intent.action.VIEW -d "$1" >/dev/null 2>&1 &

# or you can also specify browser by appending -n com.package.name/.ActivityName
# nohup am start --user 0 -a android.intent.action.VIEW -d "$1" -n org.mozilla.fennec_fdroid/org.mozilla.gecko.LauncherActivity >/dev/null 2>&1 &
