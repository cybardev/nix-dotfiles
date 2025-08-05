{ config, ... }:
let
  nixConfigDir = config.userConfig.configDir;
  brewInit = shell: ''
    eval "$(/opt/homebrew/bin/brew shellenv ${shell})"
  '';
  shellAliases = {
    lsblk = "diskutil list";
    edit-wm = "edit ${nixConfigDir}/packages/config/aerospace.nix";
    re-nix = "nh darwin switch";
    icloud = "cd ~/Library/Mobile\\ Documents/com~apple~CloudDocs";

    flux = "/Applications/Pokemon\\ Flux/Flux.app/Contents/MacOS/Z-universal";
    flux-up = "/Applications/Pokemon\\ Flux/Flux\\ Patcher.app/Contents/MacOS/Flux\\ Patcher";
  };
in
{
  imports = [
    ./common.nix
    ./aerospace.nix
  ];

  userConfig.isDarwin = true;

  home.file.".config/karabiner".source = ../cfg/karabiner;

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

    cava.settings.input = {
      method = "portaudio";
      source = "BlackHole 16ch";
    };
  };
}
