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
    ./shells.nix
    ./terminal.nix
    ./helix.nix
    ./opencode.nix
    ./pi.nix
    ./vscode.nix
    ./zed.nix
    ./cava.nix
  ]
  ++ (with inputs.cypkgs.modules; [
    tenere
  ]);

  xdg.configFile = {
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

    packages =
      (with pkgs.cy; [
        cutefetch
        jitterbugpair
        # freej2me
        ytgo
      ])
      ++ (with pkgs; [
        tree-sitter-grammars.tree-sitter-dart
        typescript-language-server
        postgres-language-server
        # gnome-mahjongg
        # dotnet-sdk_9
        pgformatter
        clojure-lsp
        # cloudflared
        # lazydocker
        # localstack
        # tailscale
        opentofu
        babashka
        tinymist
        # audacity
        gdevelop
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
        ripgrep-all
        nixfmt-tree
        imagemagick
        syncthing
        coreutils
        nix-init
        visidata
        prettier
        cmatrix
        gnugrep
        ripgrep
        openssl
        pistol
        luajit
        ccache
        nixfmt
        p7zip
        cmake
        ninja
        gopls
        mupdf
        nixd
        nurl
        curl
        wget
        # unar
        # timg
        bun
        fzf
        go
      ])
      ++ (with pkgs.python3Packages; [
        jedi-language-server
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
      # config.global.load_dotenv = true;
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

    broot = {
      enable = false;
      settings = {
        modal = true;
        syntax_theme = "EightiesDark";
        kitty_graphics_display = "direct";
        default_flags = "--sort-by-type-dirs-first -c :open_preview";
        preview_transformers = [
          {
            input_extensions = [ "pdf" ];
            output_extension = "png";
            mode = "image";
            command = [ "mutool" "draw" "-w" "1000" "-o" "{output-path}" "{input-path}" ];
          }
          {
            input_extensions = [ "mkv" "mp4" "webm" "avi" "mov" "flv" "wmv" "m4v" "mpg" "mpeg" "3gp" ];
            output_extension = "png";
            mode = "image";
            command = [ "ffmpegthumbnailer" "-s" "1000" "-o" "{output-path}" "-i" "{input-path}" ];
          }
        ];
      };
    };

    fzf = {
      enable = true;
      defaultOptions = [
        "--height 40%"
        "--border rounded"
        "--layout reverse"
      ];
      changeDirWidget = {
        command = "zoxide query --list --score";
        options = [
          "--nth 2.. --accept-nth 2.. --scheme=path --exact --tiebreak=pathname,index"
        ];
      };
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
      # package = (
      #   pkgs.mpv.override {
      #     mpv-unwrapped = pkgs.mpv-unwrapped.override {
      #       ffmpeg = pkgs.ffmpeg-full;
      #     };
      #     youtubeSupport = true;
      #     scripts = with pkgs.mpvScripts; [
      #       sponsorblock-minimal
      #       visualizer
      #       uosc
      #     ];
      #   }
      # );
    };

    poetry = {
      enable = false;
      settings.virtualenvs.in-project = true;
    };

    tenere = {
      enable = false;
      config = {
        llm = "chatgpt";
        chatgpt = {
          model = "MLX-Qwopus3.5-9B-Coder-oQ4-fp16-mtp";
          url = "https://lm.polydactyl-little.ts.net/v1/chat/completions";
          openai_api_key = "";
        };
      };
    };

    ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "*" = {
          AddKeysToAgent = "yes";
        };
      };
    };

    man.generateCaches = false;
  };

  manual.manpages.enable = false;

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
