#!/bin/bash

set -e


echo "[+] Configuring Snapper"



cat > /mnt/tmp/monika-snapper.sh <<'EOF'

#!/bin/bash

set -e



echo "[+] Creating snapper config"


# We already have @snapshots mounted.
# Snapper wants to create its own folder, so temporarily move ours.

umount /.snapshots


mv /.snapshots /.snapshots.bak



snapper -c root create-config /



rm -rf /.snapshots


mv /.snapshots.bak /.snapshots



mount -a



echo "[+] Applying Monika snapshot policy"



sed -i \
's/^TIMELINE_CREATE=.*/TIMELINE_CREATE="no"/' \
/etc/snapper/configs/root



sed -i \
's/^NUMBER_LIMIT=.*/NUMBER_LIMIT="10"/' \
/etc/snapper/configs/root



sed -i \
's/^NUMBER_LIMIT_IMPORTANT=.*/NUMBER_LIMIT_IMPORTANT="3"/' \
/etc/snapper/configs/root



sed -i \
's/^NUMBER_CLEANUP=.*/NUMBER_CLEANUP="yes"/' \
/etc/snapper/configs/root



sed -i \
's/^TIMELINE_LIMIT_HOURLY=.*/TIMELINE_LIMIT_HOURLY="0"/' \
/etc/snapper/configs/root


sed -i \
's/^TIMELINE_LIMIT_DAILY=.*/TIMELINE_LIMIT_DAILY="0"/' \
/etc/snapper/configs/root


sed -i \
's/^TIMELINE_LIMIT_MONTHLY=.*/TIMELINE_LIMIT_MONTHLY="0"/' \
/etc/snapper/configs/root


sed -i \
's/^TIMELINE_LIMIT_YEARLY=.*/TIMELINE_LIMIT_YEARLY="0"/' \
/etc/snapper/configs/root




echo "[+] Creating baseline snapshot"


snapper create \
--description "Monika fresh install"


EOF



chmod +x /mnt/tmp/monika-snapper.sh


arch-chroot /mnt /tmp/monika-snapper.sh
