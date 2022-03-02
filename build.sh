#!/bin/bash

# list color
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

# backup file with folder .backup
dir=$(pwd)/.backup
backup_file() {
    # create backup's folder
    if [ -d ".backup" ]; then
        echo "backup's folder created..."; clear
    else
        mkdir $dir
        echo "backup's folder created..."; clear
    fi
}

# function show banner
show_banner() {
    echo -e "${YELLOW}
    .▄▄ · ▄▄▄ .▄▄▄   ▌ ▐·▄▄▄ .▄▄▄  ▪   ▐ ▄  ▄▄· 
    ▐█ ▀. ▀▄.▀·▀▄ █·▪█·█▌▀▄.▀·▀▄ █·██ •█▌▐█▐█ ▌▪
    ▄▀▀▀█▄▐▀▀▪▄▐▀▀▄ ▐█▐█•▐▀▀▪▄▐▀▀▄ ▐█·▐█▐▐▌██ ▄▄${NC}
    ${CYAN}▐█▄▪▐█▐█▄▄▌▐█•█▌ ███ ▐█▄▄▌▐█•█▌▐█▌██▐█▌▐███▌
    ▀▀▀▀  ▀▀▀ .▀  ▀. ▀   ▀▀▀ .▀  ▀▀▀▀▀▀ █▪·▀▀▀ 
    ${NC}${BLUE}Author  : Nurcholis Majid
    Version : 1.0v beta${NC}
    "
}

# function show menu
show_menu() {
    echo -e "    ${GREEN}BUILD SERVER INTERFACES${NC}"
    echo -e "    ${GREEN}-----------------------${NC}"
    echo -e "    ${GREEN}[1]. Konfigurasi IP address${NC}"
    echo -e "    ${GREEN}[2]. Konfigurasi DHCP Server${NC}"
    echo -e "    ${GREEN}[3]. Konfigurasi DNS Server${NC}"
    echo -e "    ${GREEN}[4]. Konfigurasi SSH Server${NC}"
    echo -e "    ${GREEN}[5]. Konfigurasi FTP Server${NC}"
    echo -e "    ${GREEN}[6]. Konfigurasi Mail Server${NC}"
    echo -e "    ${GREEN}[7]. Konfigurasi File Server${NC}"
    echo -e "    ${GREEN}[8]. EXIT${NC}"
    echo -e "    ${GREEN}----------------------------${NC}"
    echo -e -n "    ${GREEN}Pilih Menu :${NC} "
    read menu; return $menu
}

# option of configuration
show_option() {
    echo -e "    Configuration & Reconfiguration $1"
    echo "    -------------------------------------------------------------------------"
    echo -n "    Menu : (1). configure (2). setting ke awal (3). reconfigure (4). back: "
    read recon; return $recon
}

# Konfigurasi IP address
configure_ip() {
    # backup file original
    cp /etc/network/interfaces $dir

    # user input
    echo -n "    Masukan Interfaces : "
    read interfaces
    echo -n "    Masukan IP Address : "
    read ip_address
    echo -n "    Masukan Gateway : "
    read gateway

    # configure
    sed -i "s/allow-hotplug $interfaces/auto $interfaces/g" /etc/network/interfaces
    sed -i "s/iface $interfaces inet dhcp/iface $interfaces inet static/g" /etc/network/interfaces

    # configure ip
    echo " " >> /etc/network/interfaces
    echo -e "      address $ip_address" >> /etc/network/interfaces
    echo -e "      gateway $gateway" >> /etc/network/interfaces

    # restarting network
    /etc/init.d/networking restart
    ifup $interfaces
    service networking restart
    ip addr
    echo "    Enter untuk kembali ke menu..."; read stop
    clear
}

# ip address reconfigure
reconfigure_ip() {
    # backup file
    cp $dir/interfaces /etc/network/interfaces
    
    # restarting network
    /etc/init.d/networking restart
    ifup $interfaces
    service networking restart;
    echo "    Enter untuk kembali ke menu..."; read stop
    clear
}

# DHCP Configure
configure_dhcp_server(){
    # backup files
    cp /etc/dhcp/dhcpd.conf $dir
    cp /etc/default/isc-dhcp-server $dir

    # User input
    echo -n "    Masukan Nama INTERFACES : "
    read interfaces
    echo -n "    Masukan SUBNET : "
    read subnet
    echo -n "    Masukan NETMASK : "
    read netmask
    echo -n "    Masukan IP RANGE : "
    read ip_range
    echo -n "    Masukan DNS : "
    read dns
    echo -n "    Masukan DOMAIN NAME : "
    read domain_name
    echo -n "    Masukan ROUTERS : "
    read routers
    echo -n "    Masukan BROADCAST : "
    read broadcast

    # configurate
    sed -i "s/#subnet 10.5.5.0 netmask 255.255.255.224/#subnet $subnet netmask $netmask/g" /etc/dhcp/dhcpd.conf
    sed -i "s/#  range 10.5.5.26 10.5.5.30/#  range $ip_range/g" /etc/dhcp/dhcpd.conf
    sed -i "s/#  option domain-name-servers ns1.internal.example.org/#  option domain-name-servers $dns/g" /etc/dhcp/dhcpd.conf
    sed -i "s/#  option domain-name \"internal.example.org\"/#  option domain-name \"$domain_name\"/g" /etc/dhcp/dhcpd.conf
    sed -i "s/#  option routers 10.5.5.1/#  option routers $routers/g" /etc/dhcp/dhcpd.conf
    sed -i "s/#  option broadcast-address 10.5.5.31/#  option broadcast-address $broadcast/g" /etc/dhcp/dhcpd.conf
    sed -i "50,58s/#//" /etc/dhcp/dhcpd.conf

    # Setting Interfaces DHCP
    sed -i "s/INTERFACESv4=\"\"/INTERFACESv4=\"$interfaces\"/g" /etc/default/isc-dhcp-server

    # restarting
    systemctl restart isc-dhcp-server
    systemctl status isc-dhcp-server
    echo -n "    Enter untuk kembali ke menu..."; read stop
}

# DHCP reconfigure
reconfigure_dhcp_server() {
    # backup file
    cp $dir/dhcpd.conf /etc/dhcp/dhcpd.conf
    cp $dir/isc-dhcp-server /etc/default/isc-dhcp-server
    
    # restarting network
    systemctl restart isc-dhcp-server
    systemctl status isc-dhcp-server
    echo -n "    Enter untuk kembali ke menu..."; read stop
}

# DNS Configure
configure_dns_server() {
    # backup files
    cp /etc/bind/named.conf.default-zones $dir # backup file defaul-zones
    cp /etc/bind/db.local $dir # backup file db.local
    cp /etc/bind/db.127 $dir # backup file db.127
    cp /etc/resolv.conf $dir # backup file resolv.conf
    
    # user input
    echo -n "    Masukan Domain Name : "
    read domain_name
    echo -n "    Masukan IP Address : "
    read ip_address
    echo -n "    Masukan Blok Awal IP : "
    read first_block_ip
    echo -n "    Masukan Nama DB name : "
    read db_name
    echo -n "    Masukan Nama DB IP : "
    read db_ip
    echo -n "    Masukan Tiga Digit IP Belakang : "
    read ip_digit

    # configure dns: default zones
    sed -i "s/zone \"localhost\"/zone \"$domain_name\"/g" /etc/bind/named.conf.default-zones
    sed -i "s/zone \"127.in-addr.arpa\"/zone \"$first_block_ip.in-addr.arpa\"/g" /etc/bind/named.conf.default-zones
    sed -i "s/bind\/\db.local/bind\/\db.$db_name/g" /etc/bind/named.conf.default-zones
    sed -i "s/bind\/\db.127/bind\/\db.$db_ip/g" /etc/bind/named.conf.default-zones
    
    # configure dns: db.local
    sed -i "s/localhost./$domain_name./g" /etc/bind/db.127
    sed -i "s/1.0.0/$ip_digit/g" /etc/bind/db.127
    mv /etc/bind/db.127 /etc/bind/db.${db_ip}

    # configure dns: db.127
    sed -i "s/localhost./$domain_name./g" /etc/bind/db.local
    sed -i "s/127.0.0.1/$ip_address/g" /etc/bind/db.local
    sed -i '14d' /etc/bind/db.local
    mv /etc/bind/db.local /etc/bind/db.${db_name}

    # configure dns: resolv.conf
    sed -i "s/nameserver /#nameserver /g" /etc/resolv.conf
    echo "nameserver $ip_address" >> /etc/resolv.conf

    # restarting
    service bind9 restart
    service bind9 status;
    echo -n "    Enter untuk kembali ke menu..."; read stop
}

# DNS Reconfigure
reconfigure_dns_server() {
    # backup file
    cp $dir/named.conf.default-zones /etc/bind/
    cp $dir/db.local /etc/bind/
    cp $dir/db.127 /etc/bind/
    cp $dir/resolv.conf /etc/

    # restarting
    service bind9 restart
    service bind9 status;
    echo -n "    Enter untuk kembali ke menu..."; read stop
}

# SSH Configurate
configure_ssh_server() {
    # backup files
    cp /etc/ssh/sshd_config $dir # backup file sshd_config

    # user input
    echo -n "    Masukan Port : "
    read port

    # restarting and enable
    systemctl start ssh
    systemctl enable ssh
    systemctl status ssh

    # configure
    sed -i "s/#Port 22/Port {port}/g" /etc/ssh/sshd_config

    # check setup
    systemctl restart ssh
    systemctl status ssh
    netstat -tulpn | grep ssh; echo -n "    Enter untuk kembali ke menu..."; read stop
}

# SSH Reconfigurate
reconfigure_ssh_server() {
    # backup file
    cp $dir/sshd_config /etc/ssh/

    # restarting and enable
    systemctl start ssh
    systemctl enable ssh
    systemctl status ssh; echo -n "    Enter untuk kembali ke menu..."; read stop
}

# FTP Configurate
configure_ftp_server() {
    # backup files
    cp /etc/vsftpd.conf $dir # backup file sshd_config

    # user input
    echo -n "    Masukan Nama User : "
    read user

    # firewall allow port
    ufw allow 20/tcp
    ufw allow 21/tcp

    # add FTP user
    adduser $user
    passwd $user
    echo $user | tee -a /etc/vsftpd.userlist

    # restart
    systemctl restart vsftpd
    systemctl enable vsftpd
    systemctl enable vsftpd.service
    echo -n "Enter untuk kembali ke menu..."; read stop
}

# FTP Reconfigurate
reconfigure_ftp_server() {
    # backup file
    cp $dir/vsftpd.conf /etc/

    # restart
    systemctl restart vsftpd
    systemctl enable vsftpd
    systemctl enable vsftpd.service
    echo -n "Enter untuk kembali ke menu..."; read stop
}

# MAIL configurate
configure_mail_server() {
    # backup files
    cp /etc/postfix/main.cf $dir # backup file main.cf
    cp /etc/dovecot/conf.d/10-mail.conf $dir # backup file 10-mail.conf
    cp /etc/dovecot/conf.d/10-auth.conf $dir # backup file 10-auth.conf

    # membuat direktori penyimpanan Mail server
    maildirmake.dovecot /etc/skel/Maildir

    # Pada baris dibawah tambahkan code
    echo "home_mailbox = Maildir/" >> /etc/postfix/main.cf

    # konfigurasi paket aplikasi dovecot
    # line 30 | 10-mail.conf
    sed -i "30s|mbox:~/mail:INBOX=/var/mail/%u|maildir:~/Maildir|" /etc/dovecot/conf.d/10-mail.conf
    # line | 10-auth.conf
    sed -i "10s/#//" /etc/dovecot/conf.d/10-auth.conf
    sed -i "10s/yes/no/" /etc/dovecot/conf.d/10-auth.conf

    # reconfigure
    dpkg-reconfigure postfix

    # restarting
    systemctl restart postfix
    systemctl restart dovecot
    systemctl restart bind9
    systemctl status postfix.service
    systemctl status dovecot.service
    systemctl status bind9.service
    echo -n "Enter untuk kembali ke menu..."; read stop
}

# MAIL reconfigurate
reconfigure_mail_server() {
    # backup file
    cp $dir/main.cf /etc/postfix/
    cp $dir/10-mail.conf /etc/dovecot/conf.d/
    cp $dir/10-auth.conf /etc/dovecot/conf.d/

    # restarting
    systemctl restart postfix
    systemctl restart dovecot
    systemctl restart bind9
    systemctl status postfix.service
    systemctl status dovecot.service
    systemctl status bind9.service
    echo -n "Enter untuk kembali ke menu..."; read stop
}

# backup file
backup_file

# loop main program
while true
do
    clear
    show_banner
    show_menu
    case $? in
        1)
            clear; show_banner
            show_option "IP ADDRESS"
                if [ $? -eq 1 ]; then
                    configure_ip
                elif [ $? -eq 2 ]; then
                    reconfigure_ip
                elif [ $? -eq 3 ]; then
                    reconfigure_ip
                    configure_ip
                fi
            ;;
        2)
            clear; show_banner
            show_option "DHCP SERVER"
                if [ $? -eq 1 ]; then
                    configure_dhcp_server
                elif [ $? -eq 2 ]; then
                    reconfigure_dhcp_server
                elif [ $? -eq 3 ]; then
                    reconfigure_dhcp_server
                    configure_dhcp_server
                fi
            ;;
        3)
            clear; show_banner
            show_option "DNS SERVER"
                if [ $? -eq 1 ]; then
                    configure_dns_server
                elif [ $? -eq 2 ]; then
                    reconfigure_dns_server
                elif [ $? -eq 3 ]; then
                    reconfigure_dns_server
                    configure_dns_server
                fi
            ;;
        4)
            clear; show_banner
            show_option "SSH SERVER"
                if [ $? -eq 1 ]; then
                    configure_ssh_server
                elif [ $? -eq 2 ]; then
                    reconfigure_ssh_server
                elif [ $? -eq 3 ]; then
                    reconfigure_ssh_server
                    configure_ssh_server
                fi
            ;;
        5)
            clear; show_banner
            show_option "FTP SERVER"
                if [ $? -eq 1 ]; then
                    configure_ftp_server
                elif [ $? -eq 2 ]; then
                    reconfigure_ftp_server
                elif [ $? -eq 3 ]; then
                    reconfigure_ftp_server
                    configure_ftp_server
                fi
            ;;
        6)
            clear; show_banner
            show_option "MAIL SERVER"
                if [ $? -eq 1 ]; then
                    configure_mail_server
                elif [ $? -eq 2 ]; then
                    reconfigure_mail_server
                elif [ $? -eq 3 ]; then
                    reconfigure_mail_server
                    configure_mail_server
                fi
            ;;
    esac
done
