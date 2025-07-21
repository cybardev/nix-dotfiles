{
  config,
  ...
}:
let
  inherit (config.userConfig) flakePath;
  nixConfigDir = config.userConfig.configDir;
in
{
  imports = [
    ./common.nix
    ./aerospace.nix
    ../mod/userconfig.nix
  ];

  userConfig.isDarwin = true;

  home.file.".config/karabiner".source = ../cfg/karabiner;

  programs = {
    zsh = {
      shellAliases = {
        lsblk = "diskutil list";
        edit-wm = "edit ${nixConfigDir}/packages/config/aerospace.nix";
        re-nix = "sudo darwin-rebuild switch --flake ${flakePath}";

        flux = "/Applications/Pokemon\\ Flux/Flux.app/Contents/MacOS/Z-universal";
        flux-up = "/Applications/Pokemon\\ Flux/Flux\\ Patcher.app/Contents/MacOS/Flux\\ Patcher";
      };
      profileExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv zsh)"
      '';
    };
    fish.shellInit = ''
      eval "$(/opt/homebrew/bin/brew shellenv fish)"
    '';

    cava.settings.input = {
      method = "portaudio";
      source = "BlackHole 2ch";
    };
  };
}
