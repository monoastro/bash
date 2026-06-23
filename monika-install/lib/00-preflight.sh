#!/bin/bash

set -e

echo "[+] Checking UEFI"

if [ ! -d /sys/firmware/efi ]
then
    echo "Not booted in UEFI mode"
    exit 1
fi


echo "[+] Checking internet"

ping -c 2 archlinux.org


timedatectl set-ntp true

command -v sgdisk >/dev/null || {
    echo "sgdisk missing"
    exit 1
}
