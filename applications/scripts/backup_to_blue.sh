#!/usr/bin/env bash

# First sync 2fa codes and delete them from source
echo "2FA Codes"
rsync --recursive --update --progress --remove-source-files $HOME/syncthing/fuckups/recovery_codes/ /run/media/fineman/kingslayer/2fa_codes/

# And do rest
echo "Small fuckups backups"
rsync --recursive --update --progress --delete $HOME/syncthing/fuckups/ /run/media/fineman/kingslayer/fuckups_smol/
