{ lib, pkgs, ... }:
let
  cypkgs = import <cypkgs> {
    inherit pkgs;
  };
in
{
  imports = [
    ./config/zsh.nix
    ./config/yazi.nix
    ./config/kitty.nix
    ./config/vscode.nix
    ./config/utils.nix
  ];

  nix = {
    package = lib.mkDefault pkgs.nixFlakes;
    gc = {
      automatic = true;
      frequency = "monthly";
    };
    # settings.experimental-features = [
    #   "nix-command"
    #   "flakes"
    # ];
  };

  home = {
    packages = with pkgs; [
      # cypkgs
      cypkgs.cutefetch
      cypkgs.jitterbugpair
      cypkgs.freej2me
      cypkgs.ytgo

      # nixpkgs
      python3Packages.ptpython
      nixfmt-rfc-style
      nix-search-cli
      gnome-mahjongg
      signal-desktop
      imagemagick
      lazydocker
      lunarvim
      babashka
      dfu-util
      visidata
      inkscape
      poppler
      cmatrix
      openssl
      zoom-us
      logseq
      thonny
      ccache
      p7zip
      cmake
      ninja
      bruno
      brave
      gimp
      ncdu
      nixd
      hugo
      wget
      rar
      go
      # love
      luajit
      luajitPackages.luarocks
    ];

    file = {
      ".config/lvim/config.lua".source = ./config/lvim.lua;
      ".config/lvim/ftplugin/nix.lua".source = ./config/lvim-nix.lua;
      ".config/ptpython/config.py".source = ./config/ptpython.py;
    };

    # environment variables
    sessionVariables = {
      EDITOR = "lvim";
      PTPYTHON_CONFIG_HOME = "$HOME/.config/ptpython/";
    };

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.11";
  };
}
