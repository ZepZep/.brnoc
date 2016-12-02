#!/bin/bash

usage="Usage:$(basename "$0") [-h] [-t] [folder]\nInstalls the splash screen\n
    -h  show this help text\n
    -t  tests the splash screen\nExample: ./apply.sh illumination"
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
  if [ $isTest == 1 ]
  then
    ksplashqml --test
  else
    echo "No theme specifid!"
    echo "Usage: apply.sh [folder]"
    exit 1 
  fi
else
  sudo rm -r /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/splash/*
  sudo cp -r $1/* /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/splash/
  
  if [ $isTest == 1 ]
  then
    ksplashqml --test
  fi
fi
