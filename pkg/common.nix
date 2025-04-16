{
  pkgs,
  flakePath,
  ...
}: {
  xdg.configFile = {
    # Custom Kitty Icon
    # License: MIT Copyright: 2024, Andrew Haust <https://github.com/sodapopcan/kitty-icon>
    "kitty/kitty.app.png".source = ../cfg/kitty.app.png;
    "ptpython/config.py".source = ../cfg/ptpython.py;
    "nvim" = {
      source = ../cfg/nvim;
      recursive = true;
    };
    # "lf" = {
    #   source = ../cfg/lf;
    #   recursive = true;
    # };
  };

  home = {
    # environment variables
    sessionVariables = {
      PTPYTHON_CONFIG_HOME = "$HOME/.config/ptpython/";
    };

    packages =
      (with pkgs.cy; [
        cutefetch
        jitterbugpair
        freej2me
        logseq
        ytgo
      ])
      ++ (with pkgs; [
        signal-desktop-bin
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
        imagemagick
        syncthing
        alejandra
        nix-init
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
        nurl
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
    nh = {
      enable = true;
      flake = flakePath;
    };

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

    neovim = {
      enable = true;
      defaultEditor = true;
      withNodeJs = true;
      extraPackages = with pkgs; [
        gcc
        gnumake
        ripgrep
      ];
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

    # lf = {
    #   enable = true;
    #   settings = {
    #     number = true;
    #     relativenumber = true;
    #     icons = true;
    #     sortby = "ext";
    #   };
    # };

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
