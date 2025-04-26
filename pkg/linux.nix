{
  pkgs,
  flakePath,
  userConfig,
  ...
}: let
  nixConfigDir = userConfig.nixos;
in {
  home = {
    packages = with pkgs; [
      nerd-fonts.caskaydia-cove
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      xorg.xdpyinfo
      docker
      xclip
      unzip
      rustc
      fondo
      feh
      brave
      aseprite
      lunar-client
      altserver-linux
    ];
  };

  programs = {
    zsh.shellAliases = {
      fondo = "com.github.calo001.fondo";
      edit-wm = "nvim ${nixConfigDir}/packages/config/bspwm.nix";
      re-nix = "nixos-rebuild switch --use-remote-sudo --flake ${flakePath}";
    };
  };

  services.home-manager = {
    autoUpgrade = {
      enable = true;
      frequency = "weekly";
    };
    autoExpire = {
      enable = true;
      frequency = "weekly";
      timestamp = "-30 days";
      store = {
        cleanup = true;
        options = "--delete-older-than 30d";
      };
    };
  };
}
