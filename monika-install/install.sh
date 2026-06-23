#!/bin/bash

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

clear

echo "
███╗   ███╗ ██████╗ ███╗   ██╗██╗██╗  ██╗ █████╗
████╗ ████║██╔═══██╗████╗  ██║██║██║ ██╔╝██╔══██╗
██╔████╔██║██║   ██║██╔██╗ ██║██║█████╔╝ ███████║
██║╚██╔╝██║██║   ██║██║╚██╗██║██║██╔═██╗ ██╔══██║
██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██║██║  ██╗██║  ██║
╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝

Minimal Arch + Hyprland Installer
"


read -rp "Hostname: " HOST
read -rp "Username: " USERNAME

read -rp "Timezone [Asia/Kathmandu]: " TIMEZONE

TIMEZONE=${TIMEZONE:-Asia/Kathmandu}


echo
lsblk

echo

read -rp "Install disk (/dev/nvme0n1): " DISK


echo "
WARNING:
$DISK WILL BE ERASED
"

read -rp "Continue? (yes/no): " CONFIRM


if [[ "$CONFIRM" != "yes" ]]
then
    exit
fi


export HOST
export USERNAME
export TIMEZONE
export DISK


./lib/00-preflight.sh
./lib/01-disk.sh
./lib/02-base.sh
./lib/03-system.sh
./lib/04-snapper.sh
./lib/05-services.sh


echo "MONIKA INSTALL COMPLETE"
echo "reboot"
