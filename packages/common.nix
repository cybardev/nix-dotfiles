{
  pkgs,
  inputs,
  ...
}:
let
  cypkgs = inputs.cypkgs.packages.${pkgs.system};
in
{
  imports = [
    ./config/zsh.nix
    ./config/yazi.nix
    ./config/kitty.nix
    ./config/vscode.nix
    ./config/utils.nix
  ];

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
      # logseq
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
      unar
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
  };
}
