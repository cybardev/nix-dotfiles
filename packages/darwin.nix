{ pkgs, userConfig, ... }:
let
  nixConfigDir = userConfig.nixos;
in
{
  imports = [
    ./common.nix

    ./config/aerospace.nix
  ];

  home = {
    packages = with pkgs; [
      # TIP: don't add GUI apps here; use brew instead
    ];

    file = {
      ".config/karabiner" = {
        source = ./config/karabiner;
        recursive = true;
      };
    };
  };

  programs = {
    zsh = {
      shellAliases = {
        edit-wm = "nvim ${nixConfigDir}/packages/config/aerospace.nix";
        re-nix = "darwin-rebuild switch --flake ${nixConfigDir}#darwin";
        re-hm = "home-manager switch --flake ${nixConfigDir}#darwin";
      };
      profileExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
    };

    cava.settings.input = {
      method = "portaudio";
      source = "'Background Music'";
    };
  };
}
