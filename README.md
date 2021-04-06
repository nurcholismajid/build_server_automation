# BUILD SERVER AUTOMATION
Membangun sebuah server jaringan dengan beberapa service dibawah ini :
### Teknologi :
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

### Instalasi :
```SHELL
root@noorch:~# apt-get install git python3 python3-pip
root@noorch:~# python3 -r requirements.txt
root@noorch:~# git clone https://github.com/nurcholismajid/build_server_automation
root@noorch:~# cd build_server_automation
root@noorch:~/build_server_automation# chmod +x build.py
root@noorch:~/build_server_automation# python3 build.py
```

#### Membuat Folder Backup

Folder `.backup` ada didalam direktori `build_server_automation` ketikan perintah `ls -a` untuk melihat folder

```Python
f = os.popen("pwd")
dir = f.read().strip()

def backup_file():
    # create backup folder
    create_folder = f"mkdir {dir}/.backup"
    os.system(create_folder)
```