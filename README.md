```
.
├── flake.nix
├── machines    # per-machine configs + combinations of modules and users
│   ├── darwin
│   └── nixos
├── modules     # composable modules
│   ├── darwin
│   ├── nixos
│   └── shared
└── users       # user setup
    └── kuba
```

# Installation

## MacOS

### 1. Install dependencies
```sh
xcode-select --install
```

### 2. Install Nix
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

## NixOS

Create a root password using the TTY
```bash
sudo su
passwd
```

Enable flakes
```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

All of the below must be run with root permissions.

Partition and mount the main drive using [disko](https://github.com/nix-community/disko)
```bash
DISK='/dev/disk/by-id/nvme-CT1000P3SSD8_235245DA7E95'
curl https://raw.githubusercontent.com/kmazurek/nix-config/main/disko/btrfs-root/default.nix -o /tmp/disko.nix
sed -i "s|replace-during-installation|$DISK|" /tmp/disko.nix
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix
```

Preparing data drives (left fully manual for safety)
```bash
mkfs.btrfs -m raid1 -d raid1 -L cache /dev/cache-disk-1 /dev/cache-disk-2
```

```bash
mkfs.xfs -L parity1 /dev/parity-drive
mkfs.xfs -L data1 /dev/data-drive1
mkfs.xfs -L data2 /dev/data-drive2
```

As a last resort:
```bash
wipefs -a $DISK
```
