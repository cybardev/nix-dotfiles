{ lib, pkgs, ... }:
let
  position-displays = pkgs.writeShellScriptBin "position-displays.sh" ''
    ${lib.getExe pkgs.xrandr} --output DP-1 --mode 1920x1080 --pos 0x0 --rotate normal --primary &
    ${lib.getExe pkgs.xrandr} --output DP-2 --mode 1920x1080 --pos 0x0 --rotate normal --primary &
    ${lib.getExe pkgs.xrandr} --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal --primary &
    ${lib.getExe pkgs.xrandr} --output HDMI-2 --mode 1920x1080 --pos 0x0 --rotate normal --primary &
    wait
    ${lib.getExe pkgs.xrandr} --output eDP-1 --mode 1920x1080 --pos 0x1080 --rotate normal
  '';
  fix-touchscreen = pkgs.writeShellScriptBin "fix-touchscreen.sh" ''
    ${lib.getExe pkgs.xinput} map-to-output "Wacom Pen and multitouch sensor Finger" eDP-1
    ${lib.getExe pkgs.xinput} map-to-output "Wacom Pen and multitouch sensor Pen Pen (0xb110c613)" eDP-1
  '';
  set-screens = "${lib.getExe position-displays} && ${lib.getExe fix-touchscreen}";
  strange = start: end: lib.map lib.toString (lib.range start end);
in
{
  xsession.windowManager.bspwm = {
    enable = true;
    monitors = {
      DP-1 = strange 1 5;
      DP-2 = strange 1 5;
      eDP-1 = (strange 6 9) ++ [ "0" ];
    };
    startupPrograms = [
      "xfce4-session"
      "xfce4-power-manager --daemon"
      set-screens
    ];
    settings = {
      focus_follows_pointer = true;
      pointer_follows_focus = true;
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
      "Xfce4-appfinder" = {
        state = "floating";
        border = false;
        focus = true;
        layer = "above";
      };
      "Wrapper-2.0" = {
        state = "floating";
        border = false;
        focus = true;
        layer = "above";
      };
      "Xfce4-panel" = {
        state = "floating";
        layer = "above";
      };
    };
  };

  services.sxhkd = {
    enable = true;
    keybindings = {
      # fix touchscreen
      "super + shift + grave" = set-screens;
      # terminal
      "super + grave" = "kitty";
      # app launcher
      "super + space" = "xfce4-appfinder";
      # logoff dialogue
      "super + Escape" = "xfce4-session-logout";
      # screeenshot (menu | region to clipboard)
      "alt + {1,2}" = "xfce4-screenshooter -{-,r -c}";
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
