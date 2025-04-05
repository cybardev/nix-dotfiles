{
  pkgs,
  userConfig,
  ...
}:
let
  nixConfigDir = userConfig.nixos;
in
{
  home = {
    packages = with pkgs; [
      # TIP: don't add GUI apps here; use brew instead
    ];

    file = {
      ".config/karabiner" = {
        source = ../cfg/karabiner;
        recursive = true;
      };
    };
  };

  programs = {
    zsh = {
      shellAliases = {
        lsblk = "diskutil list";
        edit-wm = "nvim ${nixConfigDir}/packages/config/aerospace.nix";
        re-nix = "darwin-rebuild switch --flake ${nixConfigDir}";
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
