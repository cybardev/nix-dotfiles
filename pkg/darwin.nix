{
  flakePath,
  userConfig,
  ...
}:
let
  nixConfigDir = userConfig.nixos;
in
{
  home.file.".config/karabiner".source = ../cfg/karabiner;

  programs = {
    zsh = {
      shellAliases = {
        lsblk = "diskutil list";
        edit-wm = "nvim ${nixConfigDir}/packages/config/aerospace.nix";
        re-nix = "darwin-rebuild switch --flake ${flakePath}";
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
