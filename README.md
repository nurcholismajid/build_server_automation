# BUILD SERVER AUTOMATION
Membangun sebuah server jaringan dengan service dibawah ini :
### Services :
<a href="#"><img src="https://img.shields.io/badge/Debian9-Server-_.svg?logo=debian"></a>
<a href="#"><img src="https://img.shields.io/badge/Bash-SHELL-_.svg?logo=terminal"></a>

- IP Address <i>**(Done)**</i>
- RAID <i>**(Coming Soon)**</i>
- User Unix <i>**(Coming Soon)**</i>
- DNS Server <i>**(Coming Soon)**</i>
- Web Server <i>**(Coming Soon)**</i>
- FTP <i>**(Coming Soon)**</i>
- Mail <i>**(Coming Soon)**</i>
- File Server <i>**(Coming Soon)**</i>
- SSH Server <i>**(Coming Soon)**</i>
- CA (OpenSSL) <i>**(Coming Soon)**</i>
- Monitoring Server (Cacti) <i>**(Coming Soon)**</i>
- RADIUS <i>**(Coming Soon)**</i>
- DHCP Server <i>**(Done)**</i>
- Routing <i>**(Coming Soon)**</i>
- DHCP Relay <i>**(Coming Soon)**</i>
- Reverse Proxy (Ngix) <i>**(Coming Soon)**</i>
- VPN Server <i>**(Coming Soon)**</i>
- Firewall <i>**(Coming Soon)**</i>

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