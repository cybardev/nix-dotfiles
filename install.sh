#!/usr/bin/env bash -e

NIXOS_CONFIG_DIR="$HOME/.config/nixos"

git clone "https://github.com/cybardev/nixos-dotfiles.git" "$NIXOS_CONFIG_DIR"

sudo mv "/etc/nixos" "/etc/nixos.bak"

sudo ln -s "$NIXOS_CONFIG_DIR" "/etc/nixos"

mv "$NIXOS_CONFIG_DIR/system/hardware-configuration.nix" "$NIXOS_CONFIG_DIR/system/hardware-configuration.nix.bak"
cp "/etc/nixos.bak/hardware-configuration.nix" "$NIXOS_CONFIG_DIR/system/"

sudo nix-channel --add "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz" home-manager

if [[ "$SURFACE_KERNEL" -eq 1 ]]; then
    sudo nix-channel --add "https://github.com/NixOS/nixos-hardware/archive/b12e314726a4226298fe82776b4baeaa7bcf3dcd.tar.gz" nixos-hardware
    SURFACE_CONFIG="-I nixos-config=$NIXOS_CONFIG_DIR"
fi

sudo nix-channel --update

sudo nixos-rebuild switch $SURFACE_CONFIG
