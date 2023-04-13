#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root user or run with sudo"
  exit
fi

sudo bash -c 'echo "d myVPN" > /var/run/xl2tpd/l2tp-control'
ipsec down L2TP-PSK
