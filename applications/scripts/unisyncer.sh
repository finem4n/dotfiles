#!/usr/bin/env bash

BBQ5="/dev/disk/by-id/usb-RIM_SD_BDF232A67834FCE4687564C9E9FF97191768B6B8-0:0-part1"
KINDLE="/dev/disk/by-id/usb-Kindle_Internal_Storage_G090WF061476027R-0:0"

# TODO add option to sync over samba share
# TODO ask user or parse as arg if device should be unmounted after successfull sync
# FIX get mount points from udisksctl info
# IdUUID = 685F-DB32 

function start_bb {
  check_avail $BBQ5 BBQ5
}

function start_kindle {
  check_avail $KINDLE KINDLE
}

function sync_bb {
  # Music
  echo "Syncing music"
  unison -fat -auto $HOME/Music/ /run/media/fineman/685F-DB32/music/ -prefer $HOME/Music/ 

  # TODO 
  # sync notes from pc but with rsync or git, git prob be better

  # More folders cause why not
  echo "Syncing books"
  unison -fat -auto $HOME/syncthing/bbq5/device_itself/books/ /run/media/fineman/685F-DB32/books/ -prefer $HOME/syncthing/bbq5/device_itself/books/ 
  echo "Syncing camera"
  unison -fat -auto $HOME/syncthing/bbq5/device_itself/camera/ /run/media/fineman/685F-DB32/camera/ -prefer $HOME/syncthing/bbq5/device_itself/camera/ 
  echo "Syncing documents"
  unison -fat -auto $HOME/syncthing/bbq5/device_itself/documents/ /run/media/fineman/685F-DB32/documents/ -prefer $HOME/syncthing/bbq5/device_itself/documents/ 
  echo "Syncing downloads"
  unison -fat -auto $HOME/syncthing/bbq5/device_itself/downloads/ /run/media/fineman/685F-DB32/downloads/ -prefer $HOME/syncthing/bbq5/device_itself/downloads/ 
  echo "Syncing photos"
  unison -fat -auto $HOME/syncthing/bbq5/device_itself/photos/ /run/media/fineman/685F-DB32/photos/ -prefer $HOME/syncthing/bbq5/device_itself/photos/ 
  echo "Syncing videos"
  unison -fat -auto $HOME/syncthing/bbq5/device_itself/videos/ /run/media/fineman/685F-DB32/videos/ -prefer $HOME/syncthing/bbq5/device_itself/videos/ 
  echo "Syncing voice"
  unison -fat -auto $HOME/syncthing/bbq5/device_itself/voice/ /run/media/fineman/685F-DB32/voice/ -prefer $HOME/syncthing/bbq5/device_itself/voice/ 
}

function sync_kindle {
  # Sync books
  # rsync  --update --recursive --progress --delete $HOME/syncthing/reading/kindle/documents/ /run/media/fineman/Kindle/documents/ 
  echo "Syncing documents"
  unison -fat -auto $HOME/syncthing/reading/kindle/documents/ /run/media/fineman/Kindle/documents/  -prefer $HOME/syncthing/reading/kindle/documents/ 

  # Sync fonts
  # rsync --update --recursive --progress --delete $HOME/syncthing/reading/kindle/fonts/ /run/media/fineman/Kindle/fonts/
  echo "Syncing fonts"
  unison -fat -auto $HOME/syncthing/reading/kindle/fonts/ /run/media/fineman/Kindle/fonts/ -prefer $HOME/syncthing/reading/kindle/fonts/ 
}

function sync_dev {
  # $1 - dev path 
  # $2 - dev name

  echo "Syncing $2"

  case $2 in
  BBQ5)
    sync_bb
    ;;
  KINDLE)
    sync_kindle
    ;;
  *)
    echo "How???"
    exit 1
    ;;
  esac

  echo "If there are no errors then sync thing was good"
  echo ""
}

function check_avail {
  # $1 - dev path 
  # $2 - dev name

  if [ -e $1 ]; then
    echo "$2 is connected"
    check_mount $1 $2
  elif [ ! -e $1 ]; then  
    echo "$2 is not connected"
    echo "Please connect the device if you want to sync things and try again"
  fi
}

function check_mount {
  # $1 - dev path 
  # $2 - dev name

  echo "Checking if $2 is mounted"
  local udisks_info=$(udisksctl info -b $1 | grep "MountPoints:" | sed 's/[[:space:]]*MountPoints:[[:space:]]*//')

  if [ -n "$udisks_info" ]; then
    echo "$2 is mounted at $udisks_info"
  elif [ ! -n "$udisks_info" ]; then 
    echo "$2 is not mounted"
    mount_dev $1 $2
  fi

  sync_dev $1 $2
}

function mount_dev {
  # $1 - dev path 
  # $2 - dev name

  echo "Mounting $2"
  udiskie-mount $1 > /dev/null 2>&1
  
  local udisks_info=$(udisksctl info -b $1 | grep "MountPoints:" | sed 's/[[:space:]]*MountPoints:[[:space:]]*//')

  if [ -n "$udisks_info" ]; then
    echo "$2 is mounted at $udisks_info"
  elif [ ! -n "$udisks_info" ]; then 
    echo "$2 failed to mount"
    exit 1
  fi
}

start_bb
start_kindle
