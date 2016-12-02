#!/bin/bash

usage="Usage:$(basename "$0") [-h] [folder]\nInstalls the lock screen\n
    -h  show this help text\nExample: ./apply.sh illumination\nTest using Ctrl+Alt+L"
OPTIND=1

while getopts "h?t" opt; do
    case "$opt" in
    h|\?)
        echo -e $usage
        exit 0
        ;;
    esac
done

shift $((OPTIND-1))
[ "$1" = "--" ] && shift

if [ "$#" -ne 1 ]
then
  echo "No theme specifid!"
  echo "Usage: apply.sh [folder]"
  exit 1 
else
  sudo rm -r /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/lockscreen/*
  sudo cp -r $1/* /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/lockscreen/
fi
