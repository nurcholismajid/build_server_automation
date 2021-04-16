# SERVER INSTALLER
[![forthebadge made-with-bash](http://ForTheBadge.com/images/badges/made-with-bash.svg)](https://www.gnu.org/software/bash/)<br>
Membangun sebuah server jaringan dengan service dibawah ini :
### Screenshot
![](https://i.imgur.com/qxKgNB5.png)

### Services :
<a href="#"><img src="https://img.shields.io/badge/Debian10-Server-_.svg?logo=debian"></a>
<a href="#"><img src="https://img.shields.io/badge/Bash-SHELL-_.svg?logo=shell"></a>

- IP Address **(Done)**
- RAID (Coming Soon)
- User Unix (Coming Soon)
- DNS Server **(Done)**
- Web Server **(Done)**
- FTP **(Done)**
- Mail Server **(Done)**
- File Server (Coming Soon)
- SSH Server **(Done)**
- CA (OpenSSL) (Coming Soon)
- Monitoring Server (Cacti) (Coming Soon)
- RADIUS (Coming Soon)
- DHCP Server **(Done)**
- Routing (Coming Soon)
- DHCP Relay (Coming Soon)
- Reverse Proxy (Ngix) (Coming Soon)
- VPN Server (Coming Soon)
- Firewall (Coming Soon)

## Backup File Konfigurasi

> **Jangan Hapus Folder `.backup`!**
File konfigurasi original dari masing-masing service berada di folder `.backup` ketikan perintah `ls -a` untuk melihat folder.

```Markdown
.
├── build.py
├── .backup/
    ├── dhcpd.conf
    ├── isc-dhcp-server
    ├── interfaces
    └── ...
```

## Tutorial :
### Install paket yang diperlukan :

Install requirements dibawah ini, berikut daftar paket dari masing-masing service
|    Service  | Requirement |
| ----------- | ----------- |
| Main Program|`apt-get install git python3 python3-pip` |
| DHCP Server |`apt-get install isc-dhcp-server` |
| DNS Server  |`apt-get install bind9 dnsutils` |
| Web Server  |`apt-get install apache2 php7.0 mysql-server phpmyadmin` |
| SSH Server  |`apt-get install openssh-server` |
| FTP Server  |`apt-get install vsftpd ufw` |
| Mail Server |`apt-get install postfix courier-imap courier-pop roundcube` |

bisa juga kita install secara bersamaan dengan cara `./requirement.sh` atau `bash requirement.sh` karena perintah dibawah ini bisa kita temukan didalam file `requirement.sh`

```Shell
apt-get install git python3 python3-pip isc-dhcp-server bind9 dnsutils apache2 php7.0 mysql-server phpmyadmin openssh-server vsftpd ufw postfix courier-imap courier-pop roundcube -y
```

### Cloning Repositori (Program)

Setelah kita install semua paket diatas kita cloning repositorinya dengan perintah :
```Git
git clone https://github.com/nurcholismajid/build_server_automation.git server_installer
```

buka dan berikan akses execute pada `build.sh`
```Shell
cd server_installer
chmod +x build.sh
```

jalankan dengan salah satu perintah berikut :
```Shell
./build.sh
bash build.sh
```
### Disable Connect Internet

Pada file `sources.list` berikan tanda pagar `#` pada bagian depan `deb http://` dan `deb-src http://`.

```Shell
nano /etc/apt/sources.list

-----------Before----------

deb http://
deb-src http://

-----------After-----------

# deb http://
# deb-src http://

--------------------------
```

### Referensi :
- [Replacing With Sed](https://unix.stackexchange.com/questions/70878/replacing-string-based-on-line-number)
- [Mail Server](https://pakfaisal.com/2020/07/31/tutorial-konfigurasi-mail-server-pada-debian-10/)

### Inspired
- LKS2021 SMK JABAR

