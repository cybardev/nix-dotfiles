{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.userConfig) flakePath;
in
{
  imports = [
    ../mod/userconfig.nix
    ../sys/nixcommand.nix
    ../sys/home.nix
    ./browser.nix
    ./searxng.nix
    ./git.nix
    ./zsh.nix
    ./fish.nix
    ./helix.nix
    ./opencode.nix
    ./vscode.nix
    ./zed.nix
    ./cava.nix
  ]
  ++ (with inputs.cypkgs.modules; [
    tenere
  ]);

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
    "jjui/themes/base16-kanagawa-dragon.toml".source = ../cfg/jjui-kanagawa-dragon.toml;
  };

  home = {
    file = {
      ".continue/config.yaml".source = ../cfg/continue.yaml;
      ".katrain" = {
        source = ../cfg/katrain-theme/woodstone;
        recursive = true;
      };
    };

    # environment variables
    sessionVariables = {
      PTPYTHON_CONFIG_HOME = "$HOME/.config/ptpython/";
      OLLAMA_HOST = "0.0.0.0:11434";
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
        top = "btm --basic";
        ls = "eza -1 --icons=never";
        ll = "eza -1l";
        lessr = "less -R";
        tree = "eza --tree";
        py = "ptpython";
        yt = "ytgo -i -m -p";
        cf = "cutefetch";
        bf = "cutefetch -m bunny";
        sf = "cutefetch -m simple";
        nf = "cutefetch -m text";
        gf = "grep -rn . -e";

        # editing related
        e = "hx";
        eos = "e ${flakePath}";

        # reloading configs
        re-hm = "nh home switch";
        re-hm-fast = "home-manager switch --flake ${flakePath}";

        # package management
        yin = "nix-shell -p";
        yang = "nh search";
        wuji = "sudo -H nix-collect-garbage -d && nix-collect-garbage -d";
        yup = "nix flake update --flake ${flakePath} && re-nix";

        # misc
        tf = lib.getExe pkgs.opentofu;
        lg = lib.getExe pkgs.lazygit;
        ldk = lib.getExe pkgs.lazydocker;
        lck = lib.getExe pkgs.localstack;
        civ = "mkdir -p ${uncivDir} && unciv --data-dir=${uncivDir}";
      };

    packages =
      (with pkgs.cy; [
        cutefetch
        jitterbugpair
        freej2me
        ytgo
      ])
      ++ (with pkgs; [
        tree-sitter-grammars.tree-sitter-dart
        typescript-language-server
        postgres-language-server
        # gnome-mahjongg
        dotnet-sdk_9
        pgformatter
        clojure-lsp
        cloudflared
        lazydocker
        # localstack
        # tailscale
        opentofu
        babashka
        tinymist
        # audacity
        # gdevelop
        dfu-util
        # thonny
        pyrefly
        gofumpt
        rustup
        gifski
        gnugo
        gogui
        unciv
        # bruno
        ruff
        ncdu
        tdf

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
        bun
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
        enabled_layouts = "splits";
        enable_audio_bell = false;
        background_opacity = 0.96;
        update_check_interval = 0;
        hide_window_decorations = "yes";
        startup_session = builtins.toString ../cfg/kitty-session.sh;
      };
      keybindings = {
        "super+enter" = "launch --location=split";
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

    fzf = {
      enable = true;
      defaultOptions = [
        "--height 40%"
        "--border rounded"
        "--layout reverse"
      ];
      changeDirWidgetCommand = "zoxide query --list --score";
      changeDirWidgetOptions = [
        "--nth 2.. --accept-nth 2.. --scheme=path --exact --tiebreak='pathname,index'"
      ];
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd"
        "c"
      ];
    };

    bat = {
      enable = true;
      config.theme = "kanagawa-dragon";
      themes = {
        kanagawa-dragon.src = ../cfg/kanagawa-dragon.tmTheme;
      };
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

    tenere = {
      enable = false;
      config = {
        llm = "chatgpt";
        chatgpt = {
          model = "neuraldaredevil-8b-abliterated";
          url = "http://localhost:1234/v1/chat/completions";
          openai_api_key = "";
        };
      };
    };

    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*" = {
        addKeysToAgent = "yes";
      };
    };

    man.generateCaches = false;
  };

  services = {
    ollama = {
      enable = false;
      host = "0.0.0.0";
      environmentVariables = {
        OLLAMA_CONTEXT_LENGTH = 131072;
        OLLAMA_ORIGINS = lib.concatStringsSep "," [
          "http://0.0.0.0"
          "http://localhost"
          "https://airi.moeru.ai"
        ];
      };
    };
  };
}
