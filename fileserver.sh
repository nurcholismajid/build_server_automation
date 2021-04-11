# install
apt install samba samba-client

# nama folder
echo -n "Masukan Nama Folder : "
read folder
# buat folder sharing
mkdir ~/$folder
chmod 777 ~/$folder

# status
echo -e "Folder $folder berada di folder home..."

# edit file
nano /etc/samba/smb.conf

# tambah konfigurasi berikut paling bawah
echo "[share]" >> /etc/samba/smb.conf
echo "path = /share" >> /etc/samba/smb.conf
echo "browseable = yes" >> /etc/samba/smb.conf
echo "writeable = yes" >> /etc/samba/smb.conf
echo "read only = no" >> /etc/samba/smb.conf
echo "public = yes" >> /etc/samba/smb.conf

# restarting
systemctl restart smbd
systemctl status smbd

# check
echo "Untuk check samba ketik perintah: smbclient -L localhost..."