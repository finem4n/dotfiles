#!/usr/bin/env bash
# fineman's config
# taken from Fedora Sway and their /usr/libexec/sway-systemd/session.sh
# Since session.sh fixed almost all my issues related to starting sway through GDM, I just did a little cleanup and added a few variables for my needs.

export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1

export GTK_THEME=Adwaita-dark

export QT_QPA_PLATFORM=wayland
export QT_STYLE_OVERRIDE=adwaita-dark
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"

export MOZ_ENABLE_WAYLAND=1

VARIABLES="DESKTOP_SESSION XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE"
VARIABLES="${VARIABLES} DISPLAY I3SOCK SWAYSOCK WAYLAND_DISPLAY"

VARIABLES="${VARIABLES} SDL_VIDEODRIVER _JAVA_AWT_WM_NONREPARENTING"

VARIABLES="${VARIABLES} GTK_THEME"

VARIABLES="${VARIABLES} QT_QPA_PLATFORM QT_STYLE_OVERRIDE QT_WAYLAND_DISABLE_WINDOWDECORATION"

VARIABLES="${VARIABLES} MOZ_ENABLE_WAYLAND"

VARIABLES="${VARIABLES} SDL_GAMECONTROLLERCONFIG"

SESSION_TARGET="sway-session.target"
SESSION_SHUTDOWN_TARGET="sway-session-shutdown.target"
WITH_CLEANUP=1

if systemctl --user -q is-active "$SESSION_TARGET"; then
    echo "Another session found; refusing to overwrite the variables"
    exit 1
fi

if hash dbus-update-activation-environment 2>/dev/null; then
    # shellcheck disable=SC2086
    dbus-update-activation-environment --systemd ${VARIABLES:- --all}
fi

systemctl --user reset-failed

# shellcheck disable=SC2086
systemctl --user import-environment $VARIABLES
systemctl --user start "$SESSION_TARGET"

if [ -z "$WITH_CLEANUP" ] ||
    [ -z "$SWAYSOCK" ] ||
    ! hash swaymsg 2>/dev/null
then
    exit 0;
fi

session_cleanup () {
    systemctl --user start --job-mode=replace-irreversibly "$SESSION_SHUTDOWN_TARGET"
    if [ -n "$VARIABLES" ]; then
        # shellcheck disable=SC2086
        systemctl --user unset-environment $VARIABLES
    fi
}
trap session_cleanup INT TERM
swaymsg -t subscribe '["shutdown"]'
session_cleanup
