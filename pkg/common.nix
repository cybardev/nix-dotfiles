{
  pkgs,
  config,
  flakePath,
  userConfig,
  ...
}:
let
  nixConfigDir = userConfig.nixos;
in
{
  xdg.configFile = {
    # Custom Kitty Icon
    # License: MIT Copyright: 2024, Andrew Haust <https://github.com/sodapopcan/kitty-icon>
    "kitty/kitty.app.png".source = ../cfg/kitty.app.png;
    "ptpython/config.py".source = ../cfg/ptpython.py;
    "mpv/mpv.conf".source = ../cfg/mpv.conf;
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

    shellAliases =
      let
        uncivDir = "${config.xdg.configHome}/Unciv";
      in
      {
        # shell conveniences
        x = "exit";
        clr = "clear";
        cls = "clear";
        cat = "bat -pp";
        icat = "kitten icat";
        ls = "eza -1 --icons=never";
        ll = "eza -1l";
        lessr = "less -R";
        tree = "eza --tree";
        py = "ptpython";
        yt = "ytgo -i -m -p";
        cf = "cutefetch";
        bf = "cutefetch -m bunny";
        tf = "cutefetch -m text";
        cd-os = "cd ${nixConfigDir}";

        # editing related
        edit = "nvim";
        edit-vim = "(cd ${nixConfigDir}/cfg/nvim && nvim)";
        edit-os = "nvim ${nixConfigDir}/flake.nix";

        # reloading configs
        re-hm = "nh home switch";
        re-hm-fast = "home-manager switch --flake ${nixConfigDir}";

        # package management
        yin = "nix-shell -p";
        yang = "nh search";
        wuji = "sudo -H nix-collect-garbage -d && nix-collect-garbage -d";
        yup = "nix flake update --flake ${flakePath} && re-nix";

        # misc
        unly = "f() { curl -Is '$1' | grep ^location | cut -d ' ' -f 2 }; f";
        etch = "f() { sudo dd bs=4M if=$2 of=/dev/$1 status=progress oflag=sync }; f";
        civ = "mkdir -p ${uncivDir} && unciv --data-dir=${uncivDir}";
      };

    packages =
      (with pkgs.cy; [
        cutefetch
        jitterbugpair
        freej2me
        pyrefly
        logseq
        ytgo
      ])
      ++ (with pkgs; [
        gnome-mahjongg
        lazydocker
        babashka
        inkscape
        audacity
        dfu-util
        thonny
        bruno
        gimp
        hugo
        ncdu
        unciv

        # >---< DO NOT REMOVE >---< #
        nixfmt-rfc-style
        nixfmt-tree
        imagemagick
        syncthing
        coreutils
        nix-init
        visidata
        poppler
        cmatrix
        gnugrep
        openssl
        luajit
        ccache
        p7zip
        cmake
        ninja
        nixd
        nurl
        curl
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

    fd = {
      enable = true;
      ignores = [
        ".git/"
        "*.bak"
      ];
      extraOptions = [ "--color=always" ];
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

    ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
  };
}
