# install ftp
apt install vsftpd

# allow port
ufw allow 20/tcp
ufw allow 21/tcp

# file ftp
nano /etc/vsftpd.conf

# add FTP user
adduser {user}
passwd {user}
echo "tin" | tee -a /etc/vsftpd.userlist

# restart
systemctl restart vsftpd
systemctl enable vsftpd