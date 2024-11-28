#!/bin/bash

# NOTE 
# when creating symlinks take an absolute path for source, e.g.
# ln -s "$(pwd)/source" ~/.config/dest
#

# TODO 
# check environement; if termux then do different paths etc

case "$(uname -o)" in
  *inux)
    echo "Linux";;
  *ndroid)
    echo "Android";;
  *)
    echo "Undefined OS"
    exit 1;;
esac
