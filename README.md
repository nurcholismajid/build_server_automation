# BUILD SERVER AUTOMATION
[![forthebadge made-with-python](http://ForTheBadge.com/images/badges/made-with-python.svg)](https://www.python.org/)
Membangun sebuah server jaringan dengan service dibawah ini :
### Services :
<a href="#"><img src="https://img.shields.io/badge/Debian9-Server-_.svg?logo=debian"></a>
<a href="#"><img src="https://img.shields.io/badge/Bash-SHELL-_.svg?logo=terminal"></a>

- IP Address **(Done)**
- RAID (Coming Soon)
- User Unix (Coming Soon)
- DNS Server **(Done)**
- Web Server **(Done)**
- FTP (Coming Soon)
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

Install requirements dibawah ini

```Shell
apt-get install git python3 python3-pip isc-dhcp-server bind9 dnsutils apache2 php7.0 mysql-server phpmyadmin openssh-server -y
```

### Referensi :
- [Replacing With Sed](https://unix.stackexchange.com/questions/70878/replacing-string-based-on-line-number)