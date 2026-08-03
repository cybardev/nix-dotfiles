{ pkgs, ... }:
{
  xdg.configFile = {
    # Custom Kitty Icon
    # License: MIT Copyright: 2024, Andrew Haust <https://github.com/sodapopcan/kitty-icon>
    "kitty/kitty.app.png".source = ../cfg/kitty.app.png;
    # "wezterm" = {
    #   source = ../cfg/wezterm;
    #   recursive = true;
    # };
  };

  programs = {
    wezterm.enable = false;

    ghostty = {
      enable = false;
      settings = {
        theme = "Kanagawa Dragon";
        font-size = 14;
        font-thicken = true;
        bold-is-bright = true;
        split-inherit-working-directory = true;
        tab-inherit-working-directory = true;
        window-inherit-working-directory = false;
        # keybind = [
        #   "ctrl+h=goto_split:left"
        #   "ctrl+l=goto_split:right"
        # ];
      };
    };

    kitty = {
      enable = true;
      themeFile = "kanagawa_dragon";
      enableGitIntegration = true;
      font = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font Mono";
        size = 14;
      };
      settings = {
        cursor_trail = 1;
        tab_bar_edge = "top";
        enabled_layouts = "splits";
        enable_audio_bell = false;
        background_opacity = 0.96;
        update_check_interval = 0;
        hide_window_decorations = "yes";
        startup_session = toString ../cfg/kitty-session.sh;
      };
      keybindings = {
        "super+enter" = "launch --cwd=current --location=split";
        "super+." = "layout_action bias 64";
        "super+[" = "previous_window";
        "super+]" = "next_window";
        "super+w" = "close_window";
        "super+shift+w" = "close_tab";
      };
    };
  };
}
