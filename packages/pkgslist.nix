{ pkgs, ... }: {
  imports = [ <home-manager/nixos> ];

  home-manager.users.sage = { ... }: {
    home.packages = with pkgs; [
      (callPackage ./ptpython.nix {})
      (callPackage ./cutefetch.nix {})
      (callPackage ./ytgo.nix {})
      nix-search-cli
      xorg.xdpyinfo
      xfce.xfce4-verve-plugin
      xfce.xfce4-systemload-plugin
      xfce.xfce4-whiskermenu-plugin
      xfce.xfce4-weather-plugin
      whitesur-icon-theme
      qogir-icon-theme
      qogir-theme
      nerdfonts
      ffmpeg
      yt-dlp
      neovim
      fondo
      gitui
      rustc
      brave
      pipx
      mpv
      bat
      eza
      feh
      go
    ];
  };
}

