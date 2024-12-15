{ pkgs, ... }: {
  imports = [ <home-manager/nixos> ];

  home-manager.backupFileExtension = "hm.bak";
  home-manager.users.sage = { ... }: {
    # Software to install
    home.packages = with pkgs; [
      (callPackage ./packages/cutefetch.nix {})
      (callPackage ./packages/ytgo.nix {})
      nix-search-cli
      xorg.xdpyinfo
      qogir-icon-theme
      qogir-theme
      nerdfonts
      ffmpeg
      yt-dlp
      neovim
      fondo
      gitui
      rustc
      brave
      pipx
      mpv
      bat
      eza
      feh
      go
    ];

    # set $EDITOR to nvim
    home.sessionVariables.EDITOR = "nvim";

    # Poetry for Python
    programs.poetry = {
      enable = true;
      settings.virtualenvs.in-project = true;
    };

    # Bottom
    programs.bottom = {
      enable = true;
      settings.styles.theme = "nord";
    };

    # Git
    programs.git = {
      enable = true;
      package = pkgs.gitFull;
      userName = "cybardev";
      userEmail = "sheikh@cybar.dev";
      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "store";
      };
    };

    # Z-shell
    programs.zsh = {
      dotDir = ".config/zsh";
      enable = true;
      autocd = true;
      enableCompletion = true;
      defaultKeymap = "viins";
      autosuggestion.enable = true;
      autosuggestion.strategy = [ "history" "completion" "match_prev_cmd" ];
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      history = {
        save = 1024;
        size = 2048;
        share = true;
        append = true;
        ignoreAllDups = true;
        path = "$ZDOTDIR/history";
      };
      initExtra = ''
        path+=( "$(go env GOPATH)/bin" "$HOME/.local/bin" )
        cutefetch

        fpath+="$ZDOTDIR/zen"
        autoload -Uz promptinit
        promptinit
        prompt zen

        function etch() {
          sudo dd bs=4M if=$2 of=/dev/$1 status=progress oflag=sync
        }
      '';
      shellAliases = {
        # shell conveniences
        x = "exit";
        cf = "cutefetch";
        clr = "clear";
        cls = "clear";
        tree = "eza --tree --group-directories-last --sort=extension";

        # editing related
        edit = "nvim";
        edit-vim = "nvim ~/.config/nvim/lua/plugins/user.lua";
        edit-os = "nvim ~/.config/nixos/home.nix";

        # reloading configs
        rebuild-os = "sudo nixos-rebuild switch";
        zrc = ". $ZDOTDIR/.zshrc";

        # package management
        yin = "nix-shell -p";
        yang = "nix-search";
        yup = "sudo nixos-rebuild switch --upgrade";

        # utilities
        yt = "ytgo -i -m -p";
      };
    };

    # File Manager
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      shellWrapperName = "fm";
      settings = {
        manager = {
          sort_by = "extension";
          sort_dir_first = true;
        };
        opener.text = [
          { run = "$EDITOR '$@'"; block = true; for = "unix"; }
        ];
      };
      initLua = ''
        require("relative-motions"):setup({ show_numbers="relative_absolute", show_motion = true })
      '';
      keymap = {
        manager.prepend_keymap = [
          { run = "plugin relative-motions --args=1"; on = [ "1"]; }
          { run = "plugin relative-motions --args=2"; on = [ "2"]; }
          { run = "plugin relative-motions --args=3"; on = [ "3"]; }
          { run = "plugin relative-motions --args=4"; on = [ "4"]; }
          { run = "plugin relative-motions --args=5"; on = [ "5"]; }
          { run = "plugin relative-motions --args=6"; on = [ "6"]; }
          { run = "plugin relative-motions --args=7"; on = [ "7"]; }
          { run = "plugin relative-motions --args=8"; on = [ "8"]; }
          { run = "plugin relative-motions --args=9"; on = [ "9"]; }
        ];
      };
    };

    # Kitty Terminal
    programs.kitty = {
      enable = true;
      themeFile = "DarkOneNuanced";
      settings = {
        shell = "zsh";
        font_family = "CaskaydiaCove Nerd Font Mono";
        font_size = 14;
        enable_audio_bell = false;
        tab_bar_edge = "top";
      };
    };

    # VS Code
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = with pkgs.vscode-extensions; [
        zhuangtongfa.material-theme
        vscodevim.vim
      ];
    };

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
    };

    xsession.windowManager.bspwm = {
      enable = true;
      monitors = {
        eDP-1 = [ "m" "e" "n" "u" ];
      };
      startupPrograms = [
        "xfce4-power-manager --daemon"
        "xfce4-session"
      ];
      settings = {
        border_width = 2;
        window_gap = 12;
        split_ratio = 0.52;
        gapless_monocle = true;
        borderless_monocle = true;
        normal_border_color = "#44475a"
        active_border_color = "#bd93f9"
        focused_border_color = "#ff79c6"
        presel_feedback_color = "#6272a4"
      };
      rules = {
        "xfce4-appfinder".state = "floating";
      };
    };

    services.picom = {
      enable = true;
      backend = "glx";
      fade = true;
      fadeDelta = 4;
      activeOpacity = 0.96;
      inactiveOpacity = 0.86;
      menuOpacity = 1.0;
      settings = {
        blur.method = "dual_kawase";
      };
      shadow = true;
      # vSync = true;
    };

    services.sxhkd = {
      enable = true;
      keybindings = {
        "super + grave" = "kitty";
        "super + space" = "xfce4-appfinder";
        "super + Escape" = "pkill -USR1 -x sxhkd";
        "super + alt + Escape" = "xfce4-session-logout";
        "super + alt + {q,r}" = "bspc {quit,wm -r}";
        "super + {_,shift + }w" = "bspc node -{c,k}";
        "super + m" = "bspc desktop -l next";
        "super + y" = "bspc node newest.marked.local -n newest.!automatic.local";
        "super + g" = "bspc node -s biggest.window";
        "super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
        "super + {_,shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}";
        "super + {_,shift + }c" = "bspc node -f {next,prev}.local.!hidden.window";
        "super + bracket{left,right}" = "bspc desktop -f {prev,next}.local";
        "super + {Return,Tab}" = "bspc {node,desktop} -f last";
        "super + {o,i}" = "bspc wm -h off; bspc node {older,newer} -f; bspc wm -h on";
        "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
        "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";
        "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";
        "super + ctrl + space" = "bspc node -p cancel";
        "super + ctrl + shift + space" = "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";
        "super + alt + {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
        "super + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
        "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
      };
    };

    xsession.enable = true;
    xdg.userDirs.enable = true;

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "24.11";
  };
}

