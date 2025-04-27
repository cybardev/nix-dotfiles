{
  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;
    fadeDelta = 4;
    activeOpacity = 0.96;
    inactiveOpacity = 0.76;
    menuOpacity = 1.0;
    settings = {
      blur.method = "dual_kawase";
    };
    shadow = true;
    vSync = true;

    opacityRules = [
      "96:class_g = 'Wrapper-2.0'"
      "100:class_g = 'Brave-browser' && !_NET_WM_STATE@:32a"
      "100:class_g = 'mpv' && !_NET_WM_STATE@:32a"
      "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
    ];

    wintypes = {
      dock = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = true;
      };
      toolbar = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      menu = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      utility = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      splash = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      dialog = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      dropdown_menu = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      popup_menu = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      tooltip = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      notification = {
        shadow = true;
        blur-background = false;
        full-shadow = true;
        fade = true;
      };
      combo = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      dnd = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      unknown = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
    };
  };
}
