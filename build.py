import os
from rich.console import Console
console = Console()
# =========================================
# Author : Nurcholis Majid
#        : @no_orch
#        : Noorch Dev
#          https://nurcholismajid.github.io 
# =========================================

# backup file
f = os.popen("pwd")
dir = f.read().strip()

def backup_file():
    # create backup's folder
    create_folder = f"mkdir {dir}/.backup"
    os.system(create_folder)

# tampilkan menu
def show_menu():
    os.system("clear")
    console.print("Build Server Interfaces :coffee:")
    console.print("-----------------------")
    console.print("[1]. :fries: Konfigurasi [bold green]IP address[/bold green]")
    console.print("[2]. :spaghetti: Konfigurasi [bold yellow]DHCP Server[/bold yellow]")
    console.print("[3]. :pizza: Konfigurasi [bold purple]DNS Server[/bold purple]")
    console.print("[4]. :hamburger: Konfigurasi [bold cyan]Web Server[/bold cyan]")
    console.print("[5]. :space_invader: [bold yellow]EXIT[/bold yellow]")
    console.print("------------------------------")
    menu = int(input("Pilih Menu : "))
    return menu

# menu konfigurasi
def configurate_menu(service):
    os.system("clear")
    console.print(f" :ramen: [italic purple]Configuration[/italic purple] & [italic yellow]Reconfiguration[/italic yellow] [bold green]{service}[/bold green]")
    console.print(" -------------------------------------------------------------------------")
    console.print(" :memo:", end="")
    recon = int(input(" Menu : (1). configure (2). setting ke awal (3). reconfigure (4). back: "))
    return recon

# Konfigurasi IP address
def ip_addr_configure():
    # backup file
    backup_folder = f"{dir}/.backup"
    os.system(f"cp /etc/network/interfaces {backup_folder}")

    # user input
    interfaces = input("Masukan Interfaces : ")
    ip_address = input("Masukan IP Address : ")
    gateway = input("Masukan Gateway : ")

    # configure
    os.system(f'sed -i "s/allow-hotplug {interfaces}/auto {interfaces}/g" /etc/network/interfaces')
    os.system(f'sed -i "s/iface {interfaces} inet dhcp/iface {interfaces} inet static/g" /etc/network/interfaces')

    # configure ip
    os.system('echo " " >> /etc/network/interfaces')
    os.system(f'echo "      address {ip_address}" >> /etc/network/interfaces')
    os.system(f'echo "      gateway {gateway}" >> /etc/network/interfaces')

    # restarting network
    os.system('/etc/init.d/networking restart')
    os.system(f'ifup {interfaces}')
    os.system('service networking restart')
    os.system('ip addr');input("Enter untuk kembali ke menu...")
    os.system('clear')

# ip address reconfigure
def ip_addr_reconfigure():
    # backup file
    backup_folder = f"{dir}/.backup"
    os.system(f"cp {backup_folder}/interfaces /etc/network/interfaces")
    
    # restarting network
    os.system('/etc/init.d/networking restart')
    os.system(f'ifup {interfaces}')
    os.system('service networking restart');input("Enter untuk kembali ke menu...")

# DHCP Configure
def dhcp_server_configure():
    # backup files
    backup_folder = f"{dir}/.backup"
    os.system(f"cp /etc/dhcp/dhcpd.conf {backup_folder}")
    os.system(f"cp /etc/default/isc-dhcp-server {backup_folder}")

    # User input
    interfaces = input("Masukan Nama INTERFACES : ")
    subnet = input("Masukan SUBNET : ")
    netmask = input("Masukan NETMASK : ")
    ip_range = input("Masukan IP RANGE : ")
    dns = input("Masukan DNS : ")
    domain_name = input("Masukan DOMAIN NAME : ")
    routers = input("Masukan ROUTERS : ")
    broadcast = input("Masukan BROADCAST : ")

    # configurate
    os.system(f'sed -i "s/#subnet 10.5.5.0 netmask 255.255.255.224/#subnet {subnet} netmask {netmask}/g" /etc/dhcp/dhcpd.conf')
    os.system(f'sed -i "s/#  range 10.5.5.26 10.5.5.30/#  range {ip_range}/g" /etc/dhcp/dhcpd.conf')
    os.system(f'sed -i "s/#  option domain-name-servers ns1.internal.example.org/#  option domain-name-servers {dns}/g" /etc/dhcp/dhcpd.conf')
    os.system(f"sed -i 's/#  option domain-name \"internal.example.org\"/#  option domain-name \"{domain_name}\"/g' /etc/dhcp/dhcpd.conf")
    os.system(f'sed -i "s/#  option routers 10.5.5.1/#  option routers {routers}/g" /etc/dhcp/dhcpd.conf')
    os.system(f'sed -i "s/#  option broadcast-address 10.5.5.31/#  option broadcast-address {broadcast}/g" /etc/dhcp/dhcpd.conf')
    os.system('sed -i "50,58s/#//" /etc/dhcp/dhcpd.conf')

    # Setting Interfaces DHCP
    os.system(f'sed -i "s/INTERFACESv4=\"\"/INTERFACESv4=\"{interfaces}\"/g" /etc/default/isc-dhcp-server')

    # restarting
    os.system("systemctl restart isc-dhcp-server")
    os.system("systemctl status isc-dhcp-server");input("Enter untuk kembali ke menu...")

# DHCP reconfigure
def dhcp_server_reconfigure():
    # backup file
    backup_folder = f"{dir}/.backup"
    os.system(f"cp {backup_folder}/dhcpd.conf /etc/dhcp/dhcpd.conf")
    os.system(f"cp {backup_folder}/isc-dhcp-server /etc/default/isc-dhcp-server")
    
    # restarting network
    os.system("systemctl restart isc-dhcp-server")
    os.system("systemctl status isc-dhcp-server");input("Enter untuk kembali ke menu...")

def dns_configure():
    # backup files
    backup_folder = f"{dir}/.backup"
    os.system(f"cp /etc/bind/named.conf.default-zones {backup_folder}") # backup file defaul-zones
    os.system(f"cp /etc/bind/db.local {backup_folder}") # backup file db.local
    os.system(f"cp /etc/bind/db.127 {backup_folder}") # backup file db.127
    os.system(f"cp /etc/resolv.conf {backup_folder}") # backup file resolv.conf
    
    # user input
    domain_name = input("Masukan Domain Name : ")
    ip_address = input("Masukan IP Address : ")
    first_block_ip = input("Masukan Blok Awal IP : ")
    db_name = input("Masukan Nama DB name : ")
    db_ip = input("Masukan Nama DB IP : ")
    ip_digit = input("Masukan Tiga Digit IP Belakang : ")

    # configure dns: default zones
    os.system(f"sed -i 's/zone \"localhost\"/zone \"{domain_name}\"/g' /etc/bind/named.conf.default-zones")
    os.system(f"sed -i 's/zone \"127.in-addr.arpa\"/zone \"{first_block_ip}.in-addr.arpa\"/g' /etc/bind/named.conf.default-zones")
    os.system(f"sed -i 's/bind\/\db.local/bind\/\db.{db_name}/g' /etc/bind/named.conf.default-zones")
    os.system(f"sed -i 's/bind\/\db.127/bind\/\db.{db_ip}/g' /etc/bind/named.conf.default-zones")
    
    # configure dns: db.local
    os.system(f"sed -i 's/localhost./{domain_name}./g' /etc/bind/db.127")
    os.system(f"sed -i 's/1.0.0/{ip_digit}/g' /etc/bind/db.127")
    os.system(f"mv /etc/bind/db.local /etc/bind/db.{db_name}")

    # configure dns: db.127
    os.system(f"sed -i 's/localhost./{domain_name}./g' /etc/bind/db.local")
    os.system(f"sed -i 's/127.0.0.1/{ip_address}/g' /etc/bind/db.local")
    os.system(f"sed -i '14s/@/#@/' /etc/bind/db.local")
    os.system(f"mv /etc/bind/db.127 /etc/bind/db.{db_ip}")

    # configure dns: resolv.conf
    os.system(f"sed -i 's/nameserver /#nameserver /g' /etc/resolv.conf")
    os.system(f'echo "nameserver {ip_address}" >> /etc/resolv.conf')

    # restarting
    os.system("service bind9 restart")
    os.system("service bind9 status");input("Enter untuk kembali ke menu...")

def dns_reconfigure():
    # backup file
    backup_folder = f"{dir}/.backup"
    os.system(f"cp {backup_folder}/named.conf.default-zones /etc/bind/")
    os.system(f"cp {backup_folder}/db.local /etc/bind/")
    os.system(f"cp {backup_folder}/db.127 /etc/bind/")
    os.system(f"cp {backup_folder}/resolv.conf /etc/")

    # restarting
    os.system("service bind9 restart")
    os.system("service bind9 status");input("Enter untuk kembali ke menu...")

if __name__ == "__main__":
    while(True):
        # create backup folder
        backup_file()
        # show the menu
        menu = show_menu()

        if (menu == 1):
            menu_conf = configurate_menu("IP Address")
            if (menu_conf == 1):
                ip_addr_configure() # configure
            elif (menu_conf == 2):
                ip_addr_reconfigure() # reconfigure
            elif (menu_conf == 3):
                ip_addr_reconfigure # reconfigure
                ip_addr_configure() # configure

        elif (menu == 2):
            menu_conf = configurate_menu("DHCP Server")
            if (menu_conf == 1):
                dhcp_server_configure() # configure
            elif (menu_conf == 2):
                dhcp_server_reconfigure() # reconfigure
            elif (menu_conf == 3):
                dhcp_server_reconfigure # reconfigure
                dhcp_server_configure() # configure

        elif (menu == 3):
            menu_conf = configurate_menu("DNS Server")
            if (menu_conf == 1):
                dns_configure() # configure
            elif (menu_conf == 2):
                dns_reconfigure() # reconfigure
            elif (menu_conf == 3):
                dns_reconfigure # reconfigure
                dns_configure() # configure

        elif (menu == 4):
            pass
        elif (menu == 5):
            break