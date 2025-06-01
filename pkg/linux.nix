{
  pkgs,
  flakePath,
  userConfig,
  ...
}:
let
  nixConfigDir = userConfig.nixos;
in
{
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
      edit-wm = "nvim ${nixConfigDir}/packages/config/bspwm.nix";
      re-nix = "nixos-rebuild switch --use-remote-sudo --flake ${flakePath}";
    };

    chromium = {
      enable = true;
      package = pkgs.brave;
      dictionaries = with pkgs.hunspellDictsChromium; [
        en_US
        en_GB
      ];
      extensions = [
        "dmghijelimhndkbmpgbldicpogfkceaj" # dark mode
        "pejdijmoenmkgeppbflobdenhhabjlaj" # iCloud passwords
        "ponfpcnoihfmfllpaingbgckeeldkhle" # enhancer for youtube
        "gebbhagfogifgggkldgodflihgfeippi" # return youtube dislike
        "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock for youtube
      ];
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
