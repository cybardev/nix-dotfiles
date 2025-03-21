#!/usr/bin/env bash -e

# set nixos config directory
NIXOS_CONFIG_DIR="$HOME/.config/nixos"

# clone into nixos config directory
git clone "https://github.com/cybardev/nix-dotfiles.git" "$NIXOS_CONFIG_DIR"

# rebuild system from config
nix run nix-darwin/master#darwin-rebuild -- switch --flake "$NIXOS_CONFIG_DIR#darwin"
