#!/bin/bash

usage="Usage:$(basename "$0") [-h] [-t] [folder]\nInstalls the SDDM illumination theme\n
    -h  show this help text\n
    -t  tests the theme\nExample: ./apply.sh illumination\n\nDo not forget to enable this theme in System Settings!\n"
OPTIND=1
isTest=0

while getopts "h?t" opt; do
    case "$opt" in
    h|\?)
        echo -e $usage
        exit 0
        ;;
    t)  isTest=1
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
  sudo rm -r /usr/share/sddm/themes/$1/
  sudo mkdir /usr/share/sddm/themes/$1/
  sudo cp -r $1/* /usr/share/sddm/themes/$1/
  
  if [ $isTest == 1 ]
  then
    sddm-greeter --test --theme $1
  fi
fi
echo -e "\nDo not forget to enable this theme in System Settings!\n"




