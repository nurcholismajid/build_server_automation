#!/bin/bash

# ============================================
# AUTHOR    : NURCHOLIS MAJID
#           : @no_orch
#           : https://nurcholismajid.github.io/
#           : DNS SERVER AUTOMATION
#           : v0.1
# ============================================

# prerequist
apt install bind9 dnsutils
# backup
cp /etc/bind/named.conf.default-zones ~/backup/

# user input
echo -n "Masukan Domain Name            : "
read DOMAIN_NAME
echo -n "Masukan Blok Awal IP           : "
read FIRST_BLOCK_IP
echo -n "Masukan Nama DB Name           : "
read DB_NAME
echo -n "Masukan Nama DB IP             : "
read DB_IP
echo -n "Tiga Digit IP Dari Belakang    : "
read IP_DIGIT

# raplace default zones
sed -i "s/zone \"localhost\"/zone \"$DOMAIN_NAME\"/g" coba-dns.txt
sed -i "s/zone \"127.in-addr.arpa\"/zone \"$FIRST_BLOCK_IP.in-addr.arpa\"/g" coba-dns.txt
sed -i "s/bind\/\db.local/bind\/\db.$DB_NAME/g" coba-dns.txt
sed -i "s/bind\/\db.127/bind\/\db.$DB_IP/g" coba-dns.txt

# replace db.local
sed -i "s/localhost./$DOMAIN_NAME./g" coba-dns.txt
sed -i "s/1.0.0/$IP_DIGIT/g" coba-dns.txt

# replace db.127
sed -i "s/localhost./$DOMAIN_NAME./g" coba-dns.txt
sed -i "s/127.0.0.1/$FIRST_BLOCK_IP.$IP_DIGIT/g" coba-dns.txt

# restarting
service bind9 restart
service bind9 status

# replace search & nameserver