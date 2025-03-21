{ pkgs, nixConfigDir, ... }:
{
  imports = [
    ./common.nix
  ];

  home = {
    packages = with pkgs; [
      # TIP: don't add GUI apps here; use brew instead
    ];

    file = {
      ".config/aerospace/aerospace.toml".source = ./config/aerospace.toml;
      ".config/karabiner" = {
        source = ./config/karabiner;
        recursive = true;
      };
    };
  };

  programs = {
    zsh.shellAliases = {
      re-nix = "darwin-rebuild switch --flake ${nixConfigDir}#darwin";
    };

    cava.settings.input = {
      method = "portaudio";
      source = "'Background Music'";
    };
  };
}
