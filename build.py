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

def ip_addr_reconfigure():
    backup_folder = f"{dir}/.backup"
    os.system(f"cp {backup_folder}/interfaces /etc/network/interfaces")
    
    # restarting network
    os.system('/etc/init.d/networking restart')
    os.system(f'ifup {interfaces}')
    os.system('service networking restart');input("Enter untuk kembali ke menu...")

if __name__ == "__main__":
    while(True):
        # create backup folder
        backup_file()
        # show the menu
        menu = show_menu()

        if (menu == 1):
            os.system("clear")
            console.print(" :ramen: [italic purple]Configuration[/italic purple] & [italic yellow]Reconfiguration[/italic yellow] [bold green]IP Address[/bold green]")
            console.print(" -------------------------------------------------------------------------")
            console.print(" :memo:", end="")
            recon = int(input(" Menu : (1). configure (2). setting ke awal (3). reconfigure (4). back: "))
            if (recon == 1):
                ip_addr_configure() # configure
            elif (recon == 2):
                ip_addr_reconfigure() # reconfigure
            elif (recon == 3):
                ip_addr_reconfigure # reconfigure
                ip_addr_configure() # configure

        elif (menu == 2):
            pass
        elif (menu == 3):
            pass
        elif (menu == 4):
            pass
        elif (menu == 5):
            break