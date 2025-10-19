#!/usr/bin/env bash

echo "Rsync the fuck out of blue drive to the other one"
rsync --recursive --update --progress --delete /run/media/fineman/kingslayer/ /run/media/fineman/kingslayerFuckups/
