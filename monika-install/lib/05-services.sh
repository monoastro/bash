#!/bin/bash

set -e


echo "[+] Enabling services"


cat > /mnt/tmp/monika-services.sh <<'EOF'

#!/bin/bash

set -e



systemctl enable NetworkManager


systemctl enable bluetooth


systemctl enable tlp


systemctl enable fstrim.timer


systemctl enable snapper-cleanup.timer



# Explicitly avoid boot delay

systemctl disable NetworkManager-wait-online.service || true


EOF



chmod +x /mnt/tmp/monika-services.sh


arch-chroot /mnt /tmp/monika-services.sh
