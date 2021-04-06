import os
# from rich import print
# from rich.console import Console
# from rich.table import Table

# os.system("clear")
# table = Table(title="Build Server Interfaces :coffee:")

# table.add_column("MENU", justify="center", style="cyan", no_wrap=True)
# table.add_column("", style="yellow")

# table.add_row("1.", "Konfigurasi IP Address")
# table.add_row("2.", "Konfigurasi DHCP Server")
# table.add_row("3.", "Konfigurasi DNS Server")
# table.add_row("4.", "Konfigurasi WEB Server")

# console = Console()
# console.print(table)

f = os.popen("pwd")
dir = f.read().strip()

def backup_file():
    # create backup's folder
    create_folder = f"mkdir {dir}/.backup"
    os.system(create_folder)