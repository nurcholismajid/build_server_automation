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
    console.print("------------------------------")
    menu = int(input("Pilih Menu : "))
    return menu

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
    os.system(f'echo -e "      address {ip_address}" >> /etc/network/interfaces')
    os.system(f'echo -e "      gateway {gateway}" >> /etc/network/interfaces')

    # restarting network
    os.system('/etc/init.d/networking restart')
    os.system('service networking restart')
    os.system('clear')
    os.system('ip addr');input()


if __name__ == "__main__":
    while(True):
        # create backup folder
        backup_file()
        # show the menu
        menu = show_menu()
        
        if (menu == 1):
            ip_addr_configure()

        elif (menu == 2):
            pass
        elif (menu == 3):
            pass
        elif (menu == 4):
            pass