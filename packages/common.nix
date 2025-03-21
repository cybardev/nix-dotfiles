{
  pkgs,
  inputs,
  ...
}:
let
  cypkgs = import inputs.cypkgs { inherit pkgs; };
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
    packages = builtins.attrValues {
      inherit (cypkgs)
        cutefetch
        jitterbugpair
        freej2me
        ytgo
        ;
      inherit (pkgs)
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
        ;
      inherit (pkgs.python3Packages)
        ptpython
        ;
      inherit (pkgs.luajitPackages)
        luarocks
        ;
    };

    file = {
      ".config/lvim" = {
        source = ./config/lvim;
        recursive = true;
      };
      ".config/ptpython/config.py".source = ./config/ptpython.py;
    };

    # environment variables
    sessionVariables = {
      EDITOR = "lvim";
      PTPYTHON_CONFIG_HOME = "$HOME/.config/ptpython/";
    };
  };
}
