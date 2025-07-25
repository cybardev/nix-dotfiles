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
    ../mod/userconfig.nix
    ../sys/home.nix
    ./zsh.nix
    ./fish.nix
    ./helix.nix
    ./vscode.nix
    ./zed.nix
    ./cava.nix
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
        cssh = "kitten ssh";
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
        ldk = lib.getExe pkgs.lazydocker;
        lck = lib.getExe pkgs.localstack;
        civ = "mkdir -p ${uncivDir} && unciv --data-dir=${uncivDir}";
      };

    packages =
      (with pkgs-unstable.cy; [
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
        localstack
        tailscale
        babashka
        tinymist
        inkscape
        audacity
        dfu-util
        thonny
        black
        bruno
        gimp
        tdf
        ncdu
        unciv

        # >---< DO NOT REMOVE >---< #
        ffmpegthumbnailer
        nixfmt-rfc-style
        ripgrep-all
        nixfmt-tree
        imagemagick
        syncthing
        coreutils
        nix-init
        visidata
        cmatrix
        gnugrep
        ripgrep
        openssl
        pistol
        luajit
        ccache
        p7zip
        cmake
        ninja
        gopls
        mupdf
        nixd
        nurl
        curl
        wget
        unar
        fzf
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
      themeFile = "Kanagawa_dragon";
      enableGitIntegration = true;
      font = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font Mono";
        size = 14;
      };
      settings = {
        # shell = lib.getExe pkgs.zsh;
        shell = lib.getExe pkgs.zsh + " -c " + lib.getExe pkgs.fish;
        tab_bar_edge = "top";
        enabled_layouts = "tall";
        enable_audio_bell = false;
        background_opacity = 0.96;
        update_check_interval = 0;
        hide_window_decorations = "yes";
        startup_session = builtins.toString ../cfg/kitty-session.sh;
      };
      keybindings = {
        "super+." = "layout_action bias 64";
        "super+[" = "previous_window";
        "super+]" = "next_window";
      };
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
      commands.open = ''
        ''${{
          case $(file --mime-type -Lb $f) in
            application/pdf) ${lib.getExe pkgs.tdf} $fx;;
            *) for f in $fx; do $OPENER $f > /dev/null 2> /dev/null & done;;
          esac
        }}
      '';
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
        gpg.format = "ssh";
        user.signingKey = "~/.ssh/id_ed25519.pub";
        commit.gpgSign = true;
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
