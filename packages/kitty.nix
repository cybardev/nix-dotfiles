{ pkgs, ... }:
{
  imports = [ <home-manager/nixos> ];

  home-manager.users.sage =
    { ... }:
    {
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
    };
}
