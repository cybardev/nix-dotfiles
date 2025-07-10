{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
let
  inherit (config.userConfig) flakePath;
in
{
  imports = [
    ../sys/overlays.nix
    ../sys/unfree.nix
    ../sys/home.nix
    ./zsh.nix
    ./helix.nix
    ./vscode.nix
    ./zed.nix
  ];

  xdg.configFile = {
    # Custom Kitty Icon
    # License: MIT Copyright: 2024, Andrew Haust <https://github.com/sodapopcan/kitty-icon>
    "kitty/kitty.app.png".source = ../cfg/kitty.app.png;
    "ptpython/config.py".source = ../cfg/ptpython.py;
    "mpv/mpv.conf".source = ../cfg/mpv.conf;
    "lf" = {
      source = ../cfg/lf;
      recursive = true;
    };
  };

  home = {
    file = {
      ".continue/config.yaml".source = ../cfg/continue.yaml;
    };

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
        fm = "f() { cd \"$(${lib.getExe pkgs.lf} -print-last-dir \"$@\")\" }; f";
        ls = "eza -1 --icons=never";
        ll = "eza -1l";
        lessr = "less -R";
        tree = "eza --tree";
        py = "ptpython";
        yt = "ytgo -i -m -p";
        cf = "cutefetch";
        bf = "cutefetch -m bunny";
        tf = "cutefetch -m text";
        cd-os = "cd ${flakePath}";

        # editing related
        edit = "hx";
        edit-os = "edit ${flakePath}/flake.nix";

        # reloading configs
        re-hm = "nh home switch";
        re-hm-fast = "home-manager switch --flake ${flakePath}";

        # package management
        yin = "nix-shell -p";
        yang = "nh search";
        wuji = "sudo -H nix-collect-garbage -d && nix-collect-garbage -d";
        yup = "nix flake update --flake ${flakePath} && re-nix";

        # misc
        fan = "f() { du -hd1 \"$1\" | sort -hr }; f";
        unly = "f() { curl -Is \"$1\" | grep ^location | cut -d \" \" -f 2 }; f";
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
        tree-sitter-grammars.tree-sitter-dart
        gnome-mahjongg
        dotnet-sdk_9
        clojure-lsp
        lazydocker
        babashka
        tinymist
        inkscape
        audacity
        dfu-util
        thonny
        black
        bruno
        gimp
        hugo
        ncdu
        unciv

        # >---< DO NOT REMOVE >---< #
        ffmpegthumbnailer
        nixfmt-rfc-style
        poppler-utils
        nixfmt-tree
        imagemagick
        syncthing
        coreutils
        nix-init
        visidata
        cmatrix
        gnugrep
        openssl
        pistol
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
        jedi-language-server
        ptpython
      ])
      ++ (with pkgs.nodePackages; [
        prettier
      ])
      ++ (with pkgs.luajitPackages; [
        luarocks
      ]);
  };

  programs = {
    neovim.enable = true;

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
      enableGitIntegration = true;
      font = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font Mono";
        size = 14;
      };
      settings = {
        shell = "zsh";
        tab_bar_edge = "top";
        enable_audio_bell = false;
        background_opacity = 0.96;
        update_check_interval = 0;
        enabled_layouts = "tall:bias=56;full_size=1";
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

    lf = {
      enable = true;
      settings = {
        number = true;
        relativenumber = true;
        icons = true;
        sortby = "ext";
        cleaner = "~/.config/lf/cleaner";
        previewer = "~/.config/lf/previewer";
      };
      keybindings = {
        D = "delete";
        x = "cut";
      };
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

    ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
  };

  services = {
    ollama = {
      enable = true;
      package = pkgs-unstable.ollama;
      host = "0.0.0.0";
    };
  };
}
