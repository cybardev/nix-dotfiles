{ pkgs, ... }: {
  imports = [ <home-manager/nixos> ];

  home-manager.users.sage = { ... }: {
    home.packages = with pkgs; [
      (callPackage ./cutefetch.nix {})
      (callPackage ./ytgo.nix {})
      nix-search-cli
      xorg.xdpyinfo
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

