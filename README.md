# nix-config

Personal NixOS, nix-darwin, and Home Manager configurations.

## Quick Start

### Install NixOS

1. Clone this repo:
```bash
git clone https://github.com/yourusername/nix-config.git ~/nix-config
cd ~/nix-config
```

2. Install NixOS:
```bash
sudo nixos-rebuild switch --flake .#hostname
```

3. Install Home Manager:
```bash
home-manager switch --flake .#username@hostname
```

### Install on macOS

```bash
darwin-rebuild switch --flake .#hostname
home-manager switch --flake .#username@hostname
```

## Usage

### Update

Update all inputs:
```bash
nix flake update
```

Update specific input:
```bash
nix flake update nixpkgs
```

### List Generations

List NixOS generations:
```bash
sudo nixos-rebuild list-generations
```

List Home Manager generations:
```bash
home-manager generations
```

Rollback to previous generation:
```bash
# NixOS
sudo nixos-rebuild switch --rollback

# Home Manager
home-manager generations  # find the generation number
/nix/store/<generation-path>/activate
```

Delete old generations:
```bash
# NixOS - delete specific generations (e.g., 1 2 3 4)
sudo nix-env --delete-generations 1 2 3 4 --profile /nix/var/nix/profiles/system

# NixOS - delete all old generations (keeps current)
sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system

# Home Manager - delete generations older than 2 days
home-manager expire-generations "-2 days"

# Run garbage collection to free disk space
sudo nix-collect-garbage -d
```

### Rebuild

**NixOS:**
```bash
sudo nixos-rebuild switch --flake .#hostname
```

**macOS:**
```bash
darwin-rebuild switch --flake .#hostname
```

**Home Manager:**
```bash
home-manager switch --flake .#username@hostname
```

## Adding Systems

### Add a new NixOS host

1. Create host directory:
```bash
mkdir -p hosts/new-hostname
```

2. Create `hosts/new-hostname/default.nix`:
```nix
{ config, pkgs, userConfig, nixosModules, ... }:

{
  imports = [
    ./hardware.nix
    "${nixosModules}/core"
    # Add other modules as needed
  ];

  networking.hostName = "new-hostname";
  system.stateVersion = "25.11";
}
```

3. Generate hardware config:
```bash
nixos-generate-config --show-hardware-config > hosts/new-hostname/hardware.nix
```

4. Add to `flake.nix`:
```nix
nixosConfigurations = {
  new-hostname = mkNixosConfiguration "new-hostname" "username";
};
```

### Add Home Manager config

1. Create home directory:
```bash
mkdir -p home/username/hostname
```

2. Create `home/username/hostname/default.nix`:
```nix
{ config, pkgs, userConfig, hmModules, ... }:

{
  imports = [
    "${hmModules}/core"
    # Add program modules
  ];

  home = {
    username = "username";
    homeDirectory = "/home/username";
    stateVersion = "25.11";
  };
}
```

3. Add to `flake.nix`:
```nix
homeConfigurations = {
  "username@hostname" = mkHomeConfiguration "x86_64-linux" "username" "hostname";
};
```

## Adding Users

1. Add user to `flake.nix` users section:
```nix
users = {
  newuser = {
    name = "newuser";
    fullName = "New User";
    email = "user@example.com";
  };
};
```

2. Create home configuration:
```bash
mkdir -p home/newuser/hostname
```

3. Reference in NixOS config (`hosts/hostname/default.nix`):
```nix
users.users.newuser = {
  isNormalUser = true;
  extraGroups = [ "wheel" "networkmanager" ];
};
```

## Structure

```
.
├── flake.nix           # Main flake configuration
├── hosts/              # System configurations
│   ├── asus-tuf/
│   ├── b450-desktop/
│   └── Codrut-Stefans-MacBook-Pro/
├── home/               # Home Manager configurations
│   ├── kreker71/
│   └── codrut.ursache/
└── modules/
    ├── nixos/          # Shared NixOS modules
    ├── darwin/         # Shared nix-darwin modules
    └── home-manager/   # Shared Home Manager modules
```
