{
  config,
  pkgs,
  inputs,
  ...
}:
let
  inherit (config.userConfig) flakePath;
  nixConfigDir = config.userConfig.configDir;
in
{
  imports = [
    inputs.nur.modules.homeManager.default
    inputs.zen-browser.homeModules.beta
    ../sys/gtk.nix
    ./common.nix
    ./bspwm.nix
    ./picom.nix
    ./browser.nix
  ];

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
      logseq
      zoom-us
      aseprite
      lunar-client
      altserver-linux
      signal-desktop-bin
    ];
  };

  programs = {
    zsh.shellAliases = {
      fondo = "com.github.calo001.fondo";
      edit-wm = "edit ${nixConfigDir}/packages/config/bspwm.nix";
      re-nix = "nixos-rebuild switch --use-remote-sudo --flake ${flakePath}";
    };
  };

  services = {
    home-manager = {
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
    gnome-keyring.enable = true;
  };

  # manage X session in home-manager
  xsession.enable = true;
  # config $XDG_CONFIG_HOME and such
  xdg.userDirs.enable = true;

  dconf.settings = {
    "org/gnome/desktop/wm/preferences".theme = "Qogir-dark";
  };
}
