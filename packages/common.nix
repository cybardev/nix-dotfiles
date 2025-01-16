{ pkgs, ... }:
{
  imports = [
    ./config/zsh.nix
    ./config/yazi.nix
    ./config/kitty.nix
    ./config/vscode.nix
    ./config/utils.nix
  ];

  home.packages = with pkgs; [
    (callPackage ./custom/ptpython.nix { })
    (callPackage ./custom/cutefetch.nix { })
    (callPackage ./custom/ytgo.nix { })
    nixfmt-rfc-style
    nix-search-cli
    imagemagick
    visidata
    poppler
    cmatrix
    ffmpeg
    yt-dlp
    neovim
    gitui
    p7zip
    hugo
    wget
    mpv
    bat
    eza
    go
    # love
    luajit
    luajitPackages.luarocks
  ];

  # Dotfiles
  home.file = {
    # AstroNvim config
    ".config/nvim".source = pkgs.fetchFromGitHub {
      owner = "cybardev";
      repo = "astronvim_config";
      rev = "5fa712012937324f2c87eb720514a6a5090a5357";
      hash = "sha256-s1qKv5BoHmc5aNWdVOx47SiYnfSVFgHWG43BVHFR644=";
    };

    # Zen.zsh shell prompt
    ".config/zsh/zen".source = pkgs.fetchFromGitHub {
      owner = "cybardev";
      repo = "zen.zsh";
      rev = "2a9f44a19c8fc9c399f2d6a62f4998fffc908145";
      hash = "sha256-s/YLFdhCrJjcqvA6HuQtP0ADjBtOqAP+arjpFM2m4oQ=";
    };

    # ptpython config
    ".config/ptpython/config.py".text = builtins.readFile (
      pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/cybardev/dotfiles/d1c0266755b4f31b9e828884a7ee5b9fb12964f2/config/ptpython/config.py";
        hash = "sha256-c917shJDEotfSSbXIi+m3Q/KioKkf20YG82UyhUu3lI=";
      }
    );
  };

  # set $EDITOR to nvim
  home.sessionVariables.EDITOR = "nvim";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";
}
