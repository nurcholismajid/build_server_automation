# BUILD SERVER AUTOMATION
[![forthebadge made-with-python](http://ForTheBadge.com/images/badges/made-with-python.svg)](https://www.python.org/)<br>
Membangun sebuah server jaringan dengan service dibawah ini :
### Services :
<a href="#"><img src="https://img.shields.io/badge/Debian10-Server-_.svg?logo=debian"></a>
<a href="#"><img src="https://img.shields.io/badge/Bash-SHELL-_.svg?logo=shell"></a>

- IP Address **(Done)**
- RAID (Coming Soon)
- User Unix (Coming Soon)
- DNS Server **(Done)**
- Web Server **(Done)**
- FTP **(Done)**
- Mail (Coming Soon)
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

### Install paket yang diperlukan :

Install requirements dibawah ini, berikut daftar paket dari masing-masing service
| Service | Requirement |
| ----- | ------ |
| Main Program|`git python3 python3-pip` |
| DHCP Server |`isc-dhcp-server` |
| DNS Server  |`bind9 dnsutils` |
| Web Server  |`apache2 php7.0 mysql-server phpmyadmin` |
| SSH Server  |`openssh-server` |
| FTP Server  |`vsftpd ufw` |
| Mail Server |`postfix courier-imap courier-pop roundcube` |

bisa juga kita install secara bersamaan dengan cara `./requirement.sh` atau `bash requirement.sh` karena perintah dibawah ini bisa kita temukan didalam file `requirement.sh`

```Shell
apt-get install git python3 python3-pip isc-dhcp-server bind9 dnsutils apache2 php7.0 mysql-server phpmyadmin openssh-server vsftpd ufw postfix courier-imap courier-pop roundcube -y
```

### Referensi :
- [Replacing With Sed](https://unix.stackexchange.com/questions/70878/replacing-string-based-on-line-number)