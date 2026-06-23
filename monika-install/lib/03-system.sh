#!/bin/bash

set -e


cat > /mnt/tmp/monika-chroot.sh <<EOF

#!/bin/bash

set -e


echo "[+] Timezone"


ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

hwclock --systohc



echo "[+] Locale"


sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen

locale-gen


echo "LANG=en_US.UTF-8" > /etc/locale.conf



echo "[+] Hostname"


echo "$HOST" > /etc/hostname



cat > /etc/hosts <<HOSTS
127.0.0.1 localhost
::1 localhost
127.0.1.1 $HOST.localdomain $HOST
HOSTS




echo "[+] User"


useradd -mG wheel -s /bin/bash $USERNAME


echo "Set password for $USERNAME"

passwd $USERNAME



echo "[+] Root password"

passwd



echo "[+] Sudo"


sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers




echo "[+] Installing systemd-boot"


bootctl install



ROOT_UUID=\$(findmnt -no UUID /)



CPU=\$(cat /tmp/monika-cpu)


if echo \$CPU | grep -q GenuineIntel
then
    MICROCODE="intel-ucode.img"

else
    MICROCODE="amd-ucode.img"

fi



cat > /boot/loader/loader.conf <<LOADER
default arch.conf
timeout 3
console-mode max
editor no
LOADER




cat > /boot/loader/entries/arch.conf <<BOOT
title Arch Linux

linux /vmlinuz-linux

initrd /\$MICROCODE

initrd /initramfs-linux.img

options root=UUID=\$ROOT_UUID rootflags=subvol=@ rw
BOOT




cat > /boot/loader/entries/arch-lts.conf <<BOOT
title Arch Linux LTS

linux /vmlinuz-linux-lts

initrd /\$MICROCODE

initrd /initramfs-linux-lts.img

options root=UUID=\$ROOT_UUID rootflags=subvol=@ rw
BOOT

rm -f /tmp/monika-cpu
rm -f /tmp/monika-chroot.sh

EOF



chmod +x /mnt/tmp/monika-chroot.sh


arch-chroot /mnt /tmp/monika-chroot.sh
