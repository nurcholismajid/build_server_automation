#!/bin/bash

# ============================================
# AUTHOR    : NURCHOLIS MAJID
#           : @no_orch
#           : https://nurcholismajid.github.io/
#           : SSH SERVER AUTOMATION
#           : v0.1
# ============================================

# prerequist
apt install openssh-server -y

# run SSH
systemctl start ssh
systemctl enable ssh
systemctl status ssh

# replace 
sed -i "s/#Port 22/Port 22/g" /etc/ssh/sshd_config

# check status
systemctl restart ssh
systemctl status ssh
netstat -tulpn | grep ssh