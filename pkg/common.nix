{
  pkgs,
  inputs,
  ...
}:
let
  cypkgs = import inputs.cypkgs { inherit pkgs; };
in
{
  home = {
    # environment variables
    sessionVariables = {
      EDITOR = "lvim";
      PTPYTHON_CONFIG_HOME = "$HOME/.config/ptpython/";
    };

    file = {
      # Custom Kitty Icon
      # License: MIT Copyright: 2024, Andrew Haust <https://github.com/sodapopcan/kitty-icon>
      ".config/kitty/kitty.app.png".source = ../cfg/kitty.app.png;
      ".config/lvim" = {
        source = ../cfg/lvim;
        recursive = true;
      };
      ".config/ptpython/config.py".source = ../cfg/ptpython.py;
    };

    packages =
      (with cypkgs; [
        cutefetch
        jitterbugpair
        freej2me
        logseq
        ytgo
      ])
      ++ (with pkgs; [
        signal-desktop
        gnome-mahjongg
        lazydocker
        babashka
        inkscape
        dfu-util
        zoom-us
        thonny
        bruno
        gimp
        hugo
        ncdu
        # love

        # >---< DO NOT REMOVE >---< #
        nixfmt-rfc-style
        nix-search-cli
        imagemagick
        syncthing
        lunarvim
        visidata
        poppler
        cmatrix
        openssl
        luajit
        ccache
        p7zip
        cmake
        ninja
        nixd
        wget
        unar
        go
      ])
      ++ (with pkgs.python3Packages; [
        ptpython
      ])
      ++ (with pkgs.luajitPackages; [
        luarocks
      ]);
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    kitty = {
      enable = true;
      themeFile = "Doom_Vibrant";
      settings = {
        shell = "zsh";
        font_family = "CaskaydiaCove Nerd Font Mono";
        font_size = 14;
        enable_audio_bell = false;
        tab_bar_edge = "top";
        background_opacity = 0.96;
      };
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd"
        "cd"
      ];
    };

    bat = {
      enable = true;
      config.theme = "OneHalfDark";
    };

    eza = {
      enable = true;
      colors = "auto";
      git = true;
      icons = "auto";
      extraOptions = [
        "--group-directories-last"
        "--sort=extension"
      ];
    };

    bottom = {
      enable = true;
      settings.styles.theme = "nord";
    };

    mpv = {
      enable = true;
      package = (
        pkgs.mpv-unwrapped.wrapper {
          mpv = pkgs.mpv-unwrapped.override {
            ffmpeg = pkgs.ffmpeg-full;
          };
          youtubeSupport = true;
          scripts = with pkgs.mpvScripts; [
            sponsorblock-minimal
            visualizer
            uosc
          ];
        }
      );
    };

    cava = {
      enable = true;
      settings = {
        general = {
          bars = 0;
          bar_width = 6;
          bar_spacing = 2;
        };
        color = {
          gradient = 1;
          gradient_count = 2;
          gradient_color_1 = "'#bb7ebb'";
          gradient_color_2 = "'#ffbeff'";
        };
        output.method = "ncurses";
        smoothing.gravity = 42;
      };
    };

    poetry = {
      enable = true;
      settings.virtualenvs.in-project = true;
    };

    git = {
      enable = true;
      package = pkgs.gitFull;
      userName = "cybardev";
      userEmail = "50134239+cybardev@users.noreply.github.com";
      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "store";
        pull.rebase = false;
      };
    };

    gitui = {
      enable = true;
      theme = ../cfg/gitui-catppuccin.ron;
    };
  };
}
