#!/usr/bin/env bash -e

# set nixos config directory
NIXOS_CONFIG_DIR="$HOME/.config/nixos"

# clone into nixos config directory
git clone "https://github.com/cybardev/nixos-dotfiles.git" "$NIXOS_CONFIG_DIR"

# add required package channels channels
sudo -H nix-channel --add "https://nixos.org/channels/nixpkgs-24.11-darwin" nixpkgs
sudo -H nix-channel --add "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz" home-manager
sudo -H nix-channel --add "https://github.com/LnL7/nix-darwin/archive/nix-darwin-24.11.tar.gz" darwin
sudo -H nix-channel --update

# rebuild system from config
nix-build '<darwin>' -A darwin-rebuild
./result/bin/darwin-rebuild switch -I "darwin-config=$NIXOS_CONFIG_DIR/configuration-darwin.nix"
