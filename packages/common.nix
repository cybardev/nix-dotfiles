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
    packages =
      (with cypkgs; [
        cutefetch
        jitterbugpair
        freej2me
        logseq
        ytgo
      ])
      ++ (with pkgs; [
        nixfmt-rfc-style
        nix-search-cli
        gnome-mahjongg
        signal-desktop
        imagemagick
        lazydocker
        syncthing
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
        gimp
        ncdu
        nixd
        hugo
        wget
        unar
        go
        # love
        luajit
      ])
      ++ (with pkgs.python3Packages; [
        ptpython
      ])
      ++ (with pkgs.luajitPackages; [
        luarocks
      ]);

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
