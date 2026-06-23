MONIKA ARCH BUILD

Boot:
  UEFI
   └─ systemd-boot
       ├─ linux
       └─ linux-lts

Filesystem:
  Btrfs
   ├─ @              /
   ├─ @home          /home
   ├─ @snapshots     /.snapshots
   └─ @pkg           /var/cache/pacman/pkg

Snapshots:
  snapper
   ├─ snap-pac hooks
   ├─ pacman checkpoints only
   ├─ no timeline snapshots
   ├─ max 10 snapshots
   └─ automatic cleanup

Desktop:
  uwsm
   └─ Hyprland

Core:
  Alacritty
  Neovim
  tmux
  Waybar
  Wofi
  swaync

Audio:
  PipeWire
  WirePlumber

Hardware:
  Mesa
  Vulkan Intel
  Bluetooth
  TLP
