#!/bin/bash

set -e


echo "[+] Partitioning disk"


wipefs -af "$DISK"

sgdisk -Z "$DISK"

sgdisk \
-n1:0:+1G \
-t1:ef00 \
-c1:EFI \
-n2:0:0 \
-t2:8300 \
-c2:ARCH \
"$DISK"


if [[ "$DISK" == *"nvme"* ]]
then
    EFI="${DISK}p1"
    ROOT="${DISK}p2"
else
    EFI="${DISK}1"
    ROOT="${DISK}2"
fi


mkfs.fat -F32 "$EFI"

mkfs.btrfs -f "$ROOT"



mount "$ROOT" /mnt


btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@pkg


umount /mnt


OPTS=noatime,compress=zstd:3,ssd,discard=async,space_cache=v2


mount -o $OPTS,subvol=@ "$ROOT" /mnt


mkdir -p \
/mnt/home \
/mnt/.snapshots \
/mnt/boot \
/mnt/var/cache/pacman/pkg


mount -o $OPTS,subvol=@home "$ROOT" /mnt/home

mount -o $OPTS,subvol=@snapshots "$ROOT" /mnt/.snapshots

mount -o $OPTS,subvol=@pkg "$ROOT" /mnt/var/cache/pacman/pkg


mount "$EFI" /mnt/boot
