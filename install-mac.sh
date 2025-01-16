#!/usr/bin/env bash -e

# set nixos config directory
NIXOS_CONFIG_DIR="$HOME/.config/nixos"

# clone into nixos config directory
git clone "https://github.com/cybardev/nixos-dotfiles.git" "$NIXOS_CONFIG_DIR"

# add home-manager channel
sudo nix-channel --add "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz" home-manager

# update nix channels
sudo nix-channel --update

# rebuild system from config
sudo darwin-rebuild switch -I "$NIXOS_CONFIG_DIR/configuration-darwin.nix"
