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
