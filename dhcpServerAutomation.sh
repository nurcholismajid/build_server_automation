#!/bin/bash

# ============================================
# AUTHOR    : NURCHOLIS MAJID
#           : @no_orch
#           : https://nurcholismajid.github.io/
#           : DHCP SERVER AUTOMATION
#           : v0.1
# ============================================

# prerequist
apt update
apt install isc-dhcp-server -y

# List Color
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

GRAY='\033[1;30m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
NC='\033[0m'

# broadcast-address
echo -n "Masukan Nama Interfaces    : "
read INTERFACES
# subnet
echo -n "Masukan Subnet             : "
read SUBNET
# netmask
echo -n "Masukan Netmask            : "
read NETMASK
# range
echo -n "Masukan Range              : "
read RANGE
# domain-name-servers
echo -n "Masukan DNS                : "
read DNS
# domain-name
echo -n "Masukan Domain Name        : "
read DOMAIN_NAME
# routers
echo -n "Masukan routers            : "
read ROUTERS
# broadcast-address
echo -n "Masukan Broadcast Address  : "
read BROADCAST

# result
echo ""
echo -e "${RED}RESULT : ${NC}"
echo -e "   - ${GREEN}INTERFACES${NC}   : ${YELLOW}$INTERFACES${NC}"
echo -e "   - ${GREEN}SUBNET${NC}       : ${YELLOW}$SUBNET${NC}"
echo -e "   - ${GREEN}NETMASK${NC}      : ${YELLOW}$NETMASK${NC}"
echo -e "   - ${GREEN}RANGE${NC}        : ${YELLOW}$RANGE${NC}"
echo -e "   - ${GREEN}DNS${NC}          : ${YELLOW}$DNS${NC}"
echo -e "   - ${GREEN}DOMAIN NAME${NC}  : ${YELLOW}$DOMAIN_NAME${NC}"
echo -e "   - ${GREEN}ROUTERS${NC}      : ${YELLOW}$ROUTERS${NC}"
echo -e "   - ${GREEN}BROADCAST${NC}    : ${YELLOW}$BROADCAST${NC}"

# backup file
mkdir backup
cp /etc/dhcp/dhcpd.conf /backup/
# Setting DHCP
sed -i "s/subnet 10.5.5.0 netmask 255.255.255.224/subnet $SUBNET netmask $NETMASK/g" /etc/dhcp/dhcpd.conf
sed -i "s/range 10.5.5.26 10.5.5.30/range $RANGE/g" /etc/dhcp/dhcpd.conf
sed -i "s/option domain-name-servers ns1.internal.example.org/option domain-name-servers $DNS/g" /etc/dhcp/dhcpd.conf
sed -i "s/option domain-name \"internal.example.org\"/option domain-name \"$DOMAIN_NAME\"/g" /etc/dhcp/dhcpd.conf
sed -i "s/option routers 10.5.5.1/option routers $ROUTERS/g" /etc/dhcp/dhcpd.conf
sed -i "s/option broadcast-address 10.5.5.31/option broadcast-address $BROADCAST/g" /etc/dhcp/dhcpd.conf
# Setting Interfaces DHCP
sed -i "s/INTERFACESv4=\"\"/INTERFACESv4=\"$INTERFACES\"/g" /etc/default/isc-dhcp-server
# restarting
systemctl restart isc-dhcp-server
# cek status
systemctl status isc-dhcp-server