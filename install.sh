#!/bin/bash

# EXMAPLE COMMAND:
# sudo ./install.sh [ip] [psk] [user] [password]


VPN_SERVER_IPV4=$1
PSK=$2
USER=$3
PASS=$4

if [ "$EUID" -ne 0 ]
  then echo "Please run as root user or run with sudo"
  exit
fi

sudo apt-get update
sudo apt-get -y install strongswan xl2tpd net-tools

echo "
conn %default
    ikelifetime=60m
    keylife=20m
    rekeymargin=3m
    keyingtries=1
    keyexchange=ikev1
    authby=secret
    ike=aes128-sha1-modp1024,3des-sha1-modp1024!
    esp=aes128-sha1-modp1024,3des-sha1-modp1024!

conn L2TP-PSK
    keyexchange=ikev1
    left=%defaultroute
    auto=add
    authby=secret
    type=transport
    leftprotoport=17/1701
    rightprotoport=17/1701
    # set this to the ip address of your vpn server
    right=$VPN_SERVER_IPV4
"  | sudo tee -a /etc/ipsec.conf

echo ": PSK "$PSK"" | sudo tee -a /etc/ipsec.secrets

echo "
[lac myVPN]
; set this to the ip address of your vpn server
lns = $VPN_SERVER_IPV4
ppp debug = yes
pppoptfile = /etc/ppp/options.l2tpd.client
length bit = yes
" | sudo tee -a /etc/xl2tpd/xl2tpd.conf

sudo touch /etc/ppp/options.l2tpd.client
echo "
ipcp-accept-local
ipcp-accept-remote
refuse-eap
require-mschap-v2
noccp
noauth
logfile /var/log/xl2tpd.log
idle 1800
mtu 1410
mru 1410
defaultroute
usepeerdns
debug
connect-delay 5000
name $USER
password $PASS
" | sudo tee -a /etc/ppp/options.l2tpd.client


