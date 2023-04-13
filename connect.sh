#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root user or run with sudo"
  exit
fi

sudo mkdir -p /var/run/xl2tpd
sudo touch /var/run/xl2tpd/l2tp-control
sudo service strongswan-starter restart
sudo service xl2tpd restart
sudo ipsec restart
sleep 8
sudo ipsec up L2TP-PSK
sleep 8
sudo bash -c 'echo "c myVPN" > /var/run/xl2tpd/l2tp-control'
sleep 8
ifconfig
