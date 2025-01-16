{ config, pkgs, ... }:
{
  imports = [
    ./system/darwin.nix
  ];

  users.users.sage = {
    name = "sage";
    home = /Users/sage;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # vim
  ];

  # Use custom location for configuration.nix.
  environment.darwinConfig = "$HOME/.config/nixos/configuration-darwin.nix";

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
