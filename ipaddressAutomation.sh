#!/bin/bash

# ============================================
# AUTHOR    : NURCHOLIS MAJID
#           : @no_orch
#           : https://nurcholismajid.github.io/
#           : DHCP SERVER AUTOMATION
#           : v0.1
# ============================================

# input IP Address & Gateway
echo -n "Masukan Nama Interfaces: "
read INTERFACES
echo -n "Masukan IP Address     : "
read IP_ADDRESS
echo -n "Masukan IP Gateway     : "
read GATEWAY

# path interfaces > /etc/network/interfaces
sed -i "s/allow-hotplug ens33/auto $INTERFACES/g" coba-ip.txt
sed -i "s/iface ens33 inet dhcp/iface ens33 inet static/g" coba-ip.txt

# add ip address
echo " " >> coba-ip.txt
echo -e "      address $IP_ADDRESS" >> coba-ip.txt
echo -e "      gateway $GATEWAY" >> coba-ip.txt

# restarting ip address
/etc/init.d/networking restart
service networking restart

# tampilkan result
ip addr