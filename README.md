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

From your host, copy the public SSH key to the server
```bash
ssh-add ~/.ssh/notthebee
ssh-copy-id -i ~/.ssh/notthebee root@<NIXOS-IP>
ssh root@<NIXOS-IP>
```

Enable flakes
```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

Partition and mount the drives using [disko](https://github.com/nix-community/disko)
```bash
DISK='/dev/disk/by-id/ata-Samsung_SSD_870_EVO_250GB_S6PENL0T902873K'

curl https://raw.githubusercontent.com/notthebee/nix-config/main/disko/zfs-root/default.nix \
    -o /tmp/disko.nix
sed -i "s|to-be-filled-during-installation|$DISK|" /tmp/disko.nix
nix --experimental-features "nix-command flakes" run github:nix-community/disko \
    -- --mode disko /tmp/disko.nix
```
