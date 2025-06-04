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
        edit-wm = "edit ${nixConfigDir}/packages/config/aerospace.nix";
        re-nix = "sudo darwin-rebuild switch --flake ${flakePath}";

        flux = "/Applications/Pokemon\\ Flux/Flux.app/Contents/MacOS/Z-universal";
        flux-up = "/Applications/Pokemon\\ Flux/Flux\\ Patcher.app/Contents/MacOS/Flux\\ Patcher";
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
