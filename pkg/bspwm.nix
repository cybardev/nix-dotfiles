{
  # manage X session in home-manager
  xsession.enable = true;
  # config $XDG_CONFIG_HOME and such
  xdg.userDirs.enable = true;

  dconf.settings = {
    "org/gnome/desktop/wm/preferences".theme = "Qogir-dark";
    "org/gnome/desktop/interface" = {
      gtk-theme = "Qogir-Dark";
      icon-theme = "WhiteSur-dark";
      cursor-theme = "Bibata-Modern-Ice";
      cursor-size = 36;
    };
  };

  xsession.windowManager.bspwm = {
    enable = true;
    monitors = {
      HDMI-1 = [
        "m"
        "e"
        "n"
        "u"
      ];
      # eDP-1 = [
      #   "s"
      # ];
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
      "xfce4-panel" = {
        state = "floating";
        layer = "above";
      };
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
      # terminal
      "super + grave" = "kitty";
      # app launcher
      "super + space" = "xfce4-appfinder";
      # logoff dialogue
      "super + Escape" = "xfce4-session-logout";
      # restart hotkey daemon
      "super + alt + Escape" = "pkill -USR1 -x sxhkd";
      # quit/restart bspwm
      "super + alt + {q,r}" = "bspc {quit,wm -r}";
      # quit/kill window
      "super + {_,shift + }w" = "bspc node -{c,k}";
      # switch tiled/monocle layout
      "super + m" = "bspc desktop -l next";
      # send the newest marked node to the newest preselected node
      "super + y" = "bspc node newest.marked.local -n newest.!automatic.local";
      # swap the current node and the biggest window
      "super + g" = "bspc node -s biggest.window";
      # set window state
      "super + shift + {t,s,f,m}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
      # focus the node in the given direction
      "super + {_,shift + }{Left,Down,Up,Right}" = "bspc node -{f,s} {west,south,north,east}";
      # focus the next/previous window in the current desktop
      "super + {_,shift + }{Tab}" = "bspc node -f {next,prev}.local.!hidden.window";
      # focus the next/previous desktop in the current monitor
      "alt + {_,shift + }{Tab}" = "bspc desktop -f {next,prev}.local";
      # focus the older or newer node in the focus history
      "super + {o,i}" = "bspc wm -h off; bspc node {older,newer} -f; bspc wm -h on";
      # focus or send to the given desktop
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
      # expand a window by moving one of its side outward
      "super + alt + {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
      # contract a window by moving one of its side inward
      "super + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
      # move a floating window
      "super + {h,j,k,l}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
      # preselect the direction
      # "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";
      # preselect the ratio
      # "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";
      # cancel the preselection for the focused node
      # "super + ctrl + space" = "bspc node -p cancel";
      # cancel the preselection for the focused desktop
      # "super + ctrl + shift + space" = "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";
    };
  };
}
