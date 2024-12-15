{ pkgs, ... }: {
  imports = [ <home-manager/nixos> ];

  home-manager.users.sage = { ... }: {
    # manage X session in home-manager
    xsession.enable = true;
    # config $XDG_CONFIG_HOME and such
    xdg.userDirs.enable = true;

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
        normal_border_color = "#44476a";
        active_border_color = "#bd94f9";
        focused_border_color = "#ff80c6";
        presel_feedback_color = "#6273a4";
      };
      rules = {
        "xfce4-appfinder".state = "floating";
        "xfce4-panel".state = "floating";
      };
    };

    services.picom = {
      enable = true;
      backend = "glx";
      fade = true;
      fadeDelta = 4;
      activeOpacity = 0.86;
      inactiveOpacity = 0.76;
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
  };
}

