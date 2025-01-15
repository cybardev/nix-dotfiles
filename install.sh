#!/usr/bin/env bash -e

git clone "https://github.com/cybardev/nixos-dotfiles.git" ~/.config/nixos

sudo mv /etc/nixos /etc/nixos.bak

sudo ln -s "$HOME/.config/nixos" /etc/nixos

mv ~/.config/nixos/hardware-configuration.nix ~/.config/nixos/hardware-configuration.nix.bak
cp /etc/nixos.bak/hardware-configuration.nix ~/.config/nixos/

sudo nix-channel --add "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz" home-manager

if [[ "$SURFACE_KERNEL" -eq 1 ]]; then
    sudo nix-channel --add "https://github.com/NixOS/nixos-hardware/archive/b12e314726a4226298fe82776b4baeaa7bcf3dcd.tar.gz" nixos-hardware
    mv ~/.config/nixos/system.nix ~/.config/nixos/system.nix.bak
    mv ~/.config/nixos/system-surface.nix ~/.config/nixos/system.nix
fi

sudo nix-channel --update

sudo nixos-rebuild switch
