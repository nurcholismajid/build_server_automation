# membuat direktori penyimpanan Mail server
maildirmake.dovecot /etc/skel/Maildir

# konfigurasi pada paket aplikasi postfix
nano /etc/postfix/main.cf

# Pada baris dibawah tambahkan code
echo "home_mailbox = Maildir/" >> /etc/postfix/main.cf

# konfigurasi paket aplikasi dovecot
nano /etc/dovecot/conf.d/10-mail.conf
nano /etc/dovecot/conf.d/10-auth.conf

# reconfigure
dpkg-reconfigure postfix

# restarting
systemctl restart postfix
systemctl restart dovecode
systemctl restart bind9
systemctl status postfix.service
systemctl status dovecode.service
systemctl status bind9.service
