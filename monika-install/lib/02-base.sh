#!/bin/bash

set -e


echo "[+] Detecting CPU"


CPU_VENDOR=$(grep vendor_id /proc/cpuinfo | head -1)


EXTRA_PACKAGES=""


if echo "$CPU_VENDOR" | grep -q GenuineIntel
then
    echo "Intel CPU detected"

    EXTRA_PACKAGES="
    intel-ucode
    vulkan-intel
    "

elif echo "$CPU_VENDOR" | grep -q AuthenticAMD
then
    echo "AMD CPU detected"

    EXTRA_PACKAGES="
    amd-ucode
    vulkan-radeon
    "

else
    echo "Unknown CPU"
fi



echo "[+] Installing base system"


pacstrap -K /mnt \
$(cat packages/base.txt) \
$EXTRA_PACKAGES



echo "[+] Generating fstab"


genfstab -U /mnt >> /mnt/etc/fstab



echo "$CPU_VENDOR" > /mnt/tmp/monika-cpu
