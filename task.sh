#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root user or run with sudo"
  exit
fi

if ifconfig | grep -q 'ppp0'; then
    echo "l2tp connection is ok!"
else
    DIR="$( cd "$( dirname "$0" )" && pwd )"
    sudo $DIR/connect.sh
fi
