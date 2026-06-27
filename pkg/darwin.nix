{ config, pkgs, ... }:
let
  userName = config.userConfig.username;
  nixConfigDir = config.userConfig.configDir;
  brewInit = shell: ''
    eval "$(/opt/homebrew/bin/brew shellenv ${shell})"
  '';
  shellAliases = {
    lsblk = "diskutil list";
    edit-wm = "edit ${nixConfigDir}/packages/config/aerospace.nix";
    re-nix = "nh darwin switch";
    icloud = "cd '~/Library/Mobile Documents/com~apple~CloudDocs'";
    disclr = "ncdu /System/Volumes/Data/Users/${userName}";
    ts = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
    cr = "coderabbit";

    flux = "/Applications/Pokemon\\ Flux/Flux.app/Contents/MacOS/Z-universal";
    flux-up = "/Applications/Pokemon\\ Flux/Flux\\ Patcher.app/Contents/MacOS/Flux\\ Patcher";
  };
in
{
  imports = [
    ../sys/darwin-link-apps.nix
    ./common.nix
    ./aerospace.nix
    ./rift.nix
  ];

  userConfig.isDarwin = true;

  home = {
    sessionVariables = {
      OMLX_PORT = 1234;
    };

    file = {
      # ".config/karabiner".source = ../cfg/karabiner;
      # ".config/rift/config.toml".source = ../cfg/rift.toml;
    };

    packages = with pkgs; [
      raycast
      utm
    ];
  };

  programs = {
    zsh = {
      inherit shellAliases;
      profileExtra = ''
        ${brewInit "zsh"}
      '';
    };
    fish = {
      inherit shellAliases;
      shellInit = ''
        ${brewInit "fish"}
      '';
    };
    nushell = {
      inherit shellAliases;
    };
    kitty.settings = {
      background_blur = 4;
      macos_option_as_alt = "yes";
    };

    cava.settings.input = {
      method = "portaudio";
      source = "BlackHole 16ch";
    };
  };
}
